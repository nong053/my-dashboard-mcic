<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="config.jsp"%>
<%
 ResultSet rs;
String query="";
query+="select distinct WOV.OPERATION_CODE from WIP_OPERATIONS_V WOV";
query+=" where  (WOV.OPERATION_CODE in ('PRMX','M5N7','APKX') OR WOV.OPERATION_CODE like 'F%')";
 rs = OracleConn.selectData(query);
 JSONArray array_obj = new JSONArray();
 JSONArray array_obj_sub = new JSONArray();
 while(rs.next()){
	 array_obj_sub.add(rs.getString("OPERATION_CODE"));
 }
 array_obj.add(array_obj_sub);
 out.print(array_obj);
 conn.close();
%>