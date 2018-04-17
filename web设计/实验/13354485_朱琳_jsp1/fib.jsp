<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%	final int COUNT = 40;
	int fibs[] = new int[COUNT+1];
	double nums[]=new double[COUNT];
	fibs[0]=0;
	fibs[1]=1;
	int i = 2;
	while(i<=COUNT){
		fibs[i] = fibs[i - 1] + fibs[i - 2];
		i++;
	}
	for(int j = 0;j<COUNT;j++){
		nums[j] = fibs[j] * 1.0 / (fibs[j + 1] * 1.0);
	}
	
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style>

span{
	margin:50px 20px 20px 50px;
}
</style>

</head>
<body>
	<h1>
		<%
		out.print("Golden ratio from Fibonacci numbers");
		
		%>
	</h1>
<p>
<%
for(int k=0;k<COUNT;k++){
	out.print("<span>"+String.format("%05f",nums[k])+"</span>");
	if((k+1)%4==0){
		out.print("</br>");
	}
}
%>
</p>

</body>
</html>