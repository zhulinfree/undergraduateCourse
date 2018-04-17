<%@page import="sun.nio.ch.SelChImpl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.util.*,java.util.Scanner,java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.commons.io.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%!
public class InsertItem{
	private Connection conn;
	public String exception_msg;
	//执行sql语句
	boolean executeInsert(String sqlSentence) {
		Statement stat;
		try {
			stat = conn.createStatement(); // 根据连接获取一个执行sql语句的对象
			stat.executeUpdate(sqlSentence); // 执行sql语句,插入需要插入的元素
		} catch (Exception e) {
			exception_msg=e.getMessage();
			return false;
		}
		return true;
	}

	// 建立连接
	boolean connect() {
		String connectString = "jdbc:mysql://localhost:3306/db13354453"
				+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connectString, "user", "123456");
			return true;
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return false;
		}	
	}
}
%>

<html>
<head>
<title>发布或者更新商品结果</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style>
body{
	MARGIN: 0px auto;
	background-image:url('image/back4.jpg');

}
.container {
	margin-top:40px;
}

a{
	color:grey;
	text-decoration:none;
}

a:hover{
	color:#1E90FF;
}

span{
	text-align:center;
}
#top{
	padding-top:10px;	
	height:30px;
	width:100%;	
	background-color:RGB(245,245,245);
	box-shadow: -2px 2px 2px #808080;
}
#login{	
	padding-left:300px;	
}
#back{
	float:right;
	margin-right:200px;
}

fieldset {
	width:500px;
	margin:20px auto;
	padding:20px 10px 20px 10px;
	background-color:#FCFCFF;
	text-align:center
}
legend{
	background-color:#6495ED;
	padding:5px 20px 5px 20px;
	margin-left:10px;
	box-shadow: -2px 2px 2px #808080;
}

#insert{	
	font-family:幼圆;
	font-weight:600;
	font-size:1.5em;
	color:brown;
}

</style>
</head>

<body>
<%String userName=request.getParameter("userName");
 	 String admin=request.getParameter("admin");
	%>	
<div id="top">
		<%String login=userName.equals("null")?"登录":"欢迎你,"+userName; %>
		<span id="login"><a href="register.jsp">注册</a>&nbsp;&nbsp;&nbsp;<a href="login.jsp"><%=login%></a></span>	
		<span id="back"><a href="browseGoods.jsp?userName=<%=userName%>&admin=<%=admin%>">首页</a>
		&nbsp;&nbsp;&nbsp;
		<a href="editGoods.jsp?userName=<%=userName%>&admin=<%=admin%>">发布商品</a>
		&nbsp;&nbsp;<a href="myGoods.jsp?userName=<%=userName%>&admin=<%=admin%>">我的商品</a></span>
	</div>
<div class=container>
	
<fieldset>
<legend>发布商品信息结果</legend>	
<%
	String img="",name="",price="",pre_price="",tel="",detail="";	
	boolean isMultipart= ServletFileUpload.isMultipartContent(request);//检查表单中是否包含文件	
	if(isMultipart){		
		FileItemFactory factory = new DiskFileItemFactory();	
		ServletFileUpload upload = new ServletFileUpload(factory);		
		List items = upload.parseRequest(request);		
		for(int i=0;i<items.size();i++){
			FileItem fi = (FileItem)items.get(i);
			if(fi.isFormField()){//如果是表单字段	
				out.print(fi.getFieldName()+":"+fi.getString("UTF-8")+"<br><br>");
				String column=fi.getFieldName();				
				switch(column){
					case "name":name=fi.getString("UTF-8");
						break;
					case "price":price=fi.getString("UTF-8");
						break;
					case "pre_price":pre_price=fi.getString("UTF-8");
						break;
					case "tel":tel=fi.getString("UTF-8");
						break;
					case "content":detail=fi.getString("UTF-8");
						break;
					default:
						break;
				}
			}else{//如果是文件
				DiskFileItem dfi = (DiskFileItem)fi;
					if(!dfi.getName().trim().equals("")){
					//getName()返回文件名称，如果是空字符串，说明没有选择文件。 // FilenameUtils.getName(filename);
					String img2=new File(application.getRealPath("/")
							+System.getProperty("file.separator") + "/images/"+FilenameUtils.getName(dfi.getName())).getAbsolutePath();					
					dfi.write(new File(application.getRealPath("/") + System.getProperty("file.separator")+"/images/"+FilenameUtils.getName(dfi.getName())));
					img="images/"+dfi.getName();					
				}
			}
		}
	}	
	
	InsertItem item=new InsertItem();
	if(item.connect()){	
		String id=request.getParameter("id");
		String msg="插入成功！";
		String sql=new String();
		if(!id.equals("null")){
			sql=String.format("update goods set img_url=\"%s\",userName=\"%s\",name=\"%s\",detail=\"%s\",price=\"%s\",pre_price=\"%s\",tel=\"%s\" where id=\"%s\";",img,userName,name,detail,price,pre_price,tel,id);
			msg="更新成功！";
		}else{
			sql=String.format("insert into goods(img_url,userName,name,detail,price,pre_price,tel) values('%s','%s','%s','%s','%s','%s','%s');",img,userName,name,detail,price,pre_price,tel);
		}
		
		if(item.executeInsert(sql)){			
			out.print("<br><br><br><span id=\"insert\">"+msg+"</span><br><br>");
		}else{						
			out.print("<span>"+item.exception_msg+"</span><br><br>");
		}			
	}else{
		out.print("<span>connot connect the database!</span><br><br>");
	}
%>

<div id="backHome">
	<span><a href="browseGoods.jsp?userName=<%=userName%>&admin=<%=admin%>" style="background-color:#1E90FF;color:black;padding:10px">返回首页</a></span>
	&nbsp;&nbsp;&nbsp;
	<span><a href="editGoods.jsp?userName=<%=userName%>&admin=<%=admin%>" style="background-color:#A9A9A9;color:black;padding:10px">发布界面</a></span>
</div>
</fieldset>

</div>
	
</body>
</html>