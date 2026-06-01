rmdir /s /q V:\librusec
md V:\librusec\fb2
md V:\librusec\usr

for %%f in (*.zip) do (
	echo %%f | findstr /i ".fb2." >nul && (
		7z e "%%f" -oV:/librusec/fb2
	) || (
		7z e "%%f" -oV:/librusec/usr
	)	
)

7z a -mx9 -sdel V:\repacked\fb2-000000-999999.zip V:\librusec\fb2\*
7z a -mx0 -sdel V:\repacked\usr-000000-999999.zip V:\librusec\usr\*

rmdir /s /q V:\librusec
