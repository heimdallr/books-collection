md T:\flibusta
del /Q T:\flibusta\*

for %%f in (f.n.*.zip) do (
	7z e "%%f" -oT:\flibusta
	7z a f.usr-000000-999999.zip T:\flibusta\*
	del /Q T:\flibusta\*
)

for %%f in (f.fb2.*.zip) do (
	7z e "%%f" -oT:\flibusta
	7z a f.fb2-000000-999999.zip T:\flibusta\*
	del /Q T:\flibusta\*
)

rmdir /s /q T:\flibusta
