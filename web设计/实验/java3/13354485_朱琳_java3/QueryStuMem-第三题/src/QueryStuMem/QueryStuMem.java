package QueryStuMem;
import java.util.Scanner;

public class QueryStuMem {

	static int sno = 1;
	public static void main(String args[]) {
		String connectString = "jdbc:mysql://202.116.76.22:3306/test"
				+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
		String user = "user";
		String pass = "123456";
		QueryStuClass students = new QueryStuClass();

		if (students.fetchStu(connectString, user, pass)) {
			System.out.println("每次输入要查询的学号或*, 输入exit或空行退出");

			// ResultSet resultSet = students.exeQuery();
			// students.storeItems();
			String line = getLine();

			while (!line.equals("")) { // 是否还有输入
				String words[] = line.trim().split(" ");
				if (!formatError(words)) {
					if (words[0].equals("*"))
						students.showAllStudents();
					else
						students.showStudent(words[0]);
					sno++;
				}

				line = getLine();
			}
		} else {
			System.out.println("Connect Error!");
		}
	}

	private static boolean formatError(String words[]) {
		if (words.length != 1) {
			return true;
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
