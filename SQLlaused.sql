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

