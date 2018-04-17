import java.sql.*;
import java.util.Scanner;

public class UpdateStu {
	static private Connection conn;
	static int sno = 1;

	public static void main(String args[]) {
		if (connect()) {
			System.out.println("输入格式：id 学号  姓名。输入exit或空行退出");
			Scanner in = new Scanner(System.in);
			System.out.printf("%d>", sno);
			String line = getLine();
			while (!line.equals("")) { // 是否还有输入
				String words[] = line.trim().split(" ");
				if (!formatError(words)) {
					updateItems(String.format("update stu set num='%s',name='%s' where id=%d;", words[1], words[2],
							Integer.parseInt(words[0])));
					sno++;
				} else {
					System.out.println("输入错误，必须且只能输入三个数据！");
				}
				System.out.printf("%d>", sno);
				line = getLine();
			}

		} else {
			System.out.println("Connect Error!");
		}
	}

	// 执行sql语句
	private static boolean exeUpdate(String sqlSentence) {
		Statement stat;
		try {
			stat = conn.createStatement(); // 根据连接获取一个执行sql语句的对象
			stat.executeUpdate(sqlSentence); // 执行sql语句,更新需要插入的元素
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return false;
		}
		return true;
	}

	private static void updateItems(String sqlSentence) {
		if (exeUpdate(sqlSentence)) {
			System.out.println("one record is updated");
		}
	}

	private static boolean formatError(String words[]) {
		if (words.length != 3) {
			return true;
		}
		return false;
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
