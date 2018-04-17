<%@page import="javax.management.Query"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

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
	ResultSet rs=null;
	final int pageSize=8;//每页显示的记录的数量
	int rowCount=0;//总的记录数量
	int currentPage=1;//当前页数
	int pageCount=0;//总页数
	int idIndex;
	boolean notFoundFlag=false;
	String strPage,sqlSentence="select * from goods;",userName=request.getParameter("userName");
	String admin=request.getParameter("admin");
	String searchButton=request.getParameter("searchButton");
	strPage=request.getParameter("page");
	if(strPage==null){
		currentPage=1;
	}else{
		currentPage=Integer.parseInt(strPage);
		if(currentPage<1){
			currentPage=1;
		}
	}
%>
<%
	if(searchButton!=null){
		sqlSentence=String.format("select * from goods where name like \"%%%s%%\";",request.getParameter("search"));
	}else{
		sqlSentence="select * from goods;";
	}

	QueryItem item=new QueryItem();
	if(item.connect()){
		rs=item.exeQuery(sqlSentence);
		if(rs!=null){
			rs.last();
			rowCount = rs.getRow();//计算 当前的记录的总数量
			pageCount = (rowCount-1) / pageSize+1;//计算需要的总的页数
			if(rowCount==0) pageCount=0;
			if (currentPage > pageCount) {
				currentPage = pageCount;
			}	
		}else{
			out.print("<span>"+item.exception_msg+"</span><br><br>");
		}
					
	}else{
		out.print("<span>connot connect the database!</span><br><br>");
	}
%>

<html>
<head>

<meta http-equiv="Content-Type" content="text/html;  charset=utf-8">
<title>首页</title>
<style>
body{
	MARGIN: 0px auto;
	back-ground:RGB(252,251,251);
}
.container {
	
}

A{
	text-decoration:none;
	COLOR: grey;
}
a:hover{
	color:#1E90FF;
}

th,td{
	text-align:center;
	width:200px;
}
#outter_table{
	margin:0px auto;	
	margin-top:5px;
	
}
#inner_table{
	border:solid 1px grey;
	margin-right:20px;
	margin-top:20px;
	width:200px;
	box-shadow: -2px 2px 2px #808080;
}

#price{
	font-size:20px;
	font-weight:900;
	font-family:"微软雅黑";
	color:red;	
	padding-top:5px;
	text-align:left;
}
#pre_price{
	font-size:12px;
	font-weight:600;
	font-family:"微软雅黑";
	color:grey;	
	padding-top:5px;
	text-decoration:line-through;
	text-align:left;
}

#name{
	white-space:pre-wrap;
}
#detail{
	font-size:12px;
	padding-top:5px;
	text-align:right;
}

img{
	width:200px;
	height:180px;
}
#logoIMG{
	float:left;
	width:120px;
	height:40px;
	margin-top:0px;
	margin-left:170px;
}
#top{
	padding-top:10px;	
	height:30px;
	width:100%;	
	background-color:RGB(245,245,245);
	box-shadow: -2px 2px 2px #808080;
}
#login{	
	padding-left:30px;	
}
form{
	margin-left:0px;
	margin-top:10px;
}

#search{
	 width:400px;
	 height:30px;
	 border: 1px solid black; 
	 color:grey;
	 margin-left:380px;
	 border-radius: 7px;
	 box-shadow: -1px 1px 4px #808080;
}
#searchButton{
	width:50px;
	height:30px;
	text-family:幼圆;
	background-color:RGB(245,245,245);
}
#home{
	float:right;
	margin-right:200px;
}
#page{
	background-color:#C0C0C0;
	color:black;
	padding:5px;
}
#page:hover{
	color:#1E90FF;
}
#notFoundMsg{
	font-family:幼圆;
	font-weight:600;
	font-size:1.5em;
	padding-left:300px;
	color:brown;
}
#backHome{
	padding-left:480px;

}
</style>
</head>

<%@ page import="java.util.*,java.util.Scanner,java.sql.*"%>
<body>
<div class="container" style="clear:both">
	<img src="image/logo.jpg" id="logoIMG"/>
	<div id="top">
		<%String login=userName.equals("null")?"登录":"欢迎你,"+userName; %>
		<span id="login"><a href="register.jsp">注册</a>&nbsp;&nbsp;&nbsp;<a href="login.jsp"><%=login%></a></span>
		<span id="home"><a href="browseGoods.jsp?userName=<%=userName%>&admin=<%=admin%>">首页</a>
		<%if(!userName.equals("null")){ %>
			&nbsp;&nbsp;&nbsp;<a href="editGoods.jsp?userName=<%=userName%>&admin=<%=admin%>">发布商品</a> 
			&nbsp;&nbsp;<a href="myGoods.jsp?userName=<%=userName%>&admin=<%=admin%>">我的商品</a>
		<%} %>
		</span>
	</div>
	
	<form action="browseGoods.jsp?userName=<%=userName%>&admin=<%=admin%>" method="POST">
			<input type=TEXT name="search" id="search" value="输入需要搜索的商品">
			<input name="searchButton" type="submit" value="搜索" id="searchButton">&nbsp;&nbsp;
	</form>
	
	<table id="outter_table" cellspacing="0">
		<%
		if (pageCount> 0) {			
			rs.absolute((currentPage - 1) * pageSize + 1);
			int i = 0;
			int flag=0;
			while (i < pageSize && !rs.isAfterLast()) {
				idIndex= rs.getInt("id");
		if(i%4==0){%><tr><%}
		%>
		<td>
		<table cellspacing="0"  id="inner_table">		
		<tr><td colspan="2"><img src=<%=rs.getString("img_url")%>></td></tr>
		<tr><td id="price">￥<%=rs.getString("price")%>    <span id="pre_price">￥<%=rs.getString("pre_price")%></span></td></tr>
		<tr><td id="name"><%=rs.getString("name")%></td></tr>	
		<tr><td id="detail" colspan="2"><a href="GoodsDetail.jsp?userName=<%=userName%>&admin=<%=admin%>&id=<%=idIndex%>" >查看更多>></a></td></tr>
		<%if(admin.equals("yes")){ %>
			<tr><td style="background-color:#FF0066"><a href="deleteGoods.jsp?userName=<%=userName%>&admin=<%=admin%>&id=<%=idIndex%>" style="color:#696969">删除</a></td></tr>
		<%} %>
		</table>
		</td>
		<%
			rs.next();
			i++;
			}
		}else{
			notFoundFlag=true;
		}%>	
	</table>
	
<br><br><br>
<%if(notFoundFlag){ %>
	<p id="notFoundMsg">未找到符合该条件的商品信息，快来发布第一个商品吧~</p>
	<br><br><br>
	<div id="backHome">
		<span><a href="browseGoods.jsp?userName=<%=userName%>&admin=<%=admin%>" style="background-color:#1E90FF;color:black;padding:10px">返回首页</a></span>
		&nbsp;&nbsp;&nbsp;
		<span><a href="editGoods.jsp?userName=<%=userName%>&admin=<%=admin%>" style="background-color:#A9A9A9;color:black;padding:10px">发布界面</a></span>
	</div>	
<%} %>
				
<div style="float: right;margin-top:10px;margin-right:200px">
	<%if(currentPage>1){ %>
		<a href="browseGoods.jsp?userName=<%=userName%>&admin=<%=admin%>&page=<%=currentPage - 1%>" id="page">上一页</a> 
	<%} %>
	&nbsp; 
	<%if(currentPage < pageCount){ %>
		<a href="browseGoods.jsp?userName=<%=userName%>&admin=<%=admin%>&page=<%=currentPage + 1%>" id="page">下一页</a> 
	<%} %>
</div>

<%if (pageCount> 0) { %>
	<div style="clear:both;text-align:center">
		共有<%=rowCount %>条记录 &nbsp;&nbsp;&nbsp;第<%=currentPage %>页  共<%=pageCount %>页
	</div>
<%} %>
</div>
<script type="text/javascript">
   function inputClick(target){
     if(target.value==''){
       target.style.color="#B0B0B0";
       target.value=value;
     }
     else if(target.value=="输入需要搜索的商品"){
        target.style.color="#000000";
        target.value="";
     }
   };
   var f1=function(){inputClick(this);};
   document.getElementById("search").onclick= f1;
</script>
</body>
</html>