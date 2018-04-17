DROP TABLE IF EXISTS register_and_login;
DROP TABLE IF EXISTS collection;
DROP TABLE IF EXISTS goods;
DROP TABLE IF EXISTS personnalInfo;

CREATE TABLE register_and_login (
  userID varchar(40) NOT NULL,
  password varchar(40) DEFAULT NULL,
  nick_name varchar(50) DEFAULT NULL,
  PRIMARY KEY (userID)
);

CREATE TABLE goods (
  goods_id int(11) NOT NULL AUTO_INCREMENT,
  imgURL varchar(5000) DEFAULT NULL,
  name varchar(100) DEFAULT NULL,
  description varchar(300) NOT NULL,
  classifi varchar(50) DEFAULT NULL,
  contact_me varchar(50) DEFAULT NULL,
  userID varchar(40) DEFAULT NULL,
  latitude double DEFAULT NULL,
  longitude double DEFAULT NULL,
  PRIMARY KEY (goods_id),
  foreign key(userID) references register_and_login(userID)
) AUTO_INCREMENT=0 ;

CREATE TABLE collection
(
	userID	varchar(40),
	goods_id int,
	primary key(userID, goods_id),
	foreign key(goods_id) references goods(goods_id)
);

CREATE TABLE personnalInfo
(
	userID	varchar(50),
	school varchar(20),
	sex varchar(10),
	realName varchar(100),
	phone varchar(30),
	foreign key(userID) references register_and_login(userID),
	PRIMARY KEY (userID)
);


delimiter $
create trigger after_delete
after delete on goods
for each row
begin 
	delete from collection where goods_id=old.goods_id;
end $
delimiter ;
	