import java.io.*;

class StringAppend{
  public static void main(String[] args)throws IOException{
     
    long time1=System.currentTimeMillis();
    String content = readFile("vacation.htm");
    long time2= System.currentTimeMillis();
    long diff=time2-time1;
    System.out.println("The time is "+diff+" ms");
  }

  static String readFile(String fileName) throws IOException{
    	//StringBuilder sb = new StringBuilder("");
      String sb="";
	    int c1;
	    FileInputStream f1= new FileInputStream(fileName);		
	    InputStreamReader in = new InputStreamReader(f1, "UTF-8");
	     while ((c1 = in.read()) != -1) {
	        //sb.append((char) c1);
          sb=sb+(char)c1;
	     }        
       
       // return sb.toString();
       return sb;
  }
}


 