<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>

</head>
<body>
<form action="inputcheckbox1bres.jsp" method="post">
<p>
	<span>你在广州去过的景点：</span>
	珠江夜游<input type="checkbox" name="attractions" value="zjyy"/>&nbsp;
	大学城<input type="checkbox" name="attractions" value="dxc" checked/>&nbsp;
	白云山<input type="checkbox" name="attractions" value="bys"/>&nbsp;
	陈家祠<input type="checkbox" name="attractions" value="cjc"/>&nbsp;
	<br><br>
</p>
	<input type="submit" name="submit1" value="提交"/>	
</form>
</body>
</html>