param (
    [string]$targetDir
)

if ([string]::IsNullOrWhiteSpace($targetDir)) {
    Write-Error "Error: No target path provided to the script!"
    Read-Host "Press Enter to exit..."
    exit
}

if (-not (Test-Path -Path $targetDir -PathType Container)) {
    Write-Error "Error: Target folder '$targetDir' does not exist!"
    Read-Host "Press Enter to exit..."
    exit
}

Write-Host ""
Write-Host "Scanning folder: $targetDir"
Write-Host "--------------------------------------------------"

$target = $targetDir.TrimEnd('\')
$basePath = $target.TrimEnd('\') + '\'
$outputPath = (Split-Path -Path $targetDir -Leaf) + ".md5"
$tab = [char]9

# Создаём сортированный список с ASCII/Unicode сравнением без учёта регистра
$sortedMap = [System.Collections.Generic.SortedList[string, System.IO.FileInfo]]::new([System.StringComparer]::OrdinalIgnoreCase)

Get-ChildItem -LiteralPath $target -Recurse -File |
    Where-Object { $_.Name -ne $outputPath } |
    ForEach-Object {
        $parts = $_.FullName.Replace($basePath, '').Split('\')
        $keyParts = for ($i = 0; $i -lt $parts.Count; $i++) {
            if ($i -eq $parts.Count - 1) { "0_" + $parts[$i] } else { "1_" + $parts[$i] }
        }
        $sortedMap.Add(($keyParts -join '\'), $_)
    }

# Извлекаем готовый массив файлов в ASCII-порядке
$files = @($sortedMap.Values)

# Считаем общий размер папки и максимальную длину относительного пути
$stats = $files | Measure-Object -Property Length -Sum
$folderSize    = [long]$stats.Sum
$rawMaxPathLen = ($files | ForEach-Object { $_.FullName.Replace($basePath, '').Length } | Measure-Object -Maximum).Maximum

# Настраиваем формат и ширины колонок
$nfi = [System.Globalization.NumberFormatInfo]::new()
$nfi.NumberGroupSeparator = '`'

$totalLabel   = "Total ($($files.Count) files)"
$maxPathLen   = [Math]::Max([int]$rawMaxPathLen, [Math]::Max("File".Length, $totalLabel.Length))
$maxSizeWidth = [Math]::Max($folderSize.ToString("N0", $nfi).Length, "Size".Length)
$hashWidth    = 32 # Длина MD5-хеша всегда 32 символа

# Формируем шапку и разделитель
$hPath     = "File".PadRight($maxPathLen)
$hHash     = "MD5".PadRight($hashWidth)
$hSize     = "Size".PadLeft($maxSizeWidth)
$header    = "$hPath$tab$hHash$tab$hSize"
$separator = "$('-' * $maxPathLen)$tab$('-' * $hashWidth)$tab$('-' * $maxSizeWidth)"

# Обрабатываем файлы
$totalSize = 0L
[string[]]$report = @(foreach ($file in $files) {
    $relPath = $file.FullName.Replace($basePath, '').Replace('\', '/')
    $hashObj = Get-FileHash -LiteralPath $file.FullName -Algorithm MD5

    $percent = if ($folderSize -gt 0) { [Math]::Truncate(100L * $totalSize / $folderSize) } else { 100 }
    $sizeStr = $file.Length.ToString("N0", $nfi).PadLeft($maxSizeWidth)
    $pathStr = $relPath.PadRight($maxPathLen)

    Write-Host ("{0,3}%: {1} | {2}" -f $percent, $sizeStr, $relPath)

    $totalSize += $file.Length
    "$pathStr$tab$($hashObj.Hash.ToLower())$tab$sizeStr"
})

# Формируем итоговую строку Total
$tPath     = $totalLabel.PadRight($maxPathLen)
$tHash     = "".PadRight($hashWidth)
$tSize     = $totalSize.ToString("N0", $nfi).PadLeft($maxSizeWidth)
$totalLine = "$tPath$tab$tHash$tab$tSize"

# Пишем файл
$allLines = [string[]](@($header, $separator) + $report + @($separator, $totalLine))
$content = ($allLines -join "`n") + "`n"
[System.IO.File]::WriteAllText($outputPath, $content)

Write-Host "--------------------------------------------------"
Write-Host "$tPath$tab$tSize"
Write-Host ("Done! Results saved to {0}" -f $outputPath)
