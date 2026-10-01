@rmdir /s /q V:\librusec
@md V:\librusec\fb2
@md V:\librusec\usr
@if exist errors.txt del errors.txt

7z t "*.fb2.zip" >nul 2>errors.txt
@if %errorlevel% neq 0 goto error
7z t "*.epub.zip" >nul 2>errors.txt
@if %errorlevel% neq 0 goto error
@del errors.txt

7z x "*.fb2.zip" -oV:/librusec/fb2
7z x "*.epub.zip" -oV:/librusec/usr

7z a -mx9 -sdel V:\repacked\fb2-000000-999999.zip V:\librusec\fb2\*
7z a -mx0 -sdel V:\repacked\usr-000000-999999.zip V:\librusec\usr\*

@rmdir /s /q V:\librusec

:error
@if exist errors.txt for %%I in (errors.txt) do if %%~zI gtr 0 type errors.txt
