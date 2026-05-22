md T:\librusec
del /Q T:\librusec\*.*

for %%f in (*.zip) do (
	7z e "%%f" -oT:\librusec
	echo %%f | findstr /i ".fb2." >nul && (
		7z a -mx9 V:\recoded\fb2-000000-999999.zip T:\librusec\*.*
	) || (
		7z a -mx0 V:\recoded\usr-000000-999999.zip T:\librusec\*.*
	)	
	del /Q T:\librusec\*.*
)

rmdir /s /q T:\librusec
