DROP SCHEMA public Cascade; --In case if you already have a SCHEMA named public 
CREATE SCHEMA public;   -- If not then please comment these 2 lines and start from line 4 

CREATE TABLE DiseaseType(
    id integer PRIMARY KEY,
    description varchar(140) NOT NULL); 
CREATE TABLE Disease(
    disease_code varchar(50) PRIMARY KEY,
    pathogen varchar(20) NOT NULL,
    description varchar(140) NOT NULL,
    id integer NOT NULL,
    FOREIGN KEY (id) References DiseaseType (id) ON DELETE CASCADE ON UPDATE CASCADE);
CREATE TABLE Country(
    cname varchar(50) PRIMARY KEY,
    population bigint NOT NULL);  
CREATE TABLE Discover(
    cname varchar(50) NOT NULL,
    disease_code varchar(50) NOT NULL,
    first_enc_date date NOT NULL, 
    FOREIGN KEY (disease_code) References Disease (disease_code) ON DELETE CASCADE ON UPDATE CASCADE, 
    FOREIGN KEY (cname) References Country (cname) ON DELETE CASCADE ON UPDATE CASCADE); 
CREATE TABLE Users(
    email varchar(60) PRIMARY KEY,
    name varchar(30) NOT NULL,
    surname varchar(40) NOT NULL,
    salary integer,
    phone varchar(20) NOT NULL,
    cname varchar(50) NOT NULL,
    FOREIGN KEY (cname) References Country (cname) ON DELETE CASCADE ON UPDATE CASCADE);
CREATE TABLE PublicServant(
    email varchar(60) UNIQUE, 
    department varchar(50) NOT NULL,
    FOREIGN KEY (email) References Users (email) ON DELETE CASCADE ON UPDATE CASCADE); 
CREATE TABLE Doctor(
    email varchar(60) UNIQUE,
    degree varchar(20) NOT NULL,
    FOREIGN KEY (email) References Users (email) ON DELETE CASCADE ON UPDATE CASCADE); 
CREATE TABLE Specialize(
    id integer NOT NULL,
    email varchar(60) NOT NULL,
    FOREIGN KEY (id) References DiseaseType (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (email) References Doctor (email) ON DELETE CASCADE ON UPDATE CASCADE);
CREATE TABLE Record(
    email varchar(60) NOT NULL,
    cname varchar(50) NOT NULL, 
    disease_code varchar(50) NOT NULL,
    total_deaths integer NOT NULL,
    total_patients integer NOT NULL,
    FOREIGN KEY (disease_code) References Disease (disease_code) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (cname) References Country (cname) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (email) References PublicServant (email) ON DELETE CASCADE ON UPDATE CASCADE);


INSERT INTO Diseasetype(id, description) VALUES
    (1, 'Virology'),
    (2, 'Infectious diseases'),
    (3, 'Fungal diseases'),
    (4, 'Parasitic diseases'),
    (5, 'Prion diseases'),
    (6, 'Diseases of the nervous system'),
    (7, 'Diseases of the circulatory system'),
    (8, 'Mental and behavioural disorders'), 
    (9, 'Diseases of the skin and subcutaneous tissue'), 
    (10, 'Diseases of the eye and adnexa');


INSERT INTO Disease(disease_code, pathogen, description, id) VALUES
    ('J12', 'virus' , 'Viral pneumonia', 1),
    ('J10', 'bacteria', 'Influenza with pneumonia', 2),
    ('B35.2', 'fungi', 'Tinea manuum', 3),
    ('A06.0', 'worm','Acute amoebic dysentery', 4),
    ('A81.0', 'none', 'Creutzfeldt-Jakob disease', 5),
    ('G00.2', 'none',  'Streptococcal meningitis', 6),
    ('I01.1', 'bacteria', 'Acute rheumatic endocarditis', 7),
    ('F20', 'none', 'Schizophrenia', 8),
    ('C43.5', 'fungi', 'Malignant melanoma of trunk', 9),
    ('H47.2', 'variant', 'Optic atrophy', 10),
    ('U07.1', 'virus', 'covid-19', 1);

INSERT INTO Country (cname, population) VALUES
    ('USA', 335660959),
    ('China', 1452596829),
    ('Alzhir', 38087812),
    ('Finland', 5561158),
    ('Germany', 84422659),
    ('United Kingdom', 68740558),
    ('Kazakhstan', 19323997),
    ('Ukraine', 43121350),
    ('France', 65617029),
    ('Nigeria', 219002438);

INSERT INTO Discover (cname, disease_code, first_enc_date) VALUES
    ('Germany', 'J12', '1936-10-21'),
    ('Alzhir', 'J10', '1920-02-10'),
    ('France', 'B35.2', '1962-03-20'),
    ('United Kingdom', 'A06.0', '2002-04-15'),
    ('Kazakhstan', 'A81.0', '1902-06-20'),
    ('USA', 'I01.1', '1823-08-13'),
    ('Nigeria', 'F20', '1956-12-04'),
    ('Ukraine', 'C43.5', '1941-10-29'),
    ('USA', 'H47.2', '1890-01-27'),
    ('China', 'U07.1', '2019-09-09');

INSERT INTO Users (email, name, surname, salary, phone, cname)
VALUES 
    ('alimbek.w@gmail.com', 'Alimbek', 'Alimbekov', 400000, '+77046194371', 'China'),
    ('gulsim.w@gmail.com', 'Gulsim', 'Nurzhanova', 150000, '+77054139856', 'Kazakhstan'),
    ('kairat.w@gmail.com', 'Kairat', 'Nurtas', 1000000, '+77083412144', 'Kazakhstan'),
    ('fariza.w@gmail.com', 'Fariza', 'Kuanysheva', 600000, '+70813144571', 'Kazakhstan'),
    ('nurbek.w@mail.ru', 'Nurbek', 'Khamidolla', 250000, '+77771425881', 'Kazakhstan'),
    ('yessengul.w@gmail.com', 'Yessengul', 'Aitbayeva', 500000, '+77079477314', 'Kazakhstan'),
    ('bakhytgul.w@yahoo.com', 'Bakhytgul', 'Bolatova', 750000, '+77058037102', 'China'),
    ('bekbolat.w@gmail.com', 'Bekbolat', 'Tursynov', 665000, '+77021936478', 'Kazakhstan'),
    ('diar.w@gmail.com', 'Diar', 'Berikov', 650000, '+77779431682', 'Kazakhstan'),
    ('alua.w@gmail.com', 'Alua', 'Nurgazina', 315000, '+77071935546', 'Kazakhstan'),
    ('assyl.w@gmail.com', 'Assyl', 'Karagui', 250000, '+77056946523', 'Kazakhstan'),
    ('maiya.w@gmail.com', 'Maiya', 'Goloburda', 400000, '+77074178439', 'Kazakhstan'),
    ('aruzhan.w@gmail.com', 'Aruzhan', 'Aruzhanova', 300000, '+77014986688', 'Kazakhstan'),
    ('malika.w@gmail.com', 'Malika', 'Nurzhanova', 275000, '+77029488411', 'Kazakhstan'),
    ('ruslan.w@gmail.com', 'Ruslan', 'Kapalov', 180000, '+77051234567', 'Kazakhstan'),
    ('ayan.w@gmail.com', 'Ayan', 'Myrzakhmet', 1500000, '+77089451264', 'Kazakhstan'),
    ('danel.w@gmail.com', 'Danel', 'Tastanbek', 360000, '+77071798846', 'Kazakhstan'),
    ('timur.w@gmail.com', 'Timur', 'Suetaev', 245000, '+77778469305', 'Kazakhstan'),
    ('tamerlan.w@gmail.com', 'Tamerlan', 'Sinisterov', 900000, '+77058877014', 'Kazakhstan'),
    ('zhalgas.w@gmail.com', 'Zhalgas', 'Duglacov', 700000, '+77026558223', 'Kazakhstan');

INSERT INTO Publicservant (email, department) VALUES
    ('zhalgas.w@gmail.com', 'Dep1'),
    ('tamerlan.w@gmail.com', 'Dep2'),
    ('timur.w@gmail.com', 'Dep3'),
    ('danel.w@gmail.com', 'Dep1'),
    ('ayan.w@gmail.com', 'Dep1'),
    ('ruslan.w@gmail.com', 'Dep2'),
    ('malika.w@gmail.com', 'Dep1'),
    ('aruzhan.w@gmail.com', 'Dep3'),
    ('maiya.w@gmail.com', 'Dep1'),
    ('assyl.w@gmail.com', 'Dep2');    

INSERT INTO Doctor (email, degree) VALUES
    ('gulsim.w@gmail.com', 'BSc'),
    ('alimbek.w@gmail.com', 'MD'),
    ('kairat.w@gmail.com', 'PhD'),
    ('fariza.w@gmail.com', 'MD'),
    ('alua.w@gmail.com', 'BSc'),
    ('nurbek.w@mail.ru', 'BSc'),
    ('yessengul.w@gmail.com', 'MD'),
    ('bekbolat.w@gmail.com', 'PhD'),
    ('diar.w@gmail.com', 'PhD'),
    ('bakhytgul.w@yahoo.com', 'PhD');

INSERT INTO Specialize (id, email) VALUES 
    (1, 'bakhytgul.w@yahoo.com'),
    (7, 'gulsim.w@gmail.com'),
    (1, 'alimbek.w@gmail.com'),
    (1, 'kairat.w@gmail.com'),
    (6, 'fariza.w@gmail.com'),
    (4, 'alua.w@gmail.com'),
    (2, 'nurbek.w@mail.ru'),
    (9, 'yessengul.w@gmail.com'),
    (5, 'diar.w@gmail.com'),
    (1, 'bekbolat.w@gmail.com'),
    (5, 'kairat.w@gmail.com'),
    (4, 'bekbolat.w@gmail.com'),
    (4, 'kairat.w@gmail.com'),
    (7, 'bekbolat.w@gmail.com');    

INSERT INTO Record VALUES
    ('ayan.w@gmail.com','Kazakhstan','I01.1', 10, 1000),
    ('ayan.w@gmail.com','USA','U07.1', 237, 160046),
    ('ayan.w@gmail.com','China','U07.1', 1652, 74221),
    ('danel.w@gmail.com','China','U07.1', 721, 678023),
    ('danel.w@gmail.com','Germany','U07.1', 56, 78562),
    ('danel.w@gmail.com','Finland','U07.1', 6541, 832133),
    ('danel.w@gmail.com','France','U07.1', 22223, 566667),
    ('maiya.w@gmail.com','Germany','U07.1', 100, 123),
    ('maiya.w@gmail.com','Alzhir','B35.2', 54, 66),
    ('maiya.w@gmail.com','United Kingdom','U07.1', 12, 16),
    ('maiya.w@gmail.com','Ukraine','F20', 123, 159),
    ('malika.w@gmail.com', 'Kazakhstan', 'J10', 500, 20121),
    ('ruslan.w@gmail.com', 'France', 'J12', 52232, 102132),
    ('aruzhan.w@gmail.com', 'France', 'J12', 2112 , 21619),
    ('timur.w@gmail.com', 'Germany', 'C43.5', 901 , 5102),
    ('timur.w@gmail.com', 'United Kingdom', 'J10', 7201, 50157);
    
-- --@block 1 
-- SELECT D.disease_code, D.description 
-- FROM Discover V, Disease D  
-- WHERE V.disease_code = D.disease_code AND V.first_enc_date < '1990-01-01' AND D.pathogen = 'bacteria' 


-- --@block 2
-- SELECT DISTINCT U.name, U.surname, Doc.degree
-- FROM Doctor Doc, DiseaseType T, Specialize S, Users U
-- WHERE U.email = Doc.email AND Doc.email = S.email AND T.id != 2 AND S.id = T.id

-- --@block 3
-- SELECT U.name, U.surname, Doc.degree
-- FROM Doctor Doc, Users U, Specialize S, DiseaseType T 
-- WHERE U.email = Doc.email AND Doc.email = S.email AND S.id = T.id
-- GROUP BY U.name, U.surname, Doc.degree
-- HAVING COUNT(S.id) > 2

-- --@block 4
-- SELECT U.cname, AVG(U.salary)
-- FROM Country C, Doctor Doc, Users U, DiseaseType T, Specialize S
-- WHERE U.email = Doc.email AND U.cname = C.cname AND T.id = 1 AND S.id = T.id
-- GROUP BY U.cname

-- --@block 5
-- SELECT P.department, COUNT(*)
-- FROM PublicServant P 
-- WHERE P.email IN
--     (SELECT P.email
--     FROM PublicServant P, Record R 
--     WHERE R.disease_code = 'U07.1' AND R.email = P.email
--     GROUP BY P.email, R.disease_code
--     HAVING COUNT(*) > 1)
-- GROUP BY P.department

-- --@block 6
-- UPDATE Users 
-- SET salary = salary * 2 
-- WHERE email IN
--     (SELECT P.email
--     FROM Users U, PublicServant P, Disease D, Record R
--     WHERE P.email = R.email AND R.disease_code = D.disease_code AND D.disease_code = 'U07.1'
--     GROUP BY P.email, R.disease_code
--     HAVING COUNT(R.disease_code) > 3)

-- --@block test 6
-- SELECT U.name, U.salary
-- FROM Users U
-- WHERE email IN
--     (SELECT P.email
--     FROM Users U, PublicServant P, Disease D, Record R
--     WHERE P.email = R.email AND R.disease_code = D.disease_code AND D.disease_code = 'U07.1'
--     GROUP BY P.email, R.disease_code
--     HAVING COUNT(R.disease_code) > 3)

-- --@block 7
-- DELETE FROM Users U 
-- WHERE U.name LIKE '%bek' or U.name LIKE '%gul' OR U.name LIKE 'Gul%' or U.name LIKE 'Bek%'
-- --@block 7 test
-- SELECT name FROM Users

--@block 8
CREATE INDEX idxpathogen
ON Disease(pathogen) 

--@block test 8
SELECT indexname
FROM pg_indexes, Disease D 
WHERE D.pathogen NOT LIKE '%pg';

--@block 9
-- SELECT DISTINCT U.email, U.name, P.department, R.total_patients
-- FROM Users U, PublicServant P, Record R
-- WHERE U.email = P.email AND P.email = R.email
-- GROUP BY U.email, U.name, P.department, R.total_patients
-- HAVING R.total_patients > 99999 AND R.total_patients < 1000000 

-- --@block 10
-- SELECT R.cname, SUM(R.total_patients)
-- FROM Record R 
-- GROUP BY R.cname
-- ORDER BY SUM(R.total_patients) DESC LIMIT 5

-- --@block 10 test
-- SELECT * FROM Record

-- --@block 11
-- SELECT T.description, SUM(R.total_patients) 
-- FROM Disease D, DiseaseType T, Record R
-- WHERE D.id = T.id AND D.disease_code = R.disease_code
-- GROUP BY T.description
-- ORDER BY SUM(R.total_patients)