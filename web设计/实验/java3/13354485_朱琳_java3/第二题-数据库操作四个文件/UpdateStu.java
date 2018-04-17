import java.sql.*;
import java.util.Scanner;

public class UpdateStu {
	static private Connection conn;
	static int sno = 1;

	public static void main(String args[]) {
		if (connect()) {
			System.out.println("�����ʽ��id ѧ��  ����������exit������˳�");
			Scanner in = new Scanner(System.in);
			System.out.printf("%d>", sno);
			String line = getLine();
			while (!line.equals("")) { // �Ƿ�������
				String words[] = line.trim().split(" ");
				if (!formatError(words)) {
					updateItems(String.format("update stu set num='%s',name='%s' where id=%d;", words[1], words[2],
							Integer.parseInt(words[0])));
					sno++;
				} else {
					System.out.println("������󣬱�����ֻ�������������ݣ�");
				}
				System.out.printf("%d>", sno);
				line = getLine();
			}

		} else {
			System.out.println("Connect Error!");
		}
	}

	// ִ��sql���
	private static boolean exeUpdate(String sqlSentence) {
		Statement stat;
		try {
			stat = conn.createStatement(); // �������ӻ�ȡһ��ִ��sql���Ķ���
			stat.executeUpdate(sqlSentence); // ִ��sql���,������Ҫ�����Ԫ��
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
