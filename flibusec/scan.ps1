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
$tab = [char]9
$totalSize = [long]0
$folderSize = (Get-ChildItem -Path $target -Recurse -File -Force -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum

$report = Get-ChildItem -Path $target -Recurse -File | ForEach-Object {
    $relPath = $_.FullName.Replace($target + '\', '')
    
    $hashObj = Get-FileHash -Path $_.FullName -Algorithm MD5

    Write-Host ("Processed ({1}%): {0}" -f $relPath, [Math]::Truncate(100L * $totalSize / $folderSize))

    $lowHash = $hashObj.Hash.ToLower()
    $size = $_.Length
    $script:totalSize += $size
    
    $relPath + $tab + $lowHash + $tab + $size
}

$outputPath = Join-Path $PSScriptRoot "files.txt"
[System.IO.File]::WriteAllLines($outputPath, $report, [System.Text.Encoding]::UTF8)
[System.IO.File]::AppendAllText($outputPath, ("total:" + $tab + $totalSize + "`r`n"), [System.Text.Encoding]::UTF8)

Write-Host "--------------------------------------------------"
Write-Host "Done! Results saved to files.txt"
