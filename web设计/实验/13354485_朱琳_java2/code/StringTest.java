import java.io.*;

public class StringTest {

	private static int len0 = 0, len1 = 0, len2 = 0, len3 = 0;

	public static void main(String[] args)throws IOException{
     String content = readFile("E:\\Desktop\\code\\poem.txt");
     for(int i=0;i<content.length();i++){
    	 switch(content.charAt(i)){
    	 case '春':
    		 len0++;
    		 break;
    	 case '天':
    		 len1++;
    		 break; 
    	 case '水':
        	len2++;
        	break; 
        case '花':
            len3++;
            break;
    	 }
     }
     System.out.println("春: "+len0);
     System.out.println("天: "+len1);
     System.out.println("水: "+len2);
     System.out.println("花: "+len3);
     
     
  }

	static String readFile(String fileName) throws IOException {
		StringBuilder sb = new StringBuilder("");
		int c1;
		FileInputStream f1 = new FileInputStream(fileName);
		InputStreamReader in = new InputStreamReader(f1, "UTF-8");

		while ((c1 = in.read()) != -1) {
			sb.append((char) c1);
		}
		in.close();
		return sb.toString();
	}
}
