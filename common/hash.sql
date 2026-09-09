PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Таблица: File
DROP TABLE IF EXISTS File;

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


-- Таблица: Folder
DROP TABLE IF EXISTS Folder;

CREATE TABLE Folder (
    FolderId        INTEGER      PRIMARY KEY AUTOINCREMENT
                                 NOT NULL,
    SourceLibraryId INTEGER      REFERENCES SourceLibrary (SourceLibraryId) ON DELETE CASCADE
                                 NOT NULL,
    Name            VARCHAR (64) NOT NULL
                                 UNIQUE
);


-- Таблица: Histogram
DROP TABLE IF EXISTS Histogram;

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
DROP TABLE IF EXISTS Image;

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


-- Таблица: Section
DROP TABLE IF EXISTS Section;

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
DROP TABLE IF EXISTS SourceLibrary;

CREATE TABLE SourceLibrary (
    SourceLibraryId INTEGER      PRIMARY KEY AUTOINCREMENT
                                 NOT NULL,
    Name            VARCHAR (64) NOT NULL
                                 UNIQUE
);

INSERT INTO SourceLibrary (Name) VALUES ('flibusta');
INSERT INTO SourceLibrary (Name) VALUES ('librusec');

-- Индекс: IS_File_OriginId
DROP INDEX IF EXISTS IS_File_OriginId;

CREATE INDEX IS_File_OriginId ON File (
    OriginId
);


-- Индекс: IX_FK_File_FolderId
DROP INDEX IF EXISTS IX_FK_File_FolderId;

CREATE INDEX IX_FK_File_FolderId ON File (
    FolderId
);


-- Индекс: IX_FK_Histogram_FileId
DROP INDEX IF EXISTS IX_FK_Histogram_FileId;

CREATE INDEX IX_FK_Histogram_FileId ON Histogram (
    FileId
);


-- Индекс: IX_FK_Image_FileId
DROP INDEX IF EXISTS IX_FK_Image_FileId;

CREATE INDEX IX_FK_Image_FileId ON Image (
    FileId
);


-- Индекс: IX_FK_Section_FileId
DROP INDEX IF EXISTS IX_FK_Section_FileId;

CREATE INDEX IX_FK_Section_FileId ON Section (
    FileId
);


-- Индекс: IX_Folder_SourceLibraryId
DROP INDEX IF EXISTS IX_Folder_SourceLibraryId;

CREATE INDEX IX_Folder_SourceLibraryId ON Folder (
    SourceLibraryId
);


-- Индекс: IX_Image_Md5
DROP INDEX IF EXISTS IX_Image_Md5;

CREATE INDEX IX_Image_Md5 ON Image (
    Md5
);


-- Индекс: IX_Section_ParentSectionId
DROP INDEX IF EXISTS IX_Section_ParentSectionId;

CREATE INDEX IX_Section_ParentSectionId ON Section (
    ParentSectionId
);


COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
