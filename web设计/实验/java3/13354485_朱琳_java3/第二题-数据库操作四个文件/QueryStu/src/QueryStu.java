import java.sql.*;
import java.util.Scanner;

public class QueryStu {
	static private Connection conn;
	static int sno = 1;

	public static void main(String args[]) {
		if (connect()) {
			System.out.println("每次输入部分要查询的内容，输入*将查出所有记录。输入exit或空行退出");
			Scanner in = new Scanner(System.in);
			
			String line = getLine();
			while (!line.equals("")) { // 是否还有输入
				ResultSet rs;
				if (line.equals("*")) {
					rs = exeQuery("select * from stu;");
				} else {
					rs = exeQuery(String.format(
							"SELECT * FROM stu WHERE num LIKE '%%%s%%' OR name LIKE'%%%s%%' ORDER BY num;", line, line));
				}
				showItems(rs);
				sno++;
				line = getLine();
			}

		} else {
			System.out.println("Connect Error!");
		}
	}

	// 执行SQL查询语句, 返回结果集
	static private ResultSet exeQuery(String sqlSentence) {
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

	// 显示查询结果
	private static void showItems(ResultSet rs) {
		try {
			while (rs.next()) {
				System.out.printf(rs.getInt("id") + " ");
				System.out.printf(rs.getString("num") + " ");
				System.out.println(rs.getString("name"));

			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}

	// 建立连接
	private static boolean connect() {
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

	private static String getLine() {
		System.out.printf("%d>", sno);
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
}