<%@page import="sun.nio.ch.SelChImpl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.util.*,java.util.Scanner,java.sql.*"%>

<%!public class DeleteStu {
		private Connection conn;
		public String exception_msg;

		//执行sql语句
		boolean executeDelete(String sqlSentence) {
			Statement stat;
			try {
				stat = conn.createStatement(); // 根据连接获取一个执行sql语句的对象
				stat.executeUpdate(sqlSentence); // 执行sql语句,插入需要插入的元素
			} catch (Exception e) {
				exception_msg = e.getMessage();
				return false;
			}
			return true;
		}

		// 建立连接
		boolean connect() {
			String connectString = "jdbc:mysql://202.116.76.22:3306/test"
					+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
			try {
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection(connectString, "user", "123456");
				return true;
			} catch (Exception e) {
				System.out.println(e.getMessage());
				return false;
			}
		}
	}%>

<html>
<head>
<title>删除学生记录</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style>
A:link {
	COLOR: blue
}

A:visited {
	COLOR: blue
}

.container {	
	margin-left:450px;
	WIDTH: 500px
}
a{
	margin-left:90px;
}
</style>
</head>


<body>
	<div class=container>
		<h1>删除学生记录</h1>
		<%
			DeleteStu stu = new DeleteStu();
			if (stu.connect()) {
				String sql = String.format("delete from stu where id=\"%s\";",request.getParameter("id"));
				if (stu.executeDelete(sql)) {
					out.print("<span style=\"margin-left:70px\">删除成功！</span><br><br>");
				} else {
					out.print("<span>" + stu.exception_msg + "</span><br><br>");
				}
			} else {
				out.print("<span>connot connect the database!</span><br><br>");
			}
		%>
		<a href="browseStu.jsp">返回</a>
	</div>

</body>
</html>