rmdir /s /q V:\flibusta
md V:\flibusta\fb2
md V:\flibusta\usr

for %%f in (*.zip) do (
	echo %%f | findstr /i ".fb2." >nul && (
		7z e "%%f" -oV:/flibusta/fb2
	) || (
		7z e "%%f" -oV:/flibusta/usr
	)	
)

7z a -mx9 -sdel V:\repacked\f.fb2-000000-999999.zip V:\flibusta\fb2\*
7z a -mx0 -sdel V:\repacked\f.usr-000000-999999.zip V:\flibusta\usr\*

rmdir /s /q V:\flibusta
