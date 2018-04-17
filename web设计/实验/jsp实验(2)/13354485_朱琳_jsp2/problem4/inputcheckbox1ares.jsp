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
	request.setCharacterEncoding("utf-8");
	String values1=new String();
	String values2=new String();
	String values3=new String();
	values1=request.getParameter("resident");
	values2=request.getParameter("student");
	values3=request.getParameter("sports");
	out.print(values1+"&nbsp"+values2+"&nbsp"+values3+"&nbsp");
%>
</body>
</html>