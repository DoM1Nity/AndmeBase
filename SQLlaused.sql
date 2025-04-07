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

--kustuta id=1
DELETE FROM * inimine;
WHERE inimeneID=1
