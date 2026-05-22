set BOOK_TYPE=fb2

fliparser.exe ^
V:\books\%BOOK_TYPE%.librusec.7z\*.7z;%~dp0hash\%BOOK_TYPE% ^
-o t:\ ^
--dump T:\librusec.7z.db ^
--collection-info-template %~dp0collection_%BOOK_TYPE%.info
