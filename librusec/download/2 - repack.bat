md T:\librusec
del T:\librusec\*.fb2

for %%f in (*.zip) do (
	7z e "%%f" -oT:\librusec
	7z a fb2-000000-999999.zip T:\librusec\*.fb2
	del T:\librusec\*.fb2
)
