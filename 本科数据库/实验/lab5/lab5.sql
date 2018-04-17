CREATE TABLE Students(
	SID int,
	name CHAR(20),
	category CHAR(20)
);

CREATE TABLE Works(
	SID int,
	CID CHAR(20),
	Type CHAR(20)
);

CREATE TABLE Corporations(
	CID CHAR(20),
	Cname CHAR(20)
);


insert into Students values(10330000,"James","graduate");
insert into Students values(11330000,"Maria","undergraduate");
insert into Students values(12330000,"Zack","undergraduate");

insert into Works values(10330000,"PRC001","Employee");
insert into Works values(12330000,"PRC001","Intern");
insert into Works values(16330000,"USA001","Intern");

insert into Corporations values("PRC001","Alibaba");
insert into Corporations values("PRC002","Tencent");
insert into Corporations values("USA001","Google");
