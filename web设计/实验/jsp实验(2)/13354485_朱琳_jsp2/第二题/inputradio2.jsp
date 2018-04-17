<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<%
	String[] sel=new String[3];
	String[] values;
	String saveButton=request.getParameter("submit1");
	values=request.getParameterValues("color");
	if(saveButton!=null){
		for(String val:values){
			if(val.equals("red")){
				sel[0]="checked";
			}else if(val.equals("green")){
				sel[1]="checked";
			}else{
				sel[2]="checked";
			}
		}	
	}else{
		sel[2]="checked";
	}
%>

<form>
<p>
	<span style="color:red">红色</span><input type="radio" name="color" value="red" <%=sel[0]%>/>&nbsp;
	<span style="color:green">绿色</span><input type="radio" name="color" value="green"<%=sel[1]%>/>&nbsp;
	<span style="color:blue">蓝色</span><input type="radio" name="color" value="blue" <%=sel[2]%>/>&nbsp;
	<br><br>
</p>
	<input type="submit" name="submit1" value="提交"/>	
</form>

<%
if(saveButton!=null){
	for(String value:values){
		if(value.equals("red")){
			out.print("<span style=\"color:red\">"+value+"</span>&nbsp");
		}else if(value.equals("green")){
			out.print("<span style=\"color:green\">"+value+"</span>&nbsp");
		}else{
			out.print("<span style=\"color:blue\">"+value+"</span>&nbsp");
		}
	}	
}
	
%>

</body>
</html>