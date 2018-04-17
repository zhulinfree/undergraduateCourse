<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.util.*,java.util.Scanner,java.sql.*"%>

<%!class Student {
		private int id;
		private String num;
		private String name;

		int getId() {
			return this.id;
		}
		String getNum() {
			return this.num;
		}
		String getName() {
			return this.name;
		}
		Student(int id, String num, String name) {
			this.id = id;
			this.num = num;
			this.name = name;
		}
	}%>
<%!class QueryStuClass {
		public Connection conn;
		public ArrayList<Student> stud = new ArrayList<Student>();

		// 执行SQL查询语句, 返回结果集
		public ResultSet exeQuery() {
			String sqlSentence = "select * from stu;";
			Statement stat;
			ResultSet rs = null;
			try {
				stat = conn.createStatement(); // 获取执行sql语句的对象
				rs = stat.executeQuery(sqlSentence); // 执行sql查询，返回结果集
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
			return rs;
		}

		public void storeItems() {//存储查询结果
			ResultSet rs = exeQuery();
			try {
				while (rs.next()) {
					int id = rs.getInt("id");
					String num = rs.getString("num");
					String name = rs.getString("name");
					Student stu = new Student(id, num, name);
					stud.add(stu);
				}
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		// 建立连接
		public boolean fetchStu(String connectString, String user, String pass) {
			try {
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection(connectString, user, pass);
				storeItems();
				return true;
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
			return false;
		}

	}%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style>
body {
	text-align: center
}
table {
	margin: 0 auto;
	border-right: 1px solid black;
	border-bottom: 1px solid black;
}

th, td {
	border-left: 1px solid black;
	border-top: 1px solid black
}
</style>

</head>
<body>
	<h1>Query Students</h1>
	<table border="0" cellspacing="0" cellpadding="0">
		<tr>
			<th>id</th><th>num</th><th>name</th>
		</tr>
		<%String connectString = "jdbc:mysql://202.116.76.22:3306/test"
					+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
			String user = "user";
			String pass = "123456";
			QueryStuClass students = new QueryStuClass();
			if (students.fetchStu(connectString, user, pass)) {
				Iterator<Student> it = students.stud.iterator();
				while (it.hasNext()) {
					Student array_stu = it.next();
					int _id = array_stu.getId();
					String _num = array_stu.getNum();
					String _name = array_stu.getName();		
					out.print("<tr>");
					out.print("<td>"+_id + "</td>");
					out.print("<td>"+_num+ "</td>");
					out.print("<td>"+_name+"</td>");
					out.print("</tr>");
				}
			}
		%>
	</table>
</body>
</html>