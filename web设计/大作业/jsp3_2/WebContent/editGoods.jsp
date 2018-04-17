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
public class QueryItem{
	private Connection conn;
	public String exception_msg;
	ResultSet exeQuery(String sqlSentence) {
		Statement stat;
		ResultSet rs = null;
		try {
			stat = conn.createStatement(); // 获取执行sql语句的对象
			rs = stat.executeQuery(sqlSentence); // 执行sql查询，返回结果集
		}catch (Exception e) {
			exception_msg=e.getMessage();
			return null;
		}
		return rs;
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
			return false;
		}
	}

}%>
<%
  String userName=request.getParameter("userName");
  String admin=request.getParameter("admin");
  String name_="输入商品名称",price_="输入现价",pre_price_="输入原价",tel_="联系方式",detail_="输入细节描述";
  String id=request.getParameter("id");
	if(id!=null){
	  String sql=String.format("select * from goods where id=\"%s\";",id);
	  QueryItem item=new QueryItem();
		if(item.connect()){
			ResultSet rs=item.exeQuery(sql);
			if(rs!=null){
				rs.next();
				name_=rs.getString("name");
				price_=rs.getString("price");
				pre_price_=rs.getString("pre_price");
				tel_=rs.getString("tel");
				detail_=rs.getString("detail");
			}else{
				out.print("<span>"+item.exception_msg+"</span><br><br>");
			}
						
		}else{
			out.print("<span>connot connect the database!</span><br><br>");
		}
  }

%>
<html>
<head>
<title>发布或者更新商品信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style>
body{
	MARGIN: 0px auto;
	background-image:url('image/back4.jpg');
	text-align:center;
}
.container {
}

a{
	color:grey;
	text-decoration:none;
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

#back{
	float:right;
	margin-right:350px;
}
a:hover{
	color:#1E90FF;
}
fieldset {
	width:600px;
	margin:20px auto;
	padding:20px 10px 20px 10px;
	background-color:#FCFCFF;
}

input[type="text"],input[type="file"]{
	width:400px;
	height:20px;
}
table{
	margin-left:70px;
}
#submit{
	width:50px;
}
#content{
	width:400px;
	height:100px;
}
#submit{
	width:50px;
	height:30px;
	text-family:幼圆;
	background-color:RGB(245,245,245);
}
legend{
	background-color:#6495ED;
	padding:5px 20px 5px 20px;
	margin-left:10px;
	box-shadow: -2px 2px 2px #808080;
}
</style>
</head>

<body>
<div class=container>
	<div id="top">
		<%String login=userName.equals("null")?"登录":"欢迎你,"+userName; %>
		<span id="login"><a href="register.jsp">注册</a>&nbsp;&nbsp;&nbsp;<a href="login.jsp"><%=login%></a></span>	
		<span id="back"><a href="browseGoods.jsp?userName=<%=userName%>&admin=<%=admin%>">返回首页</a> 
		&nbsp;&nbsp;<a href="myGoods.jsp?userName=<%=userName%>&admin=<%=admin%>">我的商品</a>
		</span>
	</div>
	<FORM ACTION="editGoodsResult.jsp?id=<%=id%>&userName=<%=userName%>&admin=<%=admin%>" method="POST" ENCTYPE="multipart/form-data">
	<fieldset>
	<legend>发布商品信息</legend>
	<P>文件：<INPUT TYPE=FILE NAME="file" SIZE=12></P>
	<P>名称：<INPUT TYPE=TEXT NAME="name" id="name" SIZE=30 value=<%=name_ %>></P>
	<P>价格：<INPUT TYPE=TEXT NAME="price"  id="price" SIZE=30 value=<%=price_ %>></P>
	<P>原价：<INPUT TYPE=TEXT NAME="pre_price" id="pre_price" SIZE=30 value=<%=pre_price_ %>></P>
	<P>联系：<INPUT TYPE=TEXT NAME="tel" id="tel" SIZE=30 value=<%=tel_ %> ></P>
	<table>
		<tr>
			<td valign="top">细节：</td>
			<td><textarea name="content" id="content" style="overflow-y:scroll" ><%=detail_ %></textarea></td>
		</tr>
	</table>
	<P><INPUT TYPE=SUBMIT id="submit" name="submit" VALUE="确定"></P>
	</fieldset>
	</FORM>
<script type="text/javascript">
   function inputClick(target){
     var value="";
     if(target.id=="name")
        value="输入商品名称";
     if(target.id=="price")
        value="输入现价";
     if(target.id=="pre_price")
        value="输入原价";
     if(target.id=="tel")
         value="联系方式";
     if(target.id=="content")
         value="输入细节描述";

     if(target.value==''){
       target.style.color="#B0B0B0";
       target.value=value;
     }
     else if(target.value==value){
        target.style.color="#000000";
        target.value="";
     }
   };
   var f1=function(){inputClick(this);};
   document.getElementById("name").onclick= f1;
   document.getElementById("price").onclick= f1;
   document.getElementById("pre_price").onclick= f1;
   document.getElementById("tel").onclick= f1;   
   document.getElementById("content").onclick= f1;
</script>
	
	
</div>	
</body>
</html>