<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="config.jsp"%>
<%
 ResultSet rs;
 rs = OracleConn.selectData("SELECT DISTINCT DEPARTMENT_CODE FROM BOM_DEPARTMENTS");
 JSONArray array_obj = new JSONArray();
 JSONArray array_obj_sub = new JSONArray();
 while(rs.next()){
	 array_obj_sub.add(rs.getString("DEPARTMENT_CODE"));
 }
 array_obj.add(array_obj_sub);
 out.print(array_obj);
 conn.close();
%>