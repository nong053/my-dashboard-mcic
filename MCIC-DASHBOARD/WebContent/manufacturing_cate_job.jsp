<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="config.jsp"%>
<%

String param_machine = request.getParameter("param_machine");
//String param_machine = "M2HM-02000";



ResultSet rs;
JSONArray array_obj = new JSONArray();

String query="";


query+="select DISTINCT WDR.RESOURCE_CODE, WDR.RESOURCE_DESCRIPTION from WIP_DEPT_RESOURCES_V WDR";
query+=" WHERE  WDR.RESOURCE_TYPE = 'Machine'";
query+=" AND RESOURCE_CODE LIKE '%"+param_machine+"%'";
query+=" AND ROWNUM <15";


/*AND ROWNUM <5*/


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
