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
	String[] sel=new String[4];
	String value=request.getParameter("college");
	String saveButton=request.getParameter("submit1");
	if(saveButton!=null){
		if(value.equals("freshman")){
			sel[0]="selected";
		}else  if(value.equals("sophomore")){
			sel[1]="selected";
		}else if(value.equals("junior")){
			sel[2]="selected";
		}else if(value.equals("senior")){
			sel[3]="selected";
		}			
	}else{
		sel[1]="selected";
	}
	
%>
<form>
	<select name="college">
	<option value="freshman" <%=sel[0]%> >大学一年级</option>
	<option value="sophomore" <%=sel[1] %> >大学二年级</option>
	<option value="junior"  <%=sel[2] %> >大学三年级</option>
	<option value="senior"  <%=sel[3] %> >大学四年级</option>
	</select>
	<br><br>
	<input type="submit" name="submit1" value="提交"/>	
</form>
<p>
<%=value%>
</p>

</body>
</html>