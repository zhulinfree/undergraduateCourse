<?php
	$sql=$_GET["sql"];
	$con = mysql_connect("localhost","root","112233");
	mysql_select_db("week12",$con);
	
	if(strlen($sql)>0){
		if(mysql_query($sql,$con)){
			$response = '操作成功！';
		}else{
			$response = '操作失败！';
		}
	}else{
		$response = '您的输入有误！请重新输入';
	}
	echo $response
?>
