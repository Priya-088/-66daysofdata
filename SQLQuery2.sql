create database employee_info

--creating a employee table
create table employee(
e_id int not null,
e_name  varchar(20),
e_salary int,
e_age int,
e_gender varchar(20),
e_dept varchar(20),
primary key(e_id)
);

--inserting data into the table
insert into employee values(
1,'sam',95000, 45, 'male', 'operations'
);
insert into employee values(
2, 'bob', 80000, 21, 'male', 'support'
);
insert into employee values(
3, 'anni', 125000, 25, 'female', 'analytics'
);
insert into employee values(
4, 'julia', 73000, 30, 'female', 'analytics'
);
insert into employee values(
5, 'matt', 159000, 33, 'male', 'sales'
);
insert into employee values(
6, 'jeff', 122000, 27, 'male', 'operations'
);

--selecting columns
select e_name from employee;
select e_age, e_salary from employee;
select * from employee

--select distinct
select distinct e_gender from employee;

--where clause
select * from employee where e_gender='female'
select * from employee where e_age<30
select * from employee where e_salary> 100000

--using logical operators
--AND
select * from employee where e_gender='male' and e_age<30
select * from employee where e_dept='operations' and e_salary> 100000
--OR
select * from employee where e_dept='operations' or e_dept='analytics'
select * from employee where e_salary>100000 or e_age>30
--not 
select * from employee where not e_gender= 'female'
select * from employee where not e_age<30
--LIKE
select * from employee where e_name	LIKE 'J%'
select * from employee where e_age LIKE '3_'
--	BETWEEN
select * from employee where e_age BETWEEN 25 AND 35
select * from employee where e_salary BETWEEN 90000 AND 125000
select * from employee
--MIN()
select MIN(e_age) from employee
select MIN(e_salary) from employee
--max()
select MAX(e_age) from employee
select MAX(e_salary) from employee
--count()
select count(*) from employee where e_gender='male'
select count(*) from employee where e_gender='female'
--SUM()
select sum(e_salary) from employee
--AVG()
select AVG(e_age) from employee
--string functions
--LTRIM
select '     spartaaaa'
select LTRIM('     spartaaaa')
--LOWER
select 'THIS IS PRIYA'
select LOWER('THIS IS PRIYA')
--UPPER
select 'this is priya'
select UPPER('this is priya')
--REVERSE
select 'I love icecream'
select REVERSE('I love icecream')
--SUBSTRING
select 'this is sparta'
select SUBSTRING('this is sparta',9,6)
--ORDER BY CLASS
select * from employee ORDER BY e_salary desc

--TOP CLASS
select TOP 3 * from employee
--ORDER BY AND TOP CLASS TOGETHER
SELECT TOP 3 * from employee order by e_age DESC
--group by
select AVG(e_salary), e_gender from employee group by e_gender
select avg(e_age), e_dept from employee group by e_dept order by avg(e_age) desc

select e_dept, avg(e_salary) from employee
group by e_dept
having AVG(e_salary)>100000
--UPDATE
update employee
set e_age=42 where e_name='sam'
select * from employee

update employee 
set e_dept='tech'
where e_gender= 'female'

--DELETE
delete from employee
where e_age=33
select * from employee

delete from employee
where e_name='sam'

--TRUNCATE
TRUNCATE table employee
select * from employee

--creating derartment table
create table department(
d_id int not null,
d_name varchar(20),
d_location varchar(20),
primary key(d_id)
);

--inserting data into tables
insert into department
values(1,'content','new york')
insert into department 
values(2,'support','chicago')
insert into department
values(3,'analytics','new york')
insert into department
values(4,'sales','boston')
insert into department
values(5,'tech','dallas')
insert into department
values(6,'finance','chicago')

--JOINS
select * from employee
select * from department
--INNER JOIN
select employee.e_name, employee.e_dept, department.d_name, department.d_location
from employee
INNER JOIN department ON employee.e_dept=department.d_name
--LEFT JOIN
select employee.e_name,employee.e_dept,department.d_name,department.d_location
from employee
LEFT JOIN department
ON employee.e_dept=department.d_name
--RIGHT JOIN
 select employee.e_name,employee.e_dept,department.d_name,department.d_location
 from employee
 RIGHT JOIN department
 on employee.e_dept=department.d_name
 --FULL JOIN
 select employee.e_name,employee.e_dept,department.d_name,department.d_location
 from employee
 FULL JOIN department
 on employee.e_dept=department.d_name
 --UPDETE USING JOIN
 select * from employee
 select * from department
 
 UPDATE employee
 set e_age=e_age+10
 FROM employee join department
 on employee.e_dept=department.d_name
 where d_location='new york'

 select * from employee

 --delete using join
 delete employee
 from employee join department
 on employee.e_dept=department.d_name
 where d_location='new york'

 --creating tables student_details1 and student_details2
 create table student_details1(
 s_id int not null,
 s_name varchar(20),
 s_marks varchar(20),
 primary key(s_id)
 );

 insert into student_details1
 values(1,'sam',45)
insert into student_details1
values(2,'bob',87)
insert into student_details1
values(3,'anne',73)
insert into student_details1
values(4,'julia',92)
select * from student_details1

create table student_details2(
 s_id int not null,
 s_name varchar(20),
 s_marks varchar(20),
 primary key(s_id)
 );

insert into student_details2
 values(3,'anne',73)
insert into student_details2
values(4,'julia',92)
insert into student_details2
values(5,'matt',73)

select * from student_details2
delete from student_details2

--UNION OPERATOR
select * from student_details1
union
select * from student_details2
--UNION ALL
select * from student_details1
UNION ALL
select * from student_details2

select * from student_details1
select * from student_details2
delete from student_details1
where s_name='matt'

--EXCEPT OPERATOR
select * from student_details1
EXCEPT
select * from student_details2
--INTERSECT
select * from student_details1
INTERSECT
select * from student_details2
--VIEW
CREATE VIEW female_employee as
select * from employee 
where e_gender='female'

select * from female_employee
--DROP VIEW
DROP VIEW 
DROP VIEW female_employee
--ALTER TABLE_ADD COLUMN
alter table employee 
ADD e_dob date
select * from employee
--ALTER TABLE DROP COLUMN
alter table employee 
drop column e_dob
select * from employee
--MERGE STATEMENT
--CREATING EMPLOYEE_SOURCE TABLE
--EMPLOYEE_TARGET IS EMPLOYEE TABLE
CREATE TABLE employee_source(
e_id int not null,
e_name varchar(20),
e_salary int,
e_age int,
e_gender varchar(20),
e_dept varchar(20),
primary key(e_id)
);

insert into employee_source
values(1,'sam',93000,40,'male','operations')
insert into employee_source
values(2,'bob',80000,21,'male','support')
insert into employee_source
values(3,'anni',130000,25,'female','analytics')
insert into employee_source
values(6,'jeff',112000,27,'female','content')
insert into employee_source
values(7,'adam',100000,28,'male','content')
insert into employee_source
values(8,'priya',85000,37,'male','tech')

 select * from employee_source
 select * from employee
 --MERGE
 merge employee as T
 using employee_source as S
    on T.e_id=S.e_id
when matched
then update set T.e_salary=S.e_salary,T.e_age=S.e_age
when not matched by target
then insert (e_id,e_name,e_salary,e_age,e_gender,e_dept)
values(S.e_id,S.e_name,S.e_salary,S.e_age,S.e_gender,S.e_dept)
when not matched by source
then delete;
select * from employee
--USER DEFINE FUNCTION
--SCALAR VALUED FUNCTION
create function add_five(@num as int)
RETURNS int 
as
BEGIN
RETURN(@num+5)
end
--calling the function
select dbo.add_five(10)
--TABLUED VALUED FUNCTIONS
select * from employee
delete from employee

CREATE FUNCTION select_gender(@gender varchar(20))
returns table
as
return
(
select * from employee where e_gender=@gender
)
--calling the function
select * from dbo.select_gender('male')
select * from dbo.select_gender('female')
--temporary table
--creating a tempory table
create table #student(
s_id int,
s_name varchar(20)
);
--inserting values into temp table
insert into #student
values(1,'sam');
--vewing the temp table
select * from #student
--CASE statement
select 
case
when 10>20 then '10 is greater than 20'
when 10<20 then '10 is less than 20'
else '10 is equal to 20'
end
--implementing case with employee
select *,grade=
case
when e_salary <90000 then 'C'
when e_salary <120000 then 'B'
else 'A'
end
from employee
go
--IFF()
SELECT 
IIF(10>20,'10 is greater than 20','10 is less than 20')
--implimenting for employee table
select e_id,e_name, e_age, 
iif(e_age>30,'Old employee','New employee') as employee_generation
from employee
--STORED PROCEDURE
create procedure employee_age
as
select e_age from employee
go

exec employee_age

create procedure employee_details
as
select * from employee
go

exec employee_details
--stored procedure with parameters
create procedure employee_gender @gender varchar(20)
as
select * from employee
where e_gender=@gender
go

exec employee_gender @gender='male'
exec employee_gender @gender='female'
--EXCEPTION HANDLING
--divide a number by zero
declare @var1 int;
declare @var2 int;
begin try
set @var1=8;
set @var2=@var1/0;
end try
begin catch
print error_message()
end catch
--exception handling for employee table
select * from employee
begin try
select e_salary+e_name from employee
end try
begin catch
print 'can not add a numerical value with a string value'
end catch
go

--TRANSACTION
begin transaction
update employee set e_age=30 where e_name='sam'
select * from employee  
rollback transaction
--commit the transaction
begin transaction
update employee set e_age=30 where e_name='sam'
commit transaction

--updation  sam age to 45
update employee set e_age=45 where e_name='sam'
select * from employee
--transaction o employee table
begin try
   begin transaction
   update employee set e_salary=50 where e_gender='male'
   update employee set e_salary=195/0 where e_gender='female'
   commit transaction
   print 'transaction committed'
end try
begin catch
   rollback transaction
   print 'transaction rolledback'
end catch

select * from employee

begin try
   begin transaction
   update employee set e_salary=50 where e_gender='male'
   update employee set e_salary=195 where e_gender='female'
   commit transaction
   print 'transaction committed'
end try
begin catch
   rollback transaction
   print 'transaction rolledback'
end catch

select * from employee
--updating values back in employee table
update employee set e_salary=95000 where e_name='sam'
update employee set e_salary=80000 where e_name='bob'
update employee set e_salary=125000 where e_name='anni'
update employee set e_salary=73000 where e_name='julia'
update employee set e_salary=159000 where e_name='matt'
update employee set e_salary=122000 where e_name='jeff'

select * from employee

--changing recovery methods
--set DB to master
--SIMPLE recovery MODEL
USE [master]
GO
ALTER DATABASE
[AdventureWorks2014] 
set recovery simple with no_wait
go
--FULL RECOVERY MODEL
use [master]
go
alter database
[AdventureWorks2014]
set recovery full with no_wait
go
--BULK RECOVERY METHOD
use [master]
go
alter database
[AdventureWorks2014]
set recovery bulk_logged with no_wait
go

--data base realted DVM's
use tempdb;
go
select SUM(unallocated_extent_page_count) as [free pages],
(SUM(unallocated_extent_page_count)*1.0/128) as [free space in MB]
from sys.dm_db_file_space_usage;
--To get free log space in MB
use tempdb;
go
select (total_log_size_in_bytes-used_log_space_in_bytes)*1.0/1024/1024 as
[free log space in MB]
from sys.dm_db_log_space_usage;
--to get partition stats
use AdventureWorks2014;
go
select * from sys.dm_db_partition_stats;
go
--SQL OS related DMV's
SELECT count(*) as cached_pages_count
    CASE database_id
	when 32767 then 'Resourse Db'
	else db_name(database_id)
	end as database_name
from sys.dm_os_buffer_descriptors
group by DB_NAME(database_id), database_id
order by cached_pages_count desc


