<%@page import="javax.management.Query"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.util.*,java.util.Scanner,java.sql.*"%>

<%!
public class QueryItem{
	private Connection conn;
	public String exception_msg;
	ResultSet exeQuery(String sqlSentence) {
		Statement stat;
		ResultSet rs = null;
		try {
			stat = conn.createStatement(); // 获取执行sql语句的对象
			rs = stat.executeQuery(sqlSentence); // 执行sql查询，返回结果集
		}catch (Exception e) {
			exception_msg=e.getMessage();
			return null;
		}
		return rs;
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
			return false;
		}
	}

}%>

<%
	QueryItem item=new QueryItem();
	String id=request.getParameter("id");
	ResultSet rs=null;
	if(item.connect()){
		rs=item.exeQuery(String.format("select * from goods where id='%s';",id));
		
		if(rs!=null){
			rs.next();	
		}else{
			out.print("<span>"+item.exception_msg+"</span><br><br>");
		}
					
	}else{
		out.print("<span>connot connect the database!</span><br><br>");
	}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>browse the student</title>
<style>

body{
	MARGIN: 0px auto;
	background-image:url('back4.jpg');
}


.container {
	margin-top:40px;
	margin-left:400px;
}
th,td{
	padding-left:20px;
	padding-top:5px;
	height:20px;
}

img{
	width:250px;
	height:300px;
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

#price,#name,#tel,#publishMan,#content{
	background-color:#F5F5F5;
	padding:10px;
	font-family:微软雅黑;
	font-weight:600;
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
		<span id="back"><a href="browseGoods.jsp?userName=<%=userName%>&admin=<%=admin%>">返回首页</a>
		&nbsp;&nbsp;&nbsp;
		<a href="editGoods.jsp?userName=<%=userName%>&admin=<%=admin%>">发布商品</a>
		</span>
	</div>
<div class="container" style="clear:both">
	<table cellspacing="0"  id="inner_table">		
		<tr><td rowspan="7" ><img src=<%=rs.getString("img_url")%>></td></tr>
		<tr><td id="price">价格:<%=rs.getString("price")%></td></tr>
		<tr><td id="price">原价:<%=rs.getString("pre_price")%></td></tr>
		<tr><td id="publishMan">发布者:<%=rs.getString("userName")%></td></tr>	
		<tr><td id="name">名称:<%=rs.getString("name")%></td></tr>	
		<tr><td id="tel">联系方式:<%=rs.getString("tel")%></td></tr>		
		<tr><td id="content"><%=rs.getString("detail")%></td></tr>
	</table>
	
	
</div>

</body>
</html>