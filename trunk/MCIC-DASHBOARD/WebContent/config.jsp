<%@page import="java.sql.*"%>
<%@page import="mcic.*"%>
<%@ page language="java" import="net.sf.json.JSONArray" %>
<%
	ConnectionDb  OracleConn =new ConnectionDb();
    OracleConn.setDriver("oracle.jdbc.driver.OracleDriver");
    OracleConn.setUrl("jdbc:oracle:thin:@172.18.88.205:1525:prod");
    OracleConn.setUser("apps");
    OracleConn.setPass("apps");
    Connection conn;
    conn=OracleConn.testConnect();
    if(!conn.isClosed()){
    	//out.print("ok connect database is sucessfully");
    }

%>