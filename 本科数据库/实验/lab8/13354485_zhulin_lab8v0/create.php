<?php
	$conn = mysql_connect("localhost","root","112233");
	$sql='create database week12;';
	$create_db=mysql_query($sql,$conn);

	mysql_select_db('week12',$conn);
	$sql='create table lab8(country varchar(20),area varchar(20),school varchar(20));';
	$create_table=mysql_query($sql,$conn);
	
	$sql='insert into lab8 values("China","Guangzhou","SYSU");';
	$insert=mysql_query($sql,$conn);
	$sql='insert into lab8 values("America","Galifornia","UCLA");';
	$insert2=mysql_query($sql,$conn);
	
	$sql='update lab8 set school="UCB" where country="America";';
	$update=mysql_query($sql,$conn);
	
	$sql='delete from lab8 where country="America";';
	$delete=mysql_query($sql,$conn);
	
	if($create_db==true){
		echo 'create database success!</br>';
		if($create_table==true){
			echo 'create table success!</br>';
			if($insert&&$insert2){
				echo 'insert items success!</br>';
				if($update==true){
					echo 'update items success!</br>';
					if($delete==true){
						echo 'delete items success!</br>';
					}else{
						echo 'delete items failed!</br>';
					}
				}else{
					echo 'update items failed!</br>';
				}
			}else{
				echo 'insert items failed!</br>';
			}
		}else{
			echo 'create table failed!</br>';
		}
	}else{
		echo 'create database failed!</br>';
	}
	
?>
