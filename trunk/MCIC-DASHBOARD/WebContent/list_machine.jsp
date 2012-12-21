<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="config.jsp"%>
<%

String paramPlant = request.getParameter("paramPlant");
String paramFromDate = request.getParameter("paramFromDate");
String paramToDate = request.getParameter("paramToDate");
String paramDepartment = request.getParameter("paramDepartment");
String paramJobNumber = request.getParameter("paramJobNumber");


ResultSet rs;
JSONArray array_obj = new JSONArray();

String query="";


query+="select DISTINCT WDR.RESOURCE_CODE, WDR.RESOURCE_DESCRIPTION";
query+=" from WIP_DEPT_RESOURCES_V WDR ";
query+=" WHERE  WDR.RESOURCE_TYPE = 'Machine'";


rs = OracleConn.selectData(query);

	
		while(rs.next()){
			JSONArray array_obj_sub = new JSONArray();
			
			array_obj_sub.add(rs.getString(1));
			array_obj_sub.add(rs.getString(2));
		

			
			array_obj.add(array_obj_sub);
			
		}
		out.print(array_obj);
		conn.close();
	
%>
