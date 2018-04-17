<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>

</head>
<body>
<%
	String val1=new String();
	String val2=new String();
	String value1=request.getParameter("username");
	val1="Hello!";
	val2="Hello!";
	String saveButton=request.getParameter("submit1");
	if(saveButton!=null){
		val1=value1;
	}
	
%>

<form>
	用户名:<input type="text" name="username" value="<%=val1%>" />
	<input type="hidden" name="username2" value="<%=val2%>" >
	<br><br>
	<input type="submit" name="submit1" value="提交"/>
</form>
<p>
<%
if(saveButton!=null){
	if(val1.equals(val2)){
		out.print("unchanged");
	}else{
		out.print("changed");
	}
}
%>
</p>
</body>
</html>