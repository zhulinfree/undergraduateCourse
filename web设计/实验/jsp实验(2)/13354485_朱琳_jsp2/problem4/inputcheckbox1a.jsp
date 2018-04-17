<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>

</head>
<body>
<form action="inputcheckbox1ares.jsp" method="post">
<p>
	是否常住本市<input type="checkbox" name="resident" value="res" checked/>&nbsp;
	是否学生<input type="checkbox" name="student" value="stu"/>&nbsp;
	是否喜欢运动<input type="checkbox" name="sports" value="spt"/>&nbsp;
	<br><br>
</p>
	<input type="submit" name="submit1" value="提交"/>	
</form>
</body>
</html>