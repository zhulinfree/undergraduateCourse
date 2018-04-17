import java.util.*;

public class InputData {
	static int sno = 1;

	public static void main(String args[]) {
		Scanner in = new Scanner(System.in);
		System.out.println("按行输入，exit退出.\r\n");
		String line = getLine();
		while (!line.equals("")) { // 是否还有输入
			System.out.println("    "+line);
			sno++;
			line = getLine();
		}
	}

	private static String getLine() {
		Scanner in = new Scanner(System.in);
		System.out.print(String.format("第%d行>",sno));
		if (in.hasNextLine()) { // 是否还有输入
			String line = in.nextLine(); // 读取下一行
			if (line.equals("exit") || line.trim().length() == 0) {
				return "";
			}
			String words[] = line.trim().split(" ");
			return Arrays.toString(words);
        	}
		return "";
	}
}