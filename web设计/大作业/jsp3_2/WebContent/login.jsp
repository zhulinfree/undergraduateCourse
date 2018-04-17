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
	padding: 20px;
	margin: 20px;
	border: 1px solid black;
	border-radius: 20px;
	border: 1px solid black;
}

.container {
	margin: 0 auto;
	width: 300px;
	background-color: #1e90ff;
	border: 5px solid #4169e1;
	text-align: center;
	border-radius: 1em/1em;
}
body{
background-color:#6495ed;
}
</style>
</head>
<body>
	<div class="container">
		<h1>用户登录</h1>
		<form action="" method="post">
			姓名:<input id="name" type="text" name="userName"><br><br>
			密码:<input type="password" name="password"><br> <br> 
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
		response.sendRedirect("welcome.jsp");
	}
	
%><br><br>
			<input class="a"
				type="submit" name="login" value="登录"> &nbsp; &nbsp; 
				<input class="a"
				type="submit" name="cancel" value="取消"> <br>
		</form>
	</div>
</body>
</html>