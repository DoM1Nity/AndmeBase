--kommentaar 
--SQL SERVER Managment Stuudio 
--Conect TO:
--Server Name: (localdb)\MSSQLLocalDB
-- Authentification 2 tüüpi:
--1. Windows Auth - Localdb admini õigused
--2. SQL Server Authentification - kontrollida varem tehtud kasutajad

CREATE DATABASE DanikLOGITvp23;
USE DanikLOGITvp23;

--tabeli loomine
--identity(1,1) - ise täidab tabeli 1,2,3,...
CREATE TABLE inimene(
inimineID int Primary Key identity (1,1),
nimi varchar(50) unique,
synniaeg date,
telefon char(12),
pikkus decimal(5,2),
opilaskodu bit
);
SELECT * FROM inimene;

--tabeli kustutamine
DROP table inimene;

--andmete lisamine 
--DDL - data definition language
--DML - data manipulation language 
INSERT INTO inimene(nimi, synniaeg, telefon, pikkus, opilaskodu)
VALUES 
('Mati Kask', '2021-12-30', '2568952', 110.5, 0),
('Kladi Meister', '2006-12-5', '1231231', 180, 0),
('Andei Makeev', '2001-12-5', '13123', 189, 0),
('Gleb Fidzer', '1986-4-5', '4121421', 145, 0)
;

SELECT * FROM inimene;

CREATE TABLE elukoht(
elukohtID int PRIMARY KEY identity (1,1),
elukoht varchar(50) UNIQUE,
maakond varchar(50)
);
SELECT * FROM elukoht;
--andmete lisamine tabeli elukoht
INSERT INTO elukoht(elukoht, maakond)
VALUES ('Tartu', 'Tartumaa'),
('Pärnu', 'Pärnumaa');

--tabeli muutmine uue veergu lisamine
ALTER TABLE inimene ADD elukohtID int
SELECT * FROM inimene;
--foreign key lisamine
ALTER TABLE inimene 
ADD Constraint fk_elukoht
FOREIGN KEY(elukohtID) 
references elukoht(elukohtID);

SELECT * FROM inimene;
SELECT * FROM elukoht;

INSERT INTO inimene
(nimi, synniaeg, telefon, pikkus, opilaskodu, elukohtID)
VALUES
('Andrei Mäk', '2020-10-1', '2342444', 95.5, 9,1);

SELECT * FROM inimene join elukoht
ON inimene.elukohtID=elukoht.elukohtID;

SELECT inimene.nimi, inimene.synniaeg, elukoht.elukoht
FROM inimene join elukoht
ON inimene.elukohtID=elukoht.elukohtID;


SELECT i.nimi, i.synniaeg, e.elukoht
FROM inimene i join elukoht
ON inimene.elukohtID=elukoht.elukohtID;

SELECT * FROM inimene;

CREATE TABLE autod(
autoID int PRIMARY KEY identity (1,1),
autoNR varchar(50) UNIQUE,
mudell varchar(50),
mark varchar(50),
vaasta date
);

DROP TABLE auto;

INSERT INTO autod
(autoNR, mudell, mark, vaasta)
VALUES 
('MXN123', 'Juke', 'Nissan', '2023-11-10'),
('MXN456', 'Patrol', 'Nissan', '2021-11-10'),
('GTR777', 'GTR', 'Nissan', '2024-11-10');

SELECT * FROM autod;

ALTER TABLE inimene ADD autoID int;
SELECT * FROM inimene;

ALTER TABLE inimene
ADD Constraint fk_autod
FOREIGN KEY (autoID)
references autod(autoID);

INSERT INTO inimene
(nimi,synniaeg, telefon, pikkus, opilaskodu, elukohtID, autoID)
VALUES
('Danik Ivanov', '2000-5-12', '2353252' , 91.5, 0, 1, 1);

------------------------------------------------

CREATE DATABASE proceduurLOGITpv23;
use proceduurLOGITpv23;

CREATE TABLE filmid(
filmID int primary key identity(1,1),
filNimi varchar(30) unique,
filmPikkus int,
rezisoor varchar(30)
);

SELECT * FROM filmid;

INSERT INTO filmid(filNimi, filmPikkus, rezisoor)
VALUES ('Minecraft', 120, 'Jared Hess');

--Protseduur, mis lisab uus film ja kohe näitab tabelis (INSERT, SELECT)
CREATE PROCEDURE lisafilm
@nimi varchar(30),
@pikkus int,
@rezisoor varchar(30)
AS
BEGIN
INSERT INTO filmid(filNimi, filmPikkus, rezisoor)
VALUES (@nimi, @pikkus, @rezisoor);
select * from filmid;
END;

--kutse
EXEC lisafilm 'Bob ja Bobek', 120, 'testtest';

--Proceduur, mis kustutab filmi filmiID järgi (DELETE, SELECT)
CREATE PROCEDURE kustutaFilm
@id int
AS
BEGIN
SELECT * from filmid;
DELETE FROM filmid WHERE filmID=@id;
SELECT * from filmid;
END;


--kutse
EXEC kustutaFilm 1;
EXEC kustutaFilm @id=1;

--proceduur, mis uuendab filmiPikkus 5% suurendab
CREATE PROCEDURE uuendaFilmiPikkus
AS
BEGIN
SELECT * FROM filmid;
UPDATE filmid SET filmPikkus=filmPikkus*1.05
SELECT * FROM filmid;
END

--kutse
EXEC uuendaFilmiPikkus;

CREATE PROCEDURE uuendaFilmiPikkus2
@arv decimal(5,2)
AS
BEGIN
SELECT * FROM filmid;
UPDATE filmid SET filmPikkus=filmPikkus*@arv;
SELECT * FROM filmid;
END

EXEC uuendaFilmiPikkus2 @arv=0.10;



-------------------------------

-- uus tabeli 15 april

CREATE DATABASE proceduurLOGITpv23;

use proceduurLOGITpv23;

CREATE TABLE filmid(
filmID int primary key identity(1,1),
filNimi varchar(30) unique,
filmPikkus int,
rezisoor varchar(30)
);

select * from filmid;

--protseduur, mis näitab filmid esimese tähe järgi
CREATE PROCEDURE filmdtaht
@taht char(1)
AS
BEGIN 
SELECT * FROM filmid
WHERE filNimi LIKE CONCAT(@taht, '%');
END

--kutse
EXEC filmdtaht 'M';

--protseduur, mis näitab mis sisaldavad nimes sistatud täht
CREATE PROCEDURE filmidSisaldabTaht
@taht char(1)
AS
BEGIN 
SELECT * FROM filmid
WHERE filNimi LIKE CONCAT('%', @taht, '%');
END

EXEC filmidSisaldabTaht 'I';

--protseduur, mis näitab mis keskmine filmide pikkus
CREATE PROCEDURE KeskminePikkus
AS
BEGIN 
SELECT AVG(filmPikkus) as 'Keskmine Pikkus' FROM filmid
END

DROP PROCEDURE KeskminePikkus

EXEC KeskminePikkus;

-- tabeli struktuuri muutmine
--KERULINE PROTSEDUUR
--ALTER TABLE tabelnimi ADD veerg tyyp --- veergu lisamine
--ALTER TABLE tabelnimi DROP veerg --- veergu kustutamine 


CREATE PROCEDURE muudatus
@tegevus varchar(10),
@tabelinimi varchar(25),
@veerunimi varchar(25),
@tyyp varchar(25) =null
AS
BEGIN
DECLARE @sqltegevus as varchar(max)
set @sqltegevus=case 
when @tegevus='add' then concat('ALTER TABLE ', @tabelinimi, ' ADD ', @veerunimi, ' ', @tyyp)
when @tegevus='drop' then concat('ALTER TABLE ', @tabelinimi, ' DROP COLUMN ', @veerunimi)
END;
print @sqltegevus;
begin 
EXEC (@sqltegevus);
END
END;

select * from filmid;
--добавление столбца
EXEC muudatus @tegevus='add', @tabelinimi='filmid', @veerunimi='test', @tyyp='int';
--удаление столбца
EXEC muudatus @tegevus='drop', @tabelinimi='filmid', @veerunimi='test';
