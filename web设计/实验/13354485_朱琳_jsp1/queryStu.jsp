<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.util.*,java.util.Scanner,java.sql.*"%>
<%!
public class QueryStu{
	private Connection conn;
	ResultSet exeQuery(String sqlSentence) {
		Statement stat;
		ResultSet rs = null;
		try {
			stat = conn.createStatement(); // 获取执行sql语句的对象
			rs = stat.executeQuery(sqlSentence); // 执行sql查询，返回结果集
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return rs;
	}

	// 建立连接
	boolean connect() {
		String connectString = "jdbc:mysql://202.116.76.22:3306/test"
				+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connectString, "user", "123456");
			return true;
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return false;
	}

	String getLine() {
		Scanner in = new Scanner(System.in);
		if (in.hasNextLine()) { // 是否还有输入
			String line = in.nextLine(); // 读取下一行
			if (line.equals("exit") || line.trim().length() == 0) {
				return "";
			}
			return line;
		}
		return "";
	}
}%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style>
	body{text-align:center}
	table{margin:0 auto}
	table{border-right:1px solid black;border-bottom:1px solid black}
	th,td{border-left:1px solid black;border-top:1px solid black}
</style>

</head>
<body>
	<h1>
		Query Students
	</h1>
	<table border="0" cellspacing="0" cellpadding="0">
		<tr>
			<th>id</th><th>num</th><th>name</th>
		</tr>
	
		<%
			QueryStu stu=new QueryStu();
			if(stu.connect()){
				ResultSet rs=stu.exeQuery("select * from stu;");
				try {
					while (rs.next()) {
						out.print("<tr>");
						out.print("<td>"+rs.getInt("id") + "</td>");
						out.print("<td>"+rs.getString("num") + "</td>");
						out.print("<td>"+rs.getString("name")+"</td>");
						out.print("</tr>");

					}
				} catch (Exception e) {
					out.println(e.getMessage());
				}				
			}else{
				out.print("Cannot connect the database!");
			}
		%>
	</table>

</body>
</html>