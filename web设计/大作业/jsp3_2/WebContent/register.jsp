<%@ page language="java" import="java.util.*,java.io.*,java.sql.*"
	contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>注册</title>
<style>
h1 {
	color:yellow;
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
		<h1>用户注册</h1>
		<form action="" method="post">
			姓名:<input type="text" name="name"><br><br>
			密码:<input type="password" name="password"><br><br>
			性别:&nbsp; Male<input type="radio" name="sex" value="male" checked/>
			&nbsp; Female<input type="radio" name="sex" value="female"><br><br>
			 电话:<input id="tel" type="text" name="tel"> <br><br>
			 邮箱:<input id="email" type="text" name="email"> <br> <br>
			是否管理员:&nbsp; 是<input type="radio" name="admin" value="yes">
			&nbsp; 否<input type="radio" name="admin" value="no" checked/><br /> <br />
			<%
				String msg = "";
				String name = request.getParameter("name");
				String password = request.getParameter("password");
				String sex = request.getParameter("sex");
				String tel = request.getParameter("tel");
				String email = request.getParameter("email");
				String admin=request.getParameter("admin");

				String s1 = request.getParameter("register"); // value of input(submit) or null
				String s2 = request.getParameter("cancel");
				if (s1 != null) {
					String connectString = "jdbc:mysql://localhost:3306/db13354453"
							+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
					try {
						Class.forName("com.mysql.jdbc.Driver");
						Connection conn = DriverManager.getConnection(connectString, "user", "123456");
						Statement stmt = conn.createStatement(); //建立语句
						if(name=="")
						{
							msg = "用户名为空，注册失败";
						}else{
							String sql = String.format("insert into users(userName,password,sex,tel,email,admin) values('%s','%s','%s','%s','%s','%s')", name,
									password, sex, tel, email,admin);
							System.out.println(sql);
							int cnt = stmt.executeUpdate(sql); // 执行sql语句,返回所影响行记录的个数
							if (cnt > 0 ) {
								msg = "注册成功！";
								response.sendRedirect("login.jsp");
							} else {
								msg = "注册失败，该用户名已经被使用";
							}
						}
						
					} catch (Exception e) {
						//out.println("没有连接上数据库！");
						out.println(e.getMessage());
					}
					out.println(msg);
				}
				if(s2!=null){
					response.sendRedirect("welcome.jsp");
				}
			%>
			<br /><br />
			<input class="a" type="submit" name="register" value="注册"> &nbsp;
			&nbsp; <input  class="a" type="submit" name="cancel" value="取消"> <br />
		</form>
		<br /> 
	</div>
</body>
</html>