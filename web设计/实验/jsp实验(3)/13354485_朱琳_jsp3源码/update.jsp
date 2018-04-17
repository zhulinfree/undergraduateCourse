<%@page import="com.sun.xml.internal.ws.api.model.CheckedException"%>
<%@page import="jdk.internal.org.objectweb.asm.util.CheckAnnotationAdapter"%>
<%@page import="sun.nio.ch.SelChImpl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.util.*,java.util.Scanner,java.sql.*"%>

<%!
public class UpdateStu{
	private Connection conn;
	public String exception_msg;
	//执行sql语句
	boolean exeUpdate(String sqlSentence) {
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
			System.out.println(e.getMessage());
			return false;
		}	
	}
}
%>

<html>
<head>
<title>更新学生记录</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style>A:link {
	COLOR: blue
}
A:visited {
	COLOR: blue
}
.container {
	margin-left: 400px ;WIDTH: 500px
}
#sub{
	margin-left:70px
}
a{
	margin-left:105px
}

span{
text-align:center;
}
</style>
</head>

<%
	UpdateStu stu=new UpdateStu();
	String saveButton=request.getParameter("sub");
	String clearButton=request.getParameter("sub2");
	String id=request.getParameter("id");
	ResultSet rs;
	String num="",name="",age="",grade="",hobby="";
	
	String check1[]=new String[4];
	String check2[]=new String[3];	
	if(saveButton==null){	
		if(stu.connect()){
			//String id=request.getParameter("id");
			String sql_select = String.format("select * from stu where id=\"%s\";",id);
			rs=stu.exeQuery(sql_select);
			if(rs.next()){
				num=rs.getString("num");
				name=rs.getString("name");
				age=rs.getString("age");
				grade=rs.getString("grade");
				hobby=rs.getString("hobby");
			}
		
		}else{
			out.print("cannot connect");
		}
			
	}else{
		num=request.getParameter("num");
		name=request.getParameter("name");
		age=request.getParameter("age");
		grade=request.getParameter("grade");
		String[] _hobby=request.getParameterValues("hobby");
		hobby=Arrays.toString(_hobby);
	}
	switch (grade){
	case "freshman":
		check1[0]="checked";break;
	case "sophomore":
		check1[1]="checked";break;
	case "junior":
		check1[2]="checked";break;
	case "senior":
		check1[3]="checked";break;
	default:break;
	}
	if(hobby.contains("sports")) check2[0]="checked";
	if(hobby.contains("travel")) check2[1]="checked";
	if(hobby.contains("music")) check2[2]="checked";		
	//点击清空按钮之后
	if(clearButton!=null){
		num="";
		name="";
		age="";
		grade="";
		check1[0]="";
		check1[1]="";
		check1[2]="";
		check1[3]="";
		check2[0]="";
		check2[1]="";
		check2[2]="";
		
	}
	
%>

<body>
<div class=container>
	<h1>更新学生记录</h1>
	<form action="update.jsp?id=<%=id%>" method="post">
	学号:<input id=num name=num value="<%=num%>"> 
	<br><br>姓名:<input id=name name=name value="<%=name%>"> 
	<br><br>年龄:<input id=age name=age value="<%=age%>">
	
	<br><br>年级:
	<input type="radio" name="grade" value="freshman" <%=check1[0] %>/>大一&nbsp;
	<input type="radio" name="grade" value="sophomore" <%=check1[1] %>/>大二&nbsp;
	<input type="radio" name="grade" value="junior" <%=check1[2] %>/>大三&nbsp;
	<input type="radio" name="grade" value="senior" <%=check1[3] %>/>大四&nbsp;
	
	<br><br>爱好:
	<input type="checkbox" name="hobby" value="sports" <%=check2[0] %>/>运动&nbsp;
	<input type="checkbox" name="hobby" value="travel" <%=check2[1] %>/>旅行&nbsp;
	<input type="checkbox" name="hobby" value="music" <%=check2[2] %>/>音乐&nbsp;
	
	<br><br><input id=sub name=sub value="修改" type=submit>
	<input id=sub2 name=sub2 value="清空" type=submit>
	</form><br>
	<%		
		if(saveButton!=null){	
			if(stu.connect()){
				String sql = String.format("update stu set num=\"%s\",name=\"%s\",age=\"%s\",grade=\"%s\",hobby=\"%s\" where id=\"%s\";",num,name,age,grade,hobby,id);
				if(stu.exeUpdate(sql)){
					out.print("<span style=\"margin-left:90px\">更新成功！</span><br><br>");
				}else{
					out.print("<span>"+stu.exception_msg+"</span><br><br>");
				}			
			}else{
				out.print("<span>connot connect the database!</span><br><br>");
			}
		}	
	%>
	
	<a href="browseStu.jsp">返回</a> </div>
	
</body>
</html>