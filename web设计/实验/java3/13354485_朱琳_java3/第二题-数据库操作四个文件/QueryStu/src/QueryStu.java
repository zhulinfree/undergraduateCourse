import java.sql.*;
import java.util.Scanner;

public class QueryStu {
	static private Connection conn;
	static int sno = 1;

	public static void main(String args[]) {
		if (connect()) {
			System.out.println("ÿ�����벿��Ҫ��ѯ�����ݣ�����*��������м�¼������exit������˳�");
			Scanner in = new Scanner(System.in);
			
			String line = getLine();
			while (!line.equals("")) { // �Ƿ�������
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

	// ִ��SQL��ѯ���, ���ؽ����
	static private ResultSet exeQuery(String sqlSentence) {
		Statement stat;
		ResultSet rs = null;

		try {
			stat = conn.createStatement(); // ��ȡִ��sql���Ķ���
			rs = stat.executeQuery(sqlSentence); // ִ��sql��ѯ�����ؽ����
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return rs;
	}

	// ��ʾ��ѯ���
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

	// ��������
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
		if (in.hasNextLine()) { // �Ƿ�������
			String line = in.nextLine(); // ��ȡ��һ��
			if (line.equals("exit") || line.trim().length() == 0) {
				return "";
			}
			return line;
		}
		return "";
	}
}