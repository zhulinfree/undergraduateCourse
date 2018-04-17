DROP TABLE IF EXISTS goods;
DROP TABLE IF EXISTS orders;

CREATE TABLE goods
(   
	id int primary key not null,
	name varchar(20),
	price int,
	number int
);

CREATE TABLE orders
(
	order_id int primary key not null AUTO_INCREMENT,
	good_id int,
	number int
)AUTO_INCREMENT=1401;

insert into goods values(1001,"T-Shirt",20,1000);
insert into goods values(1002,"Mobile_pho",1000,20);
insert into goods values(1003,"Cup",10,800);

delimiter $
create trigger before_make_order
before insert on orders
for each row
begin 
	if new.number>20 and new.good_id=1001 then
		set new.number=20;
	end if;
end $

create trigger make_order
after insert on orders
for each row
begin
	update goods set number=goods.number-new.number where goods.id=new.good_id;
end $

create trigger delete_order
after delete on orders
for each row
begin
	update goods set number=goods.number+old.number where goods.id=old.good_id;
end $

create trigger update_order
after update on orders
for each row
begin
	update goods set number=goods.number+old.number-new.number where goods.id=old.good_id;
end $
delimiter ;
	