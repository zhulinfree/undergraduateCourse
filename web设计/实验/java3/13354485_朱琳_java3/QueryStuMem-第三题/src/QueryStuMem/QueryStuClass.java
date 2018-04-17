package QueryStuMem;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.*;

class QueryStuClass {
	static public Connection conn;
	public static ArrayList<Student> stud = new ArrayList<Student>();
	public static HashMap<String, Student> map=new HashMap<String,Student>();

	// ִ��SQL��ѯ���, ���ؽ����
	static public ResultSet exeQuery() {
		String sqlSentence = "select * from stu;";
		Statement stat;
		ResultSet rs = null;
		try {
			stat = conn.createStatement(); // ��ȡִ��sql���Ķ���
			rs = stat.executeQuery(sqlSentence); // ִ��sql��ѯ�����ؽ����
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return rs;
	}

	 static public void storeItems() {//�洢��ѯ���
		ResultSet rs = exeQuery();
		try {
			while (rs.next()) {
				int id=rs.getInt("id");
				String num=rs.getString("num");
				String name=rs.getString("name");
				Student stu=new Student(id,num,name);
				stud.add(stu);
				map.put(num,stu);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}

	public void showAllStudents() {
		Iterator<Student> it=stud.iterator();
		while(it.hasNext()){
			Student array_stu=it.next();
			int _id=array_stu.getId();
			String _num=array_stu.getNum();
			String _name=array_stu.getName();	
			
			System.out.println(_id+" "+_num+" "+_name);
		}
		System.out.println("\n");
		

	}

	public void showStudent(String s) {
		if(map.get(s)==null){
			System.out.println("��ѧ�������ڣ�\n");
		}else{
			Student map_stu=map.get(s);
			int _id=map_stu.getId();
			String _num=map_stu.getNum();
			String _name=map_stu.getName();	
			System.out.println(_id+" "+_num+" "+_name+"\n");
		}
	}

	// ��������
	public boolean fetchStu(String connectString, String user, String pass) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connectString, user, pass);
			storeItems();
			return true;
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return false;
	}

}