del *.sql
del *.zip

for %%f in (t:\sql\flibusta\*.gz) do (
	7z e "%%f" -o%~dp0
)
copy T:\sql\flibusta\*.zip %~dp0
