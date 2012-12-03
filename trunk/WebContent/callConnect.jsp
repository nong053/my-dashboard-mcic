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
		<% //dbAccessBean conn1 =  new dbAccessBean();
		//out.print(conn1.sayHi("Kosit Aromsava"));
		//out.print(conn1.executeSQL());
			
			jdbcdemo jdbcd = new jdbcdemo();
			jdbcd.setDbUrl("jdbc:mysql://localhost:3306/prototype_db");
			out.print(jdbcd.getDbUrl());
			ResultSet rs= jdbcd.selectData("select * from admin");
			while(rs.next()){
				out.print(rs.getString(2)+"<br>");
			}
		%>
</body>
</html>