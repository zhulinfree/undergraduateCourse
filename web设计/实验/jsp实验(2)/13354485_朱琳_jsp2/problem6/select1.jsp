<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>

</head>
<body>
<form action="select1res.jsp" method="post">
	<select name="college">
	<option value="freshman">大学一年级</option>
	<option value="sophomore" selected>大学二年级</option>
	<option value="junior" >大学三年级</option>
	<option value="senior" >大学四年级</option>
	</select>
	<br><br>
	<input type="submit" name="submit1" value="提交"/>	
</form>
</body>
</html>