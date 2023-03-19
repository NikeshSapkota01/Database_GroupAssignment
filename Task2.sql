CREATE TABLE Department (
  DeptID VARCHAR2(20) NOT NULL,
  Name VARCHAR2(50) NOT NULL,
  CONSTRAINT Department_PK PRIMARY KEY (DeptID) ENABLE 
);

CREATE TABLE SalaryGrade (
  SalaryCode VARCHAR2(20) NOT NULL,
  StartSalary VARCHAR2(20) NOT NULL,
  FinishSalary VARCHAR2(20) NOT NULL,
  CONSTRAINT SalaryGrade_PK PRIMARY KEY ( SalaryCode ) ENABLE 
);

CREATE TABLE PensionScheme (
  SchemeID VARCHAR2(20) NOT NULL,
  Name VARCHAR2(20) NOT NULL,
  Rate NUMBER(5,2) NOT NULL,
  CONSTRAINT SchemeID_PK PRIMARY KEY ( SchemeID ) ENABLE  
);


CREATE TABLE Employee (
  EmpID VARCHAR2(20) NOT NULL,
  Name VARCHAR2(50) NOT NULL,
  Address VARCHAR2(100),
  DOB DATE,
  Job VARCHAR2(50),
  SalaryCode VARCHAR2(20) NOT NULL,
  DeptID VARCHAR2(20) NOT NULL,
  Manager VARCHAR2(20),
  SchemeID VARCHAR2(20),
  CONSTRAINT EMPLOYEE_PK PRIMARY KEY (EmpID) ENABLE, 
  CONSTRAINT FK_Employee_SalaryCode FOREIGN KEY (SalaryCode) REFERENCES SalaryGrade(SalaryCode),
  CONSTRAINT FK_Employee_DeptID FOREIGN KEY (DeptID) REFERENCES Department(DeptID),
  CONSTRAINT FK_Employee_SchemeID FOREIGN KEY (SchemeID) REFERENCES PensionScheme(SchemeID)
);


-- Department
INSERT INTO Department (DeptID, Name)
VALUES ('D10', 'Administration');

INSERT INTO Department (DeptID, Name)
VALUES('D20', 'Finance');

INSERT INTO Department (DeptID, Name)
VALUES('D30', 'Sales');

INSERT INTO Department (DeptID, Name)
VALUES('D40', 'Maintenance');

INSERT INTO Department (DeptID, Name)
VALUES('D50', 'IT Support');

-- SalaryGrade
-- Inserting using INSERT ALL
INSERT ALL
    INTO SalaryGrade (SalaryCode, StartSalary, FinishSalary)
    VALUES ('S1', '15000', '18000')

    INTO SalaryGrade (SalaryCode, StartSalary, FinishSalary)
    VALUES ('S2', '18001', '22000')

    INTO SalaryGrade (SalaryCode, StartSalary, FinishSalary)
    VALUES ('S3', '22001', '25000')

    INTO SalaryGrade (SalaryCode, StartSalary, FinishSalary)
    VALUES ('S4', '25001', '29000')

    INTO SalaryGrade (SalaryCode, StartSalary, FinishSalary)
    VALUES ('S5', '29001', '38000')

SELECT 1 FROM dual;

-- PensionScheme
-- Inserting a SELECT Query
INSERT INTO PensionScheme (SchemeID, Name, Rate) 
    WITH ps AS ( 
        SELECT 'S110', 'AXA', 0.5 FROM dual UNION ALL 
        SELECT 'S121', 'Premier', 0.6 FROM dual UNION ALL 
        SELECT 'S124', 'Stakeholder', 0.4 FROM dual UNION ALL 
        SELECT 'S116', 'Standard', 0.4 FROM dual
  )
SELECT * FROM ps;

-- Employee
INSERT INTO Employee (EmpID, Name, Address, DOB, Job, SalaryCode, DeptID, Manager, SchemeID)
VALUES ('E110', 'Watkins J.', '11 crescent road', '25-Jun-69', 'Manager', 'S5', 'D10', NULL, 'S121');

INSERT INTO Employee (EmpID, Name, Address, DOB, Job, SalaryCode, DeptID, Manager, SchemeID)
VALUES ('E310', 'Newgate, E.', '10 Heap E. Street', '28-NOV-80', 'Manager', 'S5', 'D30', NULL, 'S121');

INSERT INTO Employee (EmpID, Name, Address, DOB, Job, SalaryCode, DeptID, Manager, SchemeID)
VALUES ('E501', 'Teach E', '22 railway road', '12-Feb-72', 'Analyst', 'S5', 'D50', NULL, 'S121');

INSERT INTO Employee (EmpID, Name, Address, DOB, Job, SalaryCode, DeptID, Manager, SchemeID)
VALUES ('E101', 'Young S.', '199 London Road', '05-MAR-76', 'Clerk', 'S1', 'D10', 'E110', 'S116');

INSERT INTO Employee (EmpID, Name, Address, DOB, Job, SalaryCode, DeptID, Manager, SchemeID)
VALUES ('E301', 'April, H.', '20 Glade close', '10-MAR-79', 'Sales Person', 'S2', 'D30', 'E310', 'S124');

INSERT INTO Employee (EmpID, Name, Address, DOB, Job, SalaryCode, DeptID, Manager, SchemeID)
VALUES ('E102', 'Hawkins, M.', '3 High Street', '13-Jul-74', 'Clerk', 'S1', 'D10', 'E110', 'S116');


SELECT * FROM Employee;
SELECT * FROM Department;
SELECT * FROM SalaryGrade;
SELECT * FROM PensionScheme;

SELECT e.Name, s.StartSalary, e.DeptID
FROM Employee e
JOIN SalaryGrade s ON e.SalaryCode = s.SalaryCode
JOIN Department d ON e.DeptID = d.DeptID
ORDER BY e.DeptID DESC, e.Name ASC;

SELECT ps.Name AS "Pension Scheme",
COUNT(*) AS "Number of Employees"
FROM Employee e
    JOIN PensionScheme ps ON e.SchemeID = ps.SchemeID
GROUP BY ps.Name;

SELECT COUNT(*) AS "Non Manaager Employees"
FROM Employee e
JOIN SalaryGrade sg ON e.SalaryCode = sg.SalaryCode
WHERE e.Manager IS NULL AND sg.FinishSalary > 35000;

SELECT e.EmpID, e.Name AS EmployeeName, m.Name AS ManagerName
FROM Employee e
LEFT JOIN Employee m ON e.Manager = m.EmpID;