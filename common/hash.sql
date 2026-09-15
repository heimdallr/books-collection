PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Таблица: File
CREATE TABLE File (
    FileId      INTEGER         PRIMARY KEY AUTOINCREMENT
                                NOT NULL,
    FolderId    INTEGER         REFERENCES Folder (FolderId) ON DELETE CASCADE
                                NOT NULL,
    Name        VARCHAR (256)   NOT NULL,
    Md5         CHAR (32)       NOT NULL,
    Hash        CHAR (32)       NOT NULL,
    WordCount   INTEGER         NOT NULL,
    SymbolCount INTEGER         NOT NULL,
    SimHash     CHAR (16)       NOT NULL,
    Title       VARCHAR (1024),
    Annotation  VARCHAR (10240),
    OriginId    INTEGER         REFERENCES File (FileId),
    UNIQUE (
        FolderId,
        Name
    )
);


-- Таблица: FileCustom
CREATE TABLE FileCustom (
    FileId      INTEGER        PRIMARY KEY
                               REFERENCES File (FileId) ON DELETE CASCADE
                               NOT NULL,
    Author      VARCHAR (1024),
    Title       VARCHAR (1024),
    Genre       VARCHAR (64),
    Updated     DATE,
    Lang        VARCHAR (3),
    Series      VARCHAR (1024),
    Keywords    VARCHAR (1024),
    PublishYear VARCHAR (16) 
);


-- Таблица: FileCustomImport
CREATE TABLE FileCustomImport (
    Folder      VARCHAR (64)   NOT NULL,
    File        VARCHAR (64)   NOT NULL,
    Author      VARCHAR (1024),
    Title       VARCHAR (1024),
    Genre       VARCHAR (64),
    Updated     DATE,
    Lang        VARCHAR (3),
    Series      VARCHAR (1024),
    Keywords    VARCHAR (1024),
    PublishYear VARCHAR (16) 
);


-- Таблица: Folder
CREATE TABLE Folder (
    FolderId        INTEGER      PRIMARY KEY AUTOINCREMENT
                                 NOT NULL,
    SourceLibraryId INTEGER      REFERENCES SourceLibrary (SourceLibraryId) ON DELETE CASCADE
                                 NOT NULL,
    Name            VARCHAR (64) NOT NULL
                                 UNIQUE
);


-- Таблица: Histogram
CREATE TABLE Histogram (
    HistogramId INTEGER      PRIMARY KEY AUTOINCREMENT
                             NOT NULL,
    FileId      INTEGER      REFERENCES File (FileId) ON DELETE CASCADE
                             NOT NULL,
    Word        VARCHAR (64) NOT NULL,
    WordCount   INTEGER      NOT NULL,
    UNIQUE (
        FileId,
        Word
    )
);


-- Таблица: Image
CREATE TABLE Image (
    ImageId     INTEGER       PRIMARY KEY AUTOINCREMENT
                              NOT NULL,
    FileId      INTEGER       REFERENCES File (FileId) ON DELETE CASCADE
                              NOT NULL,
    Name        VARCHAR (256),
    EncodedSize INTEGER       NOT NULL,
    DecodedSize INTEGER       NOT NULL,
    Width       INTEGER       NOT NULL,
    Height      INTEGER       NOT NULL,
    PHash       CHAR (16)     NOT NULL,
    Md5         CHAR (32)     NOT NULL,
    Linked      BOOLEAN       NOT NULL,
    HasAlpha    BOOLEAN       NOT NULL,
    UNIQUE (
        FileId,
        Name
    )
);


-- Таблица: Replacement
CREATE TABLE Replacement (
    Folder       VARCHAR (64),
    File         VARCHAR (256),
    FolderOrigin VARCHAR (64),
    FileOrigin   VARCHAR (256) 
);


-- Таблица: Section
CREATE TABLE Section (
    SectionId       INTEGER   PRIMARY KEY AUTOINCREMENT
                              NOT NULL,
    FileId          INTEGER   REFERENCES File (FileId) ON DELETE CASCADE
                              NOT NULL,
    ParentSectionId INTEGER,
    WordCount       INTEGER   NOT NULL,
    SymbolCount     INTEGER   NOT NULL,
    SimHash         CHAR (16) NOT NULL,
    Hash            CHAR (32) NOT NULL,
    FOREIGN KEY (
        ParentSectionId
    )
    REFERENCES Section (SectionId) ON DELETE CASCADE
);


-- Таблица: SourceLibrary
CREATE TABLE SourceLibrary (
    SourceLibraryId INTEGER      PRIMARY KEY AUTOINCREMENT
                                 NOT NULL,
    Name            VARCHAR (64) NOT NULL
                                 UNIQUE
);

INSERT INTO SourceLibrary (Name) VALUES ('flibusta');
INSERT INTO SourceLibrary (Name) VALUES ('librusec');

-- Индекс: IX_File_Hash
CREATE INDEX IX_File_Hash ON File (
    Hash
);


-- Индекс: IX_FK_File_FolderId
CREATE INDEX IX_FK_File_FolderId ON File (
    FolderId
);


-- Индекс: IX_FK_File_OriginId
CREATE INDEX IX_FK_File_OriginId ON File (
    OriginId
);


-- Индекс: IX_FK_Histogram_FileId
CREATE INDEX IX_FK_Histogram_FileId ON Histogram (
    FileId
);


-- Индекс: IX_FK_Image_FileId
CREATE INDEX IX_FK_Image_FileId ON Image (
    FileId
);


-- Индекс: IX_FK_Section_FileId
CREATE INDEX IX_FK_Section_FileId ON Section (
    FileId
);


-- Индекс: IX_FK_Section_ParentSectionId
CREATE INDEX IX_FK_Section_ParentSectionId ON Section (
    ParentSectionId
);


-- Индекс: IX_Folder_SourceLibraryId
CREATE INDEX IX_Folder_SourceLibraryId ON Folder (
    SourceLibraryId
);


-- Индекс: IX_Image_Md5
CREATE INDEX IX_Image_Md5 ON Image (
    Md5
);


-- Представление: CurrentFileCustom
CREATE VIEW CurrentFileCustom AS
    SELECT d.Name AS Folder,
           f.Name AS File,
           c.Author,
           c.Title,
           c.Genre,
           c.Updated,
           c.Lang,
           c.Series,
           c.Keywords,
           c.PublishYear
      FROM FileCustom c
           JOIN
           File f ON f.FileId = c.FileId
           JOIN
           Folder d ON d.FolderId = f.FolderId;


-- Представление: CurrentReplacement
CREATE VIEW CurrentReplacement AS
    SELECT d.Name Folder,
           f.Name File,
           d1.Name FolderOrigin,
           f1.Name FileOrigin
      FROM File f
           JOIN
           Folder d ON d.FolderId = f.FolderId
           JOIN
           File f1 ON f1.FileId = f.OriginId
           JOIN
           Folder d1 ON d1.FolderId = f1.FolderId
     ORDER BY d.Name,
              f.Name,
              d1.Name,
              f1.Name;


COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
