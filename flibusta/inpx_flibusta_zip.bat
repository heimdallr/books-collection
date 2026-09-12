fliparser.exe ^
H:\books\fb2.Flibusta.Net\*.zip ^
-o t:\ ^
--dump t:\flibusta.7z.db ^
--database H:\data\db\flibrary\hash.db ^
--collection-info-template %~dp0collection_fb2.info ^
--skip-merge
