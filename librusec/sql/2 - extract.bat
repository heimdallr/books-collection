del *.sql
del *.zip

7z x t:\sql\librusec\*.gz -o%~dp0 >nul 2>errors.txt
@if %errorlevel% neq 0 goto error
copy T:\sql\librusec\*.zip %~dp0
@del errors.txt

:error
@if exist errors.txt for %%I in (errors.txt) do if %%~zI gtr 0 type errors.txt
