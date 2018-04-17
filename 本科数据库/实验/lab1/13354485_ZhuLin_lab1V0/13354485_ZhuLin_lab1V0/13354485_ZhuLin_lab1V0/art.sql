DROP TABLE IF EXISTS Artist;
DROP TABLE IF EXISTS Art;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Made;

CREATE TABLE Artist 
(
	name varchar(20),
	age	int,
	birthAddress varchar(20),
	style varchar(20),
	primary key(name)
);

CREATE TABLE Art
(
    title	varchar(20),
	style	varchar(20),
	createDate	varchar(20),
	price  int,
	primary key(title)
);


CREATE TABLE Customer
(
	name varchar(20),
	address	varchar(20),
	age	int,
	allCost int,
	title varchar(20),
	favorit_name varchar(20),
	primary key(title,favorit_name,name),
	foreign key(title) references Art(title),
	foreign key(favorit_name) references Artist(name)
);

CREATE TABLE Made
(
	name varchar(20),
	title	varchar(20),
	primary key(title),
	foreign key(name) references Artist(name),
	foreign key(title) references Art(title)
);

use Artbase;
insert into Artist values("John",30,"China","portrait");
insert into Artist values("Bob",80,"Lendon","portrait");
insert into Artist values("Ann",25,"China","scenery");

insert into Art values("Queen","portrait","20101009","1000");
insert into Art values("King","portrait","20080108","200000");
insert into Art values("Linda","portrait","20100126","5000");
insert into Art values("Beijing","scenery","20150108","2000");
insert into Art values("Zhuhai","scenery","20150101","2000");

insert into Made values("John","Queen");
insert into Made values("John","King");
insert into Made values("Bob","Linda");
insert into Made values("Ann","Beijing");
insert into Made values("Ann","Zhuhai");

insert into Customer values("Hello","China",20,8880,"Beijing","Ann");
insert into Customer values("Kitty","Zhuhai",50,100000,"Zhuhai","Ann");

select * from Art;
select * from Artist;
select * from Made;
select * from Customer;
