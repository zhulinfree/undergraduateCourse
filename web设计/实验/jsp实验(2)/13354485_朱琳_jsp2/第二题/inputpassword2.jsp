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
	String val=new String();
	val="123";
	String saveButton=request.getParameter("submit1");
	if(saveButton!=null){
			val=request.getParameter("psd");
	}
	
%>
<form>
	password:<input type="password" name="psd" value="<%=val%>"/><br><br>
	<input type="submit" name="submit1" value="提交"/>	
</form>
<p><%=val%></p>

</body>
</html>