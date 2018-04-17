import java.util.*;

public class InputData {
	static int sno = 1;

	public static void main(String args[]) {
		Scanner in = new Scanner(System.in);
		System.out.println("�������룬exit�˳�.\r\n");
		String line = getLine();
		while (!line.equals("")) { // �Ƿ�������
			System.out.println("    "+line);
			sno++;
			line = getLine();
		}
	}

	private static String getLine() {
		Scanner in = new Scanner(System.in);
		System.out.print(String.format("��%d��>",sno));
		if (in.hasNextLine()) { // �Ƿ�������
			String line = in.nextLine(); // ��ȡ��һ��
			if (line.equals("exit") || line.trim().length() == 0) {
				return "";
			}
			String words[] = line.trim().split(" ");
			return Arrays.toString(words);
        	}
		return "";
	}
}