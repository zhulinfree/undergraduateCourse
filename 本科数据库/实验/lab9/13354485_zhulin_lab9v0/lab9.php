<?php
	$conn= new mysqli("localhost","root","112233");
	$sql=$_GET["sql"];
	$db=$_GET["db"];
	if($db!=""){
		$db='use '.$db.';';
		$u=$conn->query($db);
	}
	if($res=$conn->query($sql)){
		if(preg_match('/select *.+/',$sql)){
			echo '<table border="1" cellspacing="0">';
			echo '<tr><th>id</th><th>name</th><th>phone</th></tr>';
			While ($row = $res->fetch_array()) {
				echo '</tr>';
				echo '<td>'.$row['id'].'</td><td>'.$row['name'].'</td><td>'.$row['phone'].'</td>';
				echo '</tr>';
			}
			echo '</table>';			
		}else{
			if($res){
				echo 'Query OK<br>';
			}
		}
	}else{
		echo 'Query Error!';
	}

	echo '<a href="lab9.html">Back</a>';
?>