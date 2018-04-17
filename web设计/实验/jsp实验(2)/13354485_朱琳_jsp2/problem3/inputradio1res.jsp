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
	String[] values;
	values=request.getParameterValues("color");
	
	for(String value:values){
		if(value.equals("red")){
			out.print("<span style=\"color:red\">"+value+"</span>&nbsp");
		}else if(value.equals("green")){
			out.print("<span style=\"color:green\">"+value+"</span>&nbsp");
		}else{
			out.print("<span style=\"color:blue\">"+value+"</span>&nbsp");
		}
	}	
%>
</body>
</html>

