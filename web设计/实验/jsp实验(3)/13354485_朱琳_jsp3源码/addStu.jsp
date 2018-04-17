<%@page import="sun.nio.ch.SelChImpl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.util.*,java.util.Scanner,java.sql.*"%>

<%!
public class InsertStu{
	private Connection conn;
	public String exception_msg;
	//执行sql语句
	boolean executeInsert(String sqlSentence) {
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
<title>增加学生记录</title>
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
	margin-left:100px
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
	String num="",name="",age="",grade="",hobby="";
	String saveButton=request.getParameter("sub");
	String check1[]=new String[4];
	String check2[]=new String[3];	
	
	if(saveButton!=null){
		num=request.getParameter("num");
		name=request.getParameter("name");
		age=request.getParameter("age");
		grade=request.getParameter("grade");
		String[] hobby_;
		hobby_=request.getParameterValues("hobby");
		hobby=Arrays.toString(hobby_);
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
	}
	
%>

<body>
<div class=container>
	<h1>新增学生记录</h1>
	<form action="addStu.jsp" method="post">
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
	
	<br><br><input id=sub name=sub value="保存" type=submit>
	</form><br>
	
	<%	
		
		if(saveButton!=null){
			InsertStu stu=new InsertStu();
			if(stu.connect()){
				String sql=String.format("insert into stu(num,name,age,grade,hobby) values('%s','%s','%s','%s','%s');",num,name,age,grade,hobby);
				if(stu.executeInsert(sql)){
					out.print("<span style=\"margin-left:90px\">插入成功！</span><br><br>");
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