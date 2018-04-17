// UpdateItems.java
import java.sql.*;

public class UpdateItems {
	static private Connection conn;
	static int cnt = 0;

	public static void main(String args[]) {
		if (connect()) {
			updateItems(String.format("update ItemA set type ='%s' where id=%d;","x",3));
		} else {
			System.out.println("Connect Error!");
		}
	}

	// 建立连接
	private static boolean connect() {
		String connectString = "jdbc:mysql://localhost:3306/test"
				+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connectString, "root", "123456");
			return true;
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return false;
	}

	// 执行SQL修改语句, 返回结果集
	private static boolean executeUpdate(String sqlSentence) {
		Statement stat;

		try {
			stat = conn.createStatement(); // 根据连接获取一个执行sql语句的对象
			cnt = stat.executeUpdate(sqlSentence); // 执行sql语句,返回所影响行记录的个数
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return (cnt >= 0);
	}

	// 进行修改
	private static void updateItems(String sqlSentence) {
		if (executeUpdate(sqlSentence)) {
			System.out.println("" + cnt + " records are updated.");
		}
	}

}
