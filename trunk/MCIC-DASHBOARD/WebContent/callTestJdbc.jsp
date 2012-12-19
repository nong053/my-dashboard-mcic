<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@page import="mcic.*" %>
<%@page import="java.sql.*"%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% 
	ConnectionDb jdbc = new ConnectionDb();
	jdbcdemo jdbcd = new jdbcdemo();
	 ResultSet rs;
	 rs=jdbc.selectData("select * from admin");
	 while(rs.next()){
		 out.print(rs.getString(1)+"<br>");
		 out.print(rs.getString(2)+"<br>");
		 out.print(rs.getString(3)+"<br>");
	 }
	%>
</body>
</html>