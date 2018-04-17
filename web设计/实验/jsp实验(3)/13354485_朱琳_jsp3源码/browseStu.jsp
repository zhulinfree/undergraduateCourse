<%@page import="javax.management.Query"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>browse the student</title>
<style>
th,td{
	text-align:center;
}
A:link {
	COLOR: blue
}
A:visited {
	COLOR: blue
}
.container {
	TEXT-ALIGN: center; MARGIN: 0px auto; WIDTH: 600px
}
</style>
</head>

<%@ page import="java.util.*,java.util.Scanner,java.sql.*"%>

<%!
public class QueryStu{
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
		String connectString = "jdbc:mysql://202.116.76.22:3306/test"
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
	ResultSet rs=null;
	final int pageSize=4;//每页显示的记录的数量
	int rowCount=0;//总的记录数量
	int currentPage=1;//当前页数
	int pageCount=0;//总页数
	String strPage,idIndex;
	strPage=request.getParameter("page");
	if(strPage==null){
		currentPage=1;
	}else{
		currentPage=Integer.parseInt(strPage);
		if(currentPage<1){
			currentPage=1;
		}
	}
%>

<%
	QueryStu stu=new QueryStu();
	if(stu.connect()){
		rs=stu.exeQuery("select * from stu;");
		if(rs!=null){
			rs.last();
			rowCount = rs.getRow();//计算 当前的记录的总数量
			pageCount = (rowCount-1) / pageSize+1;//计算需要的总的页数
			if (currentPage > pageCount) {
				currentPage = pageCount;
			}	
		}else{
			out.print("<span>"+stu.exception_msg+"</span><br><br>");
		}
					
	}else{
		out.print("<span>connot connect the database!</span><br><br>");
	}
%>

<body>
<div class="container" style="clear:both">
	<h1>
		浏览学生名单
	</h1>
	<table border="1" cellspacing="0">
		<tr>
			<th width=15%>num</th>
			<th width=20%>name</th>
			<th width=5%>age</th>
			<th width=20%>grade</th>
			<th width=25%>hobby</th>
			<th width=20%>-</th>
		</tr>
		
		<%
			if (pageCount> 0) {
				rs.absolute((currentPage - 1) * pageSize + 1);
				int i = 0;
				while (i < pageSize && !rs.isAfterLast()) {
					idIndex= rs.getString("id");
		%>
		<tr>
			<td><%=rs.getString("num")%></td>
			<td><%=rs.getString("name")%></td>
			<td><%=rs.getString("age")%></td>
			<td><%=rs.getString("grade")%></td>
			<td><%=rs.getString("hobby")%></td>
			<td><a href="update.jsp?id=<%=idIndex%>">修改</a>&nbsp;<a href="delete.jsp?id=<%=idIndex%>">删除</a></td>
		</tr>
		<%
			rs.next();
					i++;
				}
			}			
		%>	
	</table>
	
<div style="float: left;margin-top:10px"><a href="addStu.jsp">新增</a> </div>
<div style="float: right;margin-top:10px">
<%if(currentPage>1){ %>
<a href="browseStu.jsp?page=<%=currentPage - 1%>">上一页</a> 
<%} %>
&nbsp; 
<%if(currentPage < pageCount){ %>
<a href="browseStu.jsp?page=<%=currentPage + 1%>">下一页</a> 
<%} %>
</div>

<div style="clear:both">
共有<%=rowCount %>条记录 &nbsp;&nbsp;&nbsp;第<%=currentPage %>页  共<%=pageCount %>页
</div>

</div>
</body>
</html>