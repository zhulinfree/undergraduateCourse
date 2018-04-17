import java.io.*;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

class ShowTags{
  public static void main(String[] args)throws IOException{
     String content = readFile("E:\\Desktop\\code\\vacation.htm");
     Map<String,Integer> m = new HashMap<String,Integer>();
     
     for(int i = 0;i < content.length()-1;i++)
     {
    	 char tmp1=content.charAt(i);
    	 char tmp2=content.charAt(i+1);
    	 if(tmp1== '<' && tmp2!= '/' && tmp2!='!'&&tmp2!=' '&& tmp2!='\\'&& content.charAt(i+1) != '"')
    	 {
    		 int begin = content.indexOf(" ",i+1);
    		 int end = content.indexOf(">",i +1);
    		 int pos = begin;
    		 if(pos > end)   pos = end;
    		 if(pos - (i+1) > 10) continue;
             String sub = content.substring(i+1,pos);
             
    		 Iterator<Map.Entry<String,Integer>> entries = m.entrySet().iterator();
             int value = 0;
             while(entries.hasNext())
             {
            	 Map.Entry<String, Integer> entry = entries.next();
            	 if(entry.getKey()==sub)
            	 {
            		 value = entry.getValue();
            		 break;
            	 }
            	
             }
             m.put(sub, value+1);
    		 
    	 }
     }
     Iterator<Map.Entry<String,Integer>> entries1 = m.entrySet().iterator();
     while(entries1.hasNext())
     {
    	 Map.Entry<String, Integer> entry = entries1.next();
    	 String tmp=entry.getKey().toString();
    	 if(!(tmp.equals("scr'") || tmp.equals("br/")||
    			tmp.equals("noscript")||tmp.equals("scr'+'ipt"))){
    		 System.out.println(entry.getKey());
    	 }
    	 
     }
     
     
     
  }
  static String readFile(String fileName) throws IOException{
    	StringBuilder sb = new StringBuilder("");
	int c1;
	FileInputStream f1= new FileInputStream(fileName);		
	InputStreamReader in = new InputStreamReader(f1, "UTF-8");

	while ((c1 = in.read()) != -1) {
	  sb.append((char) c1);
	}        
        return sb.toString();
  }
}


