/* -------------------------------------------------------------------------- */
/*                                 TP 4.1                                     */
/* -------------------------------------------------------------------------- */ 

DROP TABLE Groupe CASCADE CONSTRAINTS;
DROP TABLE Fonction CASCADE CONSTRAINTS;
DROP TABLE Personne CASCADE CONSTRAINTS;
DROP TABLE Avis CASCADE CONSTRAINTS;
DROP TABLE Emission CASCADE CONSTRAINTS;
DROP TABLE Chaine CASCADE CONSTRAINTS;
DROP TABLE Diffuser CASCADE CONSTRAINTS;
DROP TABLE Intervenir CASCADE CONSTRAINTS;

CREATE TABLE Groupe
(NomG VARCHAR2(50),
DateCreationG DATE,
CONSTRAINT pk_NomG PRIMARY KEY (NomG),
CONSTRAINT ck_NomG CHECK (NomG IS NOT NULL));

CREATE TABLE Fonction
(NomF VARCHAR2(50),
CONSTRAINT pk_NomF PRIMARY KEY(NomF),
CONSTRAINT ck_NomF CHECK (NomF IS NOT NULL));

CREATE TABLE Personne
(NumP NUMBER,
Nom VARCHAR2(50),
Prenom VARCHAR2(50),
CONSTRAINT pk_NumP PRIMARY KEY (NumP),
CONSTRAINT ck_NumP CHECK (NumP IS NOT NULL));

CREATE TABLE Avis
(Num NUMBER,
Description VARCHAR(200),
Note NUMBER,
CONSTRAINT pk_Num PRIMARY KEY (Num));

CREATE TABLE Emission
(Reference VARCHAR2(50),
Titre VARCHAR2(50),
Resume VARCHAR2(400),
Type VARCHAR2(50),
Duree VARCHAR2(50),
Num NUMBER,
NomG VARCHAR2(50),
CONSTRAINT pk_Emission PRIMARY KEY (Reference),
CONSTRAINT fk_Avis_Emission FOREIGN KEY (Num) REFERENCES Avis,
CONSTRAINT fk_Groupe_Emission FOREIGN KEY (NomG) REFERENCES Groupe);

CREATE TABLE Chaine
(NomCH VARCHAR2(50),
DateCreationCH DATE,
NomG VARCHAR2(50),
CONSTRAINT pk_Chaine PRIMARY KEY (NomCH),
CONSTRAINT fk_Groupe_Chaine FOREIGN KEY (NomG) REFERENCES Groupe);
    
CREATE TABLE Diffuser
(HeureFin VARCHAR2(50),
Reference VARCHAR2(50),
NomCH VARCHAR2(50),
HeureDebut VARCHAR2(50),
DateD DATE,
CONSTRAINT pk_Diffuser PRIMARY KEY (Reference, NomCH, HeureDebut, DateD),
CONSTRAINT fk_Emission_Diffuser FOREIGN KEY (Reference) REFERENCES Emission,
CONSTRAINT fk_Chaine_Diffuser FOREIGN KEY (NomCH) REFERENCES Chaine);
    
CREATE TABLE Intervenir
(NumP NUMBER,
NomF VARCHAR2(50),
Reference VARCHAR2(50),
CONSTRAINT pk_Intervenir PRIMARY KEY (NumP, NomF, Reference),
CONSTRAINT fk_Personne_Intervenir FOREIGN KEY (NumP) REFERENCES Personne,
CONSTRAINT fk_Fonction_Intervenir FOREIGN KEY (NomF) REFERENCES Fonction,
CONSTRAINT fk_Emission_Intervenir FOREIGN KEY (Reference) REFERENCES Emission);


/* -------------------------------------------------------------------------- */
/*                                 TP 4.2                                     */
/* -------------------------------------------------------------------------- */   


INSERT INTO Groupe (NomG)
    VALUES ('TV1');

INSERT INTO Personne (NumP, Nom, Prenom)
    VALUES (999, 'Vie', 'Jean');

INSERT INTO Fonction (NomF)
    VALUES ('Animateur');
    
INSERT INTO Avis (Num, Description, Note)
    VALUES (111, 'Bof Bof', 1);
    
INSERT INTO Chaine (NomCH, NomG)
    VALUES ('CH1', 'TV1');
    
INSERT INTO Emission (Reference, Titre, Resume, Type, Duree, Num, NomG)
    VALUES ('E1' , 'Test1', 'Emission fictive', 'Regulier', '30', 111, 'TV1');
    
INSERT INTO Intervenir (NumP, NomF, Reference)
    VALUES (999, 'Animateur', 'E1');
    
INSERT INTO Diffuser (HeureFin, Reference, NomCH, HeureDebut, DateD)
    VALUES ('18h30', 'E1', 'CH1', '18h', '14/01/2016');
    

/* -------------------------------------------------------------------------- */
/*                                 TP 5.1                                     */
/* -------------------------------------------------------------------------- */   



DELETE Diffuser;
DELETE Intervenir;
DELETE Emission;
DELETE Chaine;
DELETE Avis;
DELETE Fonction;
DELETE Personne;
DELETE Groupe;

INSERT INTO Groupe
SELECT DISTINCT NomG, DateCreationG
FROM GILLES_HUBERT.TP4_TV;

INSERT INTO Personne
SELECT DISTINCT NumP, Nom, Prenom
FROM GILLES_HUBERT.TP4_TV;

INSERT INTO Fonction
SELECT DISTINCT NomF
FROM GILLES_HUBERT.TP4_TV;

INSERT INTO Avis
SELECT DISTINCT NUM, DESCRIPTION, Note
FROM GILLES_HUBERT.TP4_TV
WHERE NUM IS NOT NULL;

INSERT INTO Chaine
SELECT DISTINCT NomCH, DateCreationCH, NomG
FROM GILLES_HUBERT.TP4_TV;

INSERT INTO Emission
SELECT DISTINCT Reference, Titre, Resume, Type, Duree, Num, NomG
FROM GILLES_HUBERT.TP4_TV;

INSERT INTO Intervenir
SELECT DISTINCT NumP, NomF, Reference
FROM GILLES_HUBERT.TP4_TV;

INSERT INTO Diffuser
SELECT DISTINCT HeureFin, Reference, NomCH, HeureDebut, DateD
FROM GILLES_HUBERT.TP4_TV;


/* -------------------------------------------------------------------------- */
/*                                 TP 5.2                                     */
/* -------------------------------------------------------------------------- */             




/* --------------------------------- A -------------------------------------- */
INSERT INTO Personne
VALUES ('819', 'Lapointe', 'Louis');
/* --------------------------------- A -------------------------------------- */



/* --------------------------------- B -------------------------------------- */
SELECT * FROM Personne;
/* --------------------------------- B -------------------------------------- */



/* --------------------------------- C -------------------------------------- */
SELECT Note FROM Avis
WHERE Note >= 4;
/* --------------------------------- C -------------------------------------- */



/* --------------------------------- D -------------------------------------- */
SELECT NomCH, NomG FROM Chaine;
/* --------------------------------- D -------------------------------------- */



/* --------------------------------- E -------------------------------------- */
SELECT * FROM Personne
WHERE Prenom = 'David';
/* --------------------------------- E -------------------------------------- */



/* --------------------------------- F -------------------------------------- */
SELECT * FROM Emission
WHERE NUM IS NOT NULL;
/* --------------------------------- F -------------------------------------- */


/* --------------------------------- G -------------------------------------- */
SELECT * FROM Diffuser
WHERE DateD = '16/01/2016';
/* --------------------------------- G -------------------------------------- */


/* --------------------------------- H -------------------------------------- */
SELECT DISTINCT Emission.Reference, Emission.Titre, Personne.Nom, Personne.Prenom, Intervenir.NomF 
FROM Emission, Personne, Intervenir
WHERE Personne.NumP = Intervenir.NumP
AND Intervenir.Reference = Emission.Reference;
/* --------------------------------- H -------------------------------------- */


/* --------------------------------- I -------------------------------------- */
SELECT DISTINCT Personne.* FROM Personne, Emission, Intervenir
WHERE Emission.reference = Intervenir.reference
AND Intervenir.NumP = Personne.NumP
AND (Intervenir.NomF = 'réalisateur');
/* --------------------------------- I -------------------------------------- */



/* --------------------------------- J -------------------------------------- */
SELECT * FROM Diffuser
WHERE DateD='15/01/2016'
AND HeureDebut = '20:00';
/* --------------------------------- J -------------------------------------- */


/* --------------------------------- K -------------------------------------- */
SELECT DISTINCT personne.* 
FROM personne,intervenir,emission 
WHERE emission.reference=intervenir.reference 
AND intervenir.numP = personne.nump and emission.duree>150 
AND(intervenir.nomf='acteur' or intervenir.nomf='actrice');
/* --------------------------------- K -------------------------------------- */



/* --------------------------------- L -------------------------------------- */
SELECT * FROM  AVIS, Emission
WHERE EMISSION.Num = AVIS.Num
AND NomG = 'France Télévisions';
/* --------------------------------- L -------------------------------------- */



/* --------------------------------- M -------------------------------------- */
SELECT * FROM Chaine
WHERE (NomG LIKE 'TF1 SA')
OR (NomG LIKE 'Groupe M6');
/* --------------------------------- M -------------------------------------- */



/* --------------------------------- N -------------------------------------- */
SELECT p1.nom, p1.prenom, p2.nom, p2.prenom
FROM Personne p1, Personne p2
WHERE p1.prenom = p2.prenom
AND p1.numP > p2.numP;
/* --------------------------------- N -------------------------------------- */



/* --------------------------------- O -------------------------------------- */
SELECT Titre
FROM Emission, Diffuser C, Diffuser D
WHERE Emission.reference = C.reference AND
Emission.Reference = D.Reference AND
C.DateD < D.DateD;
/* --------------------------------- O -------------------------------------- */



/* --------------------------------- P -------------------------------------- */
SELECT DISTINCT Nom, Prenom
FROM Emission A, Emission B, Personne, Intervenir C, Intervenir D
WHERE A.Reference = C.Reference AND B.Reference = D.Reference 
AND C.NumP = personne.NumP and D.NumP = Personne.NumP 
AND A.Reference != B.Reference;
/* --------------------------------- P -------------------------------------- */



/* --------------------------------- Q -------------------------------------- */
SELECT DISTINCT a.Nom, a.Prenom, B.Nom, B.Prenom
FROM Personne A, Personne B, Intervenir C, Intervenir D, Emission
WHERE A.NumP = C.NumP AND B.NumP = D.NumP 
AND C.NomF = 'réalisateur' AND D.NomF = 'réalisateur' 
AND Emission.Reference = C.Reference AND Emission.Reference = D.Reference 
AND A.NumP < B.NumP;
/* --------------------------------- Q -------------------------------------- */