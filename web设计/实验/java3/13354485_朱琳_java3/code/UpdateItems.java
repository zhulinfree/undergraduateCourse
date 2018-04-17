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

	// ��������
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

	// ִ��SQL�޸����, ���ؽ����
	private static boolean executeUpdate(String sqlSentence) {
		Statement stat;

		try {
			stat = conn.createStatement(); // �������ӻ�ȡһ��ִ��sql���Ķ���
			cnt = stat.executeUpdate(sqlSentence); // ִ��sql���,������Ӱ���м�¼�ĸ���
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return (cnt >= 0);
	}

	// �����޸�
	private static void updateItems(String sqlSentence) {
		if (executeUpdate(sqlSentence)) {
			System.out.println("" + cnt + " records are updated.");
		}
	}

}
