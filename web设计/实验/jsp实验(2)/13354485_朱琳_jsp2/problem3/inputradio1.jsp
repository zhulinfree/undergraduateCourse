<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>

</head>
<body>
<form action="inputradio1res.jsp" method="post">
<p>
	<span style="color:red">红色</span><input type="radio" name="color" value="red" />&nbsp;
	<span style="color:green">绿色</span><input type="radio" name="color" value="green"/>&nbsp;
	<span style="color:blue">蓝色</span><input type="radio" name="color" value="blue" checked/>&nbsp;
	<br><br>
</p>
	<input type="submit" name="submit1" value="提交"/>	
</form>
</body>
</html>