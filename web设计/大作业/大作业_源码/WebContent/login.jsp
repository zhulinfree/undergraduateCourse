<%@ page language="java" import="java.util.*,java.io.*,java.sql.*"
	contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>登录</title>
<style>
h1 {
	color: yellow
}

input.a {
	padding: 5px 20px 5px 20px;	
	margin-left:70px;
	border: 1px solid black;
	border-radius: 8px;
	border: 1px solid black;
}
.container {
	
}
#name,#psd{
	width:300px;
	height:30px;
}
fieldset {
	width:400px;
	margin:20px auto;
	margin-top:100px;
	margin-bottom:5px;
	padding:20px 10px 20px 10px;
	background-color:#FCFCFF;
	text-align:left;
}

legend{
	background-color:skyblue;
	padding:5px 20px 5px 20px;
	margin-left:10px;
	box-shadow: -2px 2px 2px #808080;
}
body{
	background-image:url("image/back4.jpg");
}
</style>
</head>
<body>
	<div class="container">	
		<form action="" method="post">
			<fieldset>
			<legend>用户登录</legend>
			姓名: <input id="name" type="text" name="userName"><br><br>
			密码: <input id="psd" type="password" name="password"><br> <br>
			<input class="a" type="submit" name="cancel" value="注册">&nbsp; &nbsp;
			<input class="a" type="submit" name="login" value="登录"><br>			
			</fieldset>
		</form> 
	<%
	String msg = "";
	boolean error = false;
	String userName = request.getParameter("userName");
	String password =  request.getParameter("password");
	String pasw = "",admin="no";

	String connectString = "jdbc:mysql://localhost:3306/db13354453"
			+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
	
	String saveButton=request.getParameter("login"); //判断是否按了保存按钮
	String saveButton2=request.getParameter("cancel"); //判断是否按了保存按钮
	
	if(saveButton!=null){
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection(connectString, "user", "123456");
			Statement stmt = conn.createStatement(); //建立语句
			String sql = String.format("SELECT * FROM users where userName=\'" + userName + "\'");
			System.out.println(sql);
			ResultSet rs = stmt.executeQuery(sql);// 执行sql语句
			while (rs.next()) {
				pasw = rs.getString("password");
				admin=rs.getString("admin");
				System.out.println("pasw "+pasw);
			}
			rs.close();
			stmt.close();
			if (pasw.equals(password)) {
				out.print("登录成功！");
				response.sendRedirect("browseGoods.jsp?userName="+userName+"&admin="+admin);
			} else {
				out.print("用户名或者密码错误！");
			}
		} catch (Exception e) {
			out.println(e.getMessage());
		}
	}
	
	if(saveButton2!=null){
		response.sendRedirect("register.jsp");
	}
	
%>
</div>
</body>
</html>