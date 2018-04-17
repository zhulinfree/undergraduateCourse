DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;
DROP TABLE IF EXISTS Works_in;
DROP TABLE IF EXISTS Manages;
DROP TABLE IF EXISTS Dependents;

CREATE TABLE Employees 
(
	ssn	char(10),
	salary	int,
	phone	char(11),
	primary key(ssn)
);

CREATE TABLE Departments 
(
	dno	int,
	budget	int,
	dname	varchar(20),
	primary key(dno)
);

CREATE TABLE Works_in
(
	ssn	char(10),
	dno	int,
	primary key(ssn, dno),
	foreign key(ssn) references Employees(ssn),
	foreign key(dno) references Departments(dno)
);

CREATE TABLE Manages
(
	ssn char(10),
	dno int,
	primary key(dno),
	foreign key(ssn) references Employees(ssn),
	foreign key(dno) references Departments(dno)
);

CREATE TABLE Dependents
(
	ssn	char(10),
	name	char(10),
	age	int,
	primary key(ssn, name),
	foreign key(ssn) references Employees(ssn)
);


use company2;
insert into Departments values(123,1000000,"God");
insert into Employees values("13354",10000,1372623);
insert into Employees values("13355",5000,1371932);
insert into Employees values("13356",5000,1371933);

insert into Works_in values("13354",123);
insert into Works_in values("13355",123);
insert into Works_in values("13356",123);

insert into Manages values("13354",123);

insert into Dependents values("13354","Kitty",10);
insert into Dependents values("13354","Hello",14);
insert into Dependents values("13355","Yeah",20);




