--Create table Department

create database new_company
use new_company

CREATE TABLE Department(
    deptno INT NOT NULL PRIMARY KEY,
    dname VARCHAR(20),
    loc VARCHAR(20)
);

CREATE TABLE Employee(
    empno INT NOT NULL PRIMARY KEY,
    ename VARCHAR(20),
    jobid VARCHAR(20),
    mgr INT,
    hiredate DATE,
    sal MONEY,
    commission MONEY,
    deptno INT NOT NULL,
    CONSTRAINT dept_fk
        FOREIGN KEY (deptno)
        REFERENCES Department(deptno)
);


--Insert data into tables
INSERT INTO Department VALUES
    (10, 'ACCOUNTING', 'NEW YORK'),
    (20, 'RESEARCH', 'DALLAS'),
    (30, 'SALES', 'CHICAGO'),
    (40, 'OPERATIONS', 'BOSTON');

INSERT INTO Employee VALUES
    (7839, 'KING', 'PRESIDENT', NULL, '11/17/1981', 5000, NULL, 10),
    (7698, 'BLAKE', 'MANAGER', 7839, '05/01/1981', 2850, NULL, 30),
    (7782, 'CLARK', 'MANAGER', 7839, '06/09/1981', 2450, NULL, 10),
    (7566, 'JONES', 'MANAGER', 7839, '04/02/1981', 2975, NULL, 20),
    (7788, 'SCOTT', 'ANALYST', 7566, '12/09/1982', 3000, NULL, 20),
    (7902, 'FORD', 'ANALYST', 7566, '12/03/1981', 3000, NULL, 20),
    (7369, 'SMITH', 'CLERK', 7902, '12/17/1980', 800,  NULL,20),
    (7499, 'ALLEN', 'SALESMAN', 7698, '02/20/1981', 1600 ,300, 30),
    (7521, 'WARD', 'SALESMAN', 7698, '02/22/1981', 1250 ,500, 30),
    (7654, 'MARTIN', 'SALESMAN', 7698, '09/28/1981', 1250 ,1400, 30),
    (7844, 'TURNER', 'SALESMAN', 7698, '09/08/1981', 1500, NULL, 30),
    (7876, 'ADAMS', 'CLERK', 7788, '01/12/1983', 1100, NULL, 20),
    (7900, 'JAMES', 'CLERK', 7698, '12/03/1981', 950, NULL, 30),
    (7934, 'MILLER', 'CLERK', 7782, '01/23/1982', 1300, NULL, 10);
GO

SELECT * FROM Employee

-- 1. 
SELECT ename from Employee where mgr = empno;

--7. List the names of all employees along with name of managers
SELECT t1.empno, t2.ename AS employee,t1.ename AS Manager
FROM Employee t1,Employee t2
WHERE t1.empNo = t2.mgr