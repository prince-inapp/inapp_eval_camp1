-- question 1

CREATE DATABASE Employee_DB;

-- dept_id, dept_name
create table department(
	dept_id int primary key,
	dept_name varchar(30)
	)
go

-- EMP_ID, EMPL_NAME
CREATE TABLE employee_names(
	empID int primary key,
	emp_name varchar(30),
	);
go

-- emp_id, dept_id, pay
create table employee_details(
	emp_id int primary key,
	dept_id int,
	pay int
	constraint fk_dept_id
	foreign key (dept_id)
	references department(dept_id));
go

-- inserting values into depratment table
insert into department values
	(1, 'IT'),
	(2,'Sales'),
	(3, 'Marketing'),
	(4, 'HR');
go

-- inserting values into employee_names

insert into employee_names values
	(001, 'Dilip'),
	(2,'Fahad'),
	(3,'Lal'),
	(4,'Nivin'),
	(5, 'Vijay'),
	(6, 'Anu'),
	(7, 'Nimisha'),
	(8, 'Praveena');
select * from employee_names;
go

-- inserting values into employee_details

insert into employee_details(emp_id, dept_id, pay) values 
	(1,1,3000),
	(2,2,4000),
	(3,3,6000),
	(4,1,2000),
	(5,2,9000),
	(6,4,5000),
	(7,2,5000),
	(8,3,8000);
go

select * from employee_details;
select * from employee_names;
select * from department;
go

-- 1. total number of employees
select count(empID) as TotalEmp from employee_names;

-- 2. Total amount req to pay all employees
select sum(pay) from employee_details;

-- 3. average, min, max pay in org
select avg(pay) as average, min(pay) as minimum, max(pay) as maximum from employee_details;

create view employee_view as
	select employee_names.empID,
			employee_names.emp_name, 
			employee_details.pay,
			department.dept_name
	from employee_names
	inner join employee_details on employee_names.empID = employee_details.emp_id
	inner join department on employee_details.dept_id = department.dept_id

select * from employee_view

-- 4. each dept wise total pay
select dept_name, sum(pay) from employee_view 
group by dept_name;
go

-- 5. average, mim and max pay dept wise
select dept_name, avg(pay) as average, min(pay) as minimum, max(pay) as maximum from employee_view group by dept_name;
go

-- 6. employee details who earns max
select employee_names.emp_name, department.dept_name, employee_details.pay from employee_names
inner join employee_details on employee_names.empID = employee_details.emp_id
inner join department on employee_details.dept_id = department.dept_id
where pay = ( select max(pay) from employee_details);
go


-- 7. employee details who is having max pay in the dept
select emp_name,dept_name,pay from employee_view
where pay in (select max(pay) as MaxPay from employee_view
group by dept_name)
go

-- 9. employee who has more pay than average pay of dept

-- 10. unique depts
select distinct dept_name from department;

-- 11. employees in increasing order of pay
select employee_names.emp_name, employee_details.pay
from employee_names 
inner join employee_details on employee_names.empID = employee_details.emp_id
order by employee_details.pay asc;

-- 12. dept in increasing order of pay
select dept_name, sum(pay) as TotalPay from employee_view
group by dept_name
order by pay;
go