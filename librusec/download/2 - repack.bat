rmdir /s /q V:\librusec
md V:\librusec\fb2
md V:\librusec\usr

for %%f in (*.fb2.zip) do (
	7z e "%%f" -oV:/librusec/fb2
)

for %%f in (*.epub.zip) do (
	7z e "%%f" -oV:/librusec/usr
)

7z a -mx9 -sdel V:\repacked\fb2-000000-999999.zip V:\librusec\fb2\*
7z a -mx0 -sdel V:\repacked\usr-000000-999999.zip V:\librusec\usr\*

rmdir /s /q V:\librusec
