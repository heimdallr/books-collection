--
-- Файл сгенерирован с помощью SQLiteStudio v3.2.1 в Чт мар 5 14:26:11 2026
--
-- Использованная кодировка текста: UTF-8
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Таблица: Author
CREATE TABLE Author (
    LibraryId  INTEGER      REFERENCES Library (Id) ON DELETE CASCADE
                            NOT NULL,
    AuthorId   INTEGER      NOT NULL,
    FirstName  VARCHAR (64),
    MiddleName VARCHAR (64),
    LastName   VARCHAR (64),
    PRIMARY KEY (
        LibraryId,
        AuthorId
    )
);

INSERT INTO Author (LibraryId, AuthorId, FirstName, MiddleName, LastName) VALUES (1, 1801, 'Сергей', 'Васильевич', 'Лукьяненко');
INSERT INTO Author (LibraryId, AuthorId, FirstName, MiddleName, LastName) VALUES (1, 36085, 'Сергей', NULL, 'Лукьяненко');
INSERT INTO Author (LibraryId, AuthorId, FirstName, MiddleName, LastName) VALUES (1, 72206, 'Константин', 'Георгиевич', 'Калбазов');
INSERT INTO Author (LibraryId, AuthorId, FirstName, MiddleName, LastName) VALUES (1, 142441, 'Константин', 'Георгиевич', 'Калбазов');
INSERT INTO Author (LibraryId, AuthorId, FirstName, MiddleName, LastName) VALUES (2, 204458, 'Коллектив авторов', '--', 'Составитель С. Лукьяненко');
INSERT INTO Author (LibraryId, AuthorId, FirstName, MiddleName, LastName) VALUES (2, 316127, 'Патрик', 'Дж.', 'Холл');
INSERT INTO Author (LibraryId, AuthorId, FirstName, MiddleName, LastName) VALUES (2, 346366, 'Гоблин', NULL, 'MeXXanik');
INSERT INTO Author (LibraryId, AuthorId, FirstName, MiddleName, LastName) VALUES (2, 342321, 'Гоблин', NULL, 'MeXXanik');

-- Таблица: AuthorList
CREATE TABLE AuthorList (
    LibraryId  INTEGER      REFERENCES Library (Id) ON DELETE CASCADE
                            NOT NULL,
    Id         INTEGER      NOT NULL,
    BookId     INTEGER      NOT NULL,
    Additional VARCHAR (64),
    UNIQUE (
        LibraryId,
        Id,
        BookId
    )
);

INSERT INTO AuthorList (LibraryId, Id, BookId, Additional) VALUES (1, 224205, 759158, '1');
INSERT INTO AuthorList (LibraryId, Id, BookId, Additional) VALUES (1, 334099, 759158, '2');

-- Таблица: Library
CREATE TABLE Library (
    Id   INTEGER      PRIMARY KEY AUTOINCREMENT,
    Name VARCHAR (32) NOT NULL
                      UNIQUE
);

INSERT INTO Library (Id, Name) VALUES (1, 'flibusta');
INSERT INTO Library (Id, Name) VALUES (2, 'librusec');

-- Таблица: Series
CREATE TABLE Series (
    LibraryId INTEGER       REFERENCES Library (Id) ON DELETE CASCADE
                            NOT NULL,
    SeriesId  INTEGER       NOT NULL,
    Title     VARCHAR (128),
    PRIMARY KEY (
        LibraryId,
        SeriesId
    )
);

INSERT INTO Series (LibraryId, SeriesId, Title) VALUES (1, 604, 'Песнь Льда и Огня');
INSERT INTO Series (LibraryId, SeriesId, Title) VALUES (2, 604, 'Песнь льда и пламени | Истории Семи Королевств');
INSERT INTO Series (LibraryId, SeriesId, Title) VALUES (2, 26721, 'Ревізіонізм голокосту');
INSERT INTO Series (LibraryId, SeriesId, Title) VALUES (2, 66739, 'Ребенок от босса [Чайлд]');

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
