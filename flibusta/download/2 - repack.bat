@rmdir /s /q V:\flibusta
@md V:\flibusta\fb2
@md V:\flibusta\usr
@if exist errors.txt del errors.txt

7z t "f.fb2.*-*.zip" >nul 2>errors.txt
@if %errorlevel% neq 0 goto error
7z t "f.n.*-*.zip" >nul 2>errors.txt
@if %errorlevel% neq 0 goto error
@del errors.txt

7z x "f.fb2.*-*.zip" -oV:/flibusta/fb2
7z x "f.n.*-*.zip" -oV:/flibusta/usr

7z a -mx9 -sdel V:\repacked\f.fb2-000000-999999.zip V:\flibusta\fb2\*
7z a -mx0 -sdel V:\repacked\f.usr-000000-999999.zip V:\flibusta\usr\*

@rmdir /s /q V:\flibusta

:error
@if exist errors.txt for %%I in (errors.txt) do if %%~zI gtr 0 type errors.txt
