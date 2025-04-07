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
