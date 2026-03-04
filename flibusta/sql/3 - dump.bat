if not exist t:/replace.db sqlite3.exe t:/replace.db ".read ../../common/replace.sql"

flidumper.exe ^
-s %~dp0 ^
-r t:/replace.db ^
-o t:/fb2.Flibusta.Net.7z.db
