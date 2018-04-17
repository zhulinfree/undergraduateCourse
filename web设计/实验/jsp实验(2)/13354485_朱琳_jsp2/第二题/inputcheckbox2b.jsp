<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<%
	String[] sel=new String[4];
	String[] values;
	values=request.getParameterValues("attractions");
	String saveButton=request.getParameter("submit1");
	if(values!=null&&saveButton!=null){
		for(String val:values){
			if(val.equals("zjyy")){
				sel[0]="checked";
			}
			if(val.equals("dxc")){
				sel[1]="checked";
			}
			if(val.equals("bys")){
				sel[2]="checked";
			}
			if(val.equals("cjc")){
				sel[3]="checked";
			}
		}	
	}else{
		sel[2]="checked";
	}
	
%>


<form>
<p>
	<span>你在广州去过的景点：</span>
	珠江夜游<input type="checkbox" name="attractions" value="zjyy" <%=sel[0]%>/>&nbsp;
	大学城<input type="checkbox" name="attractions" value="dxc"  <%=sel[1]%>/>&nbsp;
	白云山<input type="checkbox" name="attractions" value="bys" <%=sel[2]%>/>&nbsp;
	陈家祠<input type="checkbox" name="attractions" value="cjc" <%=sel[3]%>/>&nbsp;
	<br><br>
</p>
	<input type="submit" name="submit1" value="提交"/>	
</form>
<p>
<%
	if(saveButton!=null){
		String v=Arrays.toString(values);
		out.print(v);
	}
%>
</p>
</body>
</html>