CREATE TABLE NBA(
	Name	varchar(20),
	Nation	varchar(20),
	Score	int,
	Game_date	date,
	primary key (name)
);

insert into NBA values('LeBron', 'USA', '52', '2014-12-06');
insert into NBA values('Nowitzki', 'Germany', '48', '2011-05-18');
insert into NBA values('Irving', 'Australia', '44', '2014-04-06');
insert into NBA values('PauGasol', 'Spain', '46', '2015-01-11');
insert into NBA values('YaoMing', 'China', '41', '2009-02-23');
insert into NBA values('SteveNash', 'Canada', '42', '2006-12-08');
insert into NBA values('TonyParker', 'France', '55', '2008-11-06');
insert into NBA values('Ginobili', 'Argentina', '48', '2005-01-21');
insert into NBA values('Kirilenko', 'Soviet Union', '31', '2006-11-11');
insert into NBA values('YiJianlina', 'China', '31', '2010-03-27');
insert into NBA values('Kobe', 'USA', '81', '2006-01-22');
insert into NBA values('Mutombo', 'Congo', '39', '1992-02-03');

CREATE TABLE CONTINENT(
	Plate	varchar(20),
	Nation	varchar(20)
);

insert into CONTINENT values('EUROASIA', 'China');
insert into CONTINENT values('EUROASIA', 'Spain');
insert into CONTINENT values('EUROASIA', 'France');
insert into CONTINENT values('EUROASIA', 'Soviet Union');
insert into CONTINENT values('EUROASIA', 'Germany');
insert into CONTINENT values('America', 'USA');
insert into CONTINENT values('America', 'Canada');
insert into CONTINENT values('America', 'Argentina');
insert into CONTINENT values('Afreeca', 'Congo');