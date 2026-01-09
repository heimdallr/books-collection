del *.sql
del *.zip

for %%f in (t:\sql\*.gz) do (
	7z e "%%f" -o%~dp0
)
copy T:\sql\*.zip %~dp0
