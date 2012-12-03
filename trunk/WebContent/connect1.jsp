<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.*"%>
<%
String conn="";
String query="";
Statement st;
ResultSet rs;

Class.forName("java path").newInstance();
conn=DiverManagement.getConnection("host,user,pass");
st=conn.createStatement();
query="query";
rs=st.executeQuery(query);
while(rs.next()){
rs.getString("column or field");
}
%>