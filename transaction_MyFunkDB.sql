drop database MyFunkDB;
-- Завдання 2
create database MyFunkDB;

use MyFunkDB;

-- Завдання 3
CREATE TABLE Employees
  (Empl_ID int NOT NULL auto_increment PRIMARY KEY not null,
   FName nvarchar(15) NOT NULL,
   LName nvarchar(15) NOT NULL,
   phone  nvarchar(15) NOT NULL
   );
   
CREATE TABLE Positions
  (pos_ID int NOT NULL  PRIMARY KEY not null,   
   salary int NOT NULL,
   title varchar(60) NOT NULL,
   FOREIGN KEY(pos_ID) REFERENCES Employees(Empl_ID)
   );
   
CREATE TABLE Personal
  (pers_ID int NOT NULL PRIMARY KEY not null,
  Fam_status varchar(25) NOT NULL,
  Bthday date NOT NULL,
  Address nvarchar(45) NOT NULL,
  FOREIGN KEY(pers_ID) REFERENCES Employees(Empl_ID)
  );
     
-- Завдання 4
DELIMITER |
DROP PROCEDURE contacts_emp; |
CREATE PROCEDURE contacts_emp(IN FN nvarchar(15), IN LN nvarchar(15), IN ph nvarchar(15))
BEGIN
DECLARE Id int;
START TRANSACTION;
			
		INSERT Employees (FName, LName, phone )
		VALUES (FN, LN , ph);
		SET Id = @@IDENTITY;
		
IF EXISTS (SELECT * FROM Employees WHERE FName = FN AND phone = ph AND Empl_ID != Id)
			THEN
				ROLLBACK; 
			END IF;	
		COMMIT; 
END;
|

DELIMITER |
CALL contacts_emp('Генадій', 'Петренко','0931112233');
CALL contacts_emp('Ганна', 'Козак','0974569852');
CALL contacts_emp('Інна', 'Ревенко','09325496587');
CALL contacts_emp('Сергій', 'Корж','0933651452');
CALL contacts_emp('Петро', 'Іванов','093326587');
CALL contacts_emp('Ганна', 'Козак','0974569852');
|

select * from Employees;

-- Завдання 5
DELIMITER |
DROP TRIGGER IF EXISTS del_Employees;
|

DELIMITER |
CREATE TRIGGER del_Employees
BEFORE DELETE ON Employees
FOR EACH ROW 
  BEGIN
	DELETE FROM Position WHERE Empl_ID = OLD.Empl_ID;
	DELETE FROM Personal WHERE Empl_ID = OLD.Empl_ID;
 END;
    |
 
 DELETE FROM Employees WHERE Empl_ID = 2;|

 
 