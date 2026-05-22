md T:\flibusta
del /Q T:\flibusta\*

for %%f in (*.zip) do (
	7z e "%%f" -oT:\flibusta
	echo %%f | findstr /i ".fb2." >nul && (
		7z a -mx9 V:\recoded\f.fb2-000000-999999.zip T:\flibusta\*.*
	) || (
		7z a -mx0 V:\recoded\f.usr-000000-999999.zip T:\flibusta\*.*
	)	
	del /Q T:\flibusta\*.*
)

rmdir /s /q T:\flibusta
