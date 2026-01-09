md T:\flibusta
del T:\flibusta\*.fb2

for %%f in (*.zip) do (
	7z e "%%f" -oT:\flibusta
	7z a f.fb2-000000-999999.zip T:\flibusta\*.fb2
	del T:\flibusta\*.fb2
)
