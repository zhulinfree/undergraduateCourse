<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>welcome</title>
<style>
div.w1 {
	text-align: center;
	font-size: 60px;
	color: blue;
	font-weight: bold;
}

form.a {
	position: absolute;
	float: left;
	margin-top: 150px;
	margin-left: 300px;
}

form.b {
	position: absolute;
	float: left;
	margin-top: 150px;
	margin-left:600px;
}

form.c {
	position: absolute;
	float: left;
	margin-top: 150px;
	margin-left:900px;
}

input {
	padding: 20px;
	margin: 20px;
	border: 1px solid black;
	border-radius: 20px;
	border: 1px solid black;
}

body {
	background-image: url('image/welcome.jpg');
	background-color:#ff69b4;
	background-position:top;
	background-repeat: no-repeat;
	position: absolute;
	left:0;
	top: 0	;																												;
	width: 100%;
	height: 100%;
	padding: 0;
	margin: 0;
}
</style>
</head>
<body>
	<div class="w1">欢 迎 来 到     跳 蚤 市 场</div>
	<form class="a">
		<input type="submit" name="register" value="注册">
	</form>

	<form class='b'>
		<input type="submit" name="login" value="登录">
	</form>

	<form class="c">
		<input type="submit" name="into" value="进入">
	</form>
</body>
</html>

<%
	String s1 = request.getParameter("register"); // value of input(submit) or null
	String s2 = request.getParameter("login");
	String s3 = request.getParameter("into");
	if (s1 != null) {
		response.sendRedirect("register.jsp");
	}
	if (s2 != null) {
		response.sendRedirect("login.jsp");
	}
	if (s3 != null) {
		response.sendRedirect("browseGoods.jsp?userName=null&admin=no");
	}
%>