DROP TABLE IF EXISTS collection ;
DROP TABLE IF EXISTS g;

create table g{
	gid int,
	make varchar(20),
	PRIMARY KEY(gid)
};

CREATE TABLE collection
{
	userID	varchar(40),
	goods_id int,
	primary key(userID, goods_id),
	foreign key(goods_id) references g(gid)
};
delimiter $
create trigger before_make_order
after delete on g
for each row
begin 
	delete from collection where goods_id=old.gid;
end $
delimiter ;
	