<%@page import="sun.nio.ch.SelChImpl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.util.*,java.util.Scanner,java.sql.*"%>

<%!public class DeleteItem {
	private Connection conn;
	public String exception_msg;
	//执行sql语句
	boolean executeDelete(String sqlSentence) {
		Statement stat;
		try {
			stat = conn.createStatement(); // 根据连接获取一个执行sql语句的对象
			stat.executeUpdate(sqlSentence); // 执行sql语句,插入需要插入的元素
		} catch (Exception e) {
			exception_msg=e.getMessage();
			return false;
		}
		return true;
	}

	// 建立连接
	boolean connect() {
		String connectString = "jdbc:mysql://localhost:3306/db13354453"
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
<title>删除商品记录</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style>
body{
	MARGIN: 0px auto;
	background-image:url('image/back4.jpg');

}
.container {
	margin-top:40px;
	margin-left:550px;
}

a{
	color:grey;
	text-decoration:none;
}

a:hover{
	color:#1E90FF;
}

span{
	text-align:center;
}
#top{
	padding-top:10px;	
	height:30px;
	width:100%;	
	background-color:RGB(245,245,245);
	box-shadow: -2px 2px 2px #808080;
}
#login{	
	padding-left:300px;	
}
#back{
	float:right;
	margin-right:200px;
}
#delete{
	margin-left:60px;
	padding-top:150px;	
	font-family:幼圆;
	font-weight:600;
	font-size:1.5em;
	color:brown;
}


</style>
</head>


<body>

<%String userName=request.getParameter("userName");
 	 String admin=request.getParameter("admin");
	%>	
<div id="top">
		<%String login=userName.equals("null")?"登录":"欢迎你,"+userName; %>
		<span id="login"><a href="register.jsp">注册</a>&nbsp;&nbsp;&nbsp;<a href="login.jsp"><%=login%></a></span>	
		<span id="back"><a href="browseGoods.jsp?userName=<%=userName%>&admin=<%=admin%>">首页</a>
		&nbsp;&nbsp;&nbsp;
		<a href="editGoods.jsp?userName=<%=userName%>&admin=<%=admin%>">发布商品</a>
		&nbsp;&nbsp;<a href="myGoods.jsp?userName=<%=userName%>&admin=<%=admin%>">我的商品</a></span>
</div>
<div class=container>		
		<%
			DeleteItem item = new DeleteItem();
			if (item.connect()) {
				String sql = String.format("delete from goods where id=\"%s\";",request.getParameter("id"));
				if (item.executeDelete(sql)) {
					out.print("<p id=\"delete\">删除成功！</p><br><br>");
				} else {
					out.print("<span>" + item.exception_msg + "</span><br><br>");
				}
			} else {
				out.print("<span>connot connect the database!</span><br><br>");
			}
		%>
	<div id="backHome">
		<span><a href="browseGoods.jsp?userName=<%=userName%>&admin=<%=admin%>" style="background-color:#1E90FF;color:black;padding:10px">返回首页</a></span>
		&nbsp;&nbsp;&nbsp;
		<span><a href="myGoods.jsp?userName=<%=userName%>&admin=<%=admin%>" style="background-color:#A9A9A9;color:black;padding:10px">我的商品</a></span>
	</div>
		
		
		
	</div>

</body>
</html>