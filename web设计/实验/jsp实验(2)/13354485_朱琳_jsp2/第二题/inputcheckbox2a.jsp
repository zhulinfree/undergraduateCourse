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
	String[] sel=new String[3];
	String saveButton=request.getParameter("submit1");
	String values1=new String();
	String values2=new String();
	String values3=new String();
	sel[0]="checked";
	if(saveButton!=null){
		values1=request.getParameter("resident");
		values2=request.getParameter("student");
		values3=request.getParameter("sports");	
		if(values1!=null){
			sel[0]="checked";
		}else{
			sel[0]="";
		}
		if(values2!=null){
			sel[1]="checked";
		}
		if(values3!=null){
			sel[2]="checked";
		}
	}	
%>


<form>
<p>
	是否常住本市<input type="checkbox" name="resident" value="res" <%=sel[0]%>/>&nbsp;
	是否学生<input type="checkbox" name="student" value="stu" <%=sel[1]%>/>&nbsp;
	是否喜欢运动<input type="checkbox" name="sports" value="spt" <%=sel[2]%>/>&nbsp;
	<br><br>
</p>
	<input type="submit" name="submit1" value="提交"/>	
</form>
<p>
<%out.print(values1+"&nbsp"+values2+"&nbsp"+values3+"&nbsp"); %>
</p>

</body>
</html>