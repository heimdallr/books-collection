del *.sql
del *.zip

for %%f in (t:\sql\librusec\*.gz) do (
	7z e "%%f" -o%~dp0
)
copy T:\sql\librusec\*.zip %~dp0
