<?php
	$conn = mysql_connect("localhost", "root", "");
	$sql = $_POST['sql'];
	$db = $_POST['db'];

	if (!empty($db))
		mysql_select_db($db, $conn);
	
	if (mysql_query($sql, $conn)) {
		$result = array('content' => 'true', 'status' => 1,);
	}
	else {
		$result = array('content' => 'false', 'status' => 0,);
	}
	mysql_close($conn);
	echo json_encode($result);
?>
