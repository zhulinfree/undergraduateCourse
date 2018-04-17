import java.io.*;
import java.util.Arrays;
public class StringTest {
	private static char []S=new char[50000];
	private static Map []map=new Map[3000];//Map为自定义类，在末尾
	final static int COUNT=20;
	
	public static void main(String[] args)throws IOException{
     String content = readFile("E:\\Desktop\\code\\poem.txt");
     int num=0;
     String content2="";
     for(;num<content.length();num++){
    	 S[num]=content.charAt(num);
     }
     Arrays.sort(S,0,num);//将字符数组排序，可以将相同的汉字集合到同一区域
     for(int i=0;i<num;i++){//将字符数组化成字符串并且将多余的东西删掉
    	 if(S[i]!=','&&S[i]!='，'&&S[i]!='？'&&S[i]!='.'&&S[i]!='。'&&(!(S[i]>='0'&&S[i]<='9'))&&S[i]!=' '){
    		 content2+=S[i];
    	 }
     }   
     content2=content2.trim();//删除前后空格
     
     int i=0,n=0;
     while(i<content2.length()){
    	 char tmp=content2.charAt(i);
    	 int begin=content2.indexOf(tmp,i);
    	 int end=content2.lastIndexOf(tmp);
    	 i=end+1;
    	 int no=end-begin+1;
    	 map[n++]=new Map(tmp,no);
     }
     for(int j=0;j<COUNT;j++){//查询20次，每次查找到当前最大值
    	 int max=0,pos=0;
    	 for(int k=0;k<n;k++){
    		 if(map[k].number>max){
    			 max=map[k].number;
    			 pos=k;
    		 }
    	 }
    	 System.out.println((j+1)+"."+map[pos].str+":"+map[pos].number);
    	 //将得到的最大值置零，不再参与下轮比较
    	 map[pos].number=0;
     }
};
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

class Map{
	public char str;
	public int number;
	Map(char ch,int n){
		str=ch;
		number=n;
	}
}
