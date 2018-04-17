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
	String value=request.getParameter("content");
	String saveButton=request.getParameter("submit1");
	val="hello,world!welcome!";
	if(saveButton!=null){
		val=value;	
	}
%>

<form>
	<textarea name="content" id="content" 
	style="overflow-y:scroll;height:100px;width:300px"><%=val%></textarea>
	<br><br>
	<input type="submit" name="submit1" value="提交"/>	
</form>
<p>
<%
out.print(value);
%>
</p>
</body>
</html>