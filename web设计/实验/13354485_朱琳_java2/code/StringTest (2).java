import java.io.*;
import java.util.Arrays;
public class StringTest {
	private static char []S=new char[50000];
	private static Map []map=new Map[3000];//MapΪ�Զ����࣬��ĩβ
	final static int COUNT=20;
	
	public static void main(String[] args)throws IOException{
     String content = readFile("E:\\Desktop\\code\\poem.txt");
     int num=0;
     String content2="";
     for(;num<content.length();num++){
    	 S[num]=content.charAt(num);
     }
     Arrays.sort(S,0,num);//���ַ��������򣬿��Խ���ͬ�ĺ��ּ��ϵ�ͬһ����
     for(int i=0;i<num;i++){//���ַ����黯���ַ������ҽ�����Ķ���ɾ��
    	 if(S[i]!=','&&S[i]!='��'&&S[i]!='��'&&S[i]!='.'&&S[i]!='��'&&(!(S[i]>='0'&&S[i]<='9'))&&S[i]!=' '){
    		 content2+=S[i];
    	 }
     }   
     content2=content2.trim();//ɾ��ǰ��ո�
     
     int i=0,n=0;
     while(i<content2.length()){
    	 char tmp=content2.charAt(i);
    	 int begin=content2.indexOf(tmp,i);
    	 int end=content2.lastIndexOf(tmp);
    	 i=end+1;
    	 int no=end-begin+1;
    	 map[n++]=new Map(tmp,no);
     }
     for(int j=0;j<COUNT;j++){//��ѯ20�Σ�ÿ�β��ҵ���ǰ���ֵ
    	 int max=0,pos=0;
    	 for(int k=0;k<n;k++){
    		 if(map[k].number>max){
    			 max=map[k].number;
    			 pos=k;
    		 }
    	 }
    	 System.out.println((j+1)+"."+map[pos].str+":"+map[pos].number);
    	 //���õ������ֵ���㣬���ٲ������ֱȽ�
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
