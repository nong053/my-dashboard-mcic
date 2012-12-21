<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="config.jsp"%>
<%

String paramPlant = request.getParameter("paramPlant");
String paramFromDate = request.getParameter("paramFromDate");
String paramToDate = request.getParameter("paramToDate");
String paramDepartment = request.getParameter("paramDepartment");
String paramJobNumber = request.getParameter("paramJobNumber");
String machine_id = request.getParameter("machine_id");


ResultSet rs;
JSONArray array_obj = new JSONArray();

String query="";


query+="SELECT  min(WOV.FIRST_UNIT_START_DATE) ,max(WOV.LAST_UNIT_COMPLETION_DATE) ";

query+=" FROM WIP_ENTITIES WE";
query+=" INNER JOIN WIP_DISCRETE_JOBS_V WDJ";
query+=" ON WE.WIP_ENTITY_ID = WDJ.WIP_ENTITY_ID";
query+=" INNER JOIN WIP_OPERATIONS_V WOV";
query+=" ON WE.WIP_ENTITY_ID = WOV.WIP_ENTITY_ID";
query+=" INNER JOIN WIP_OPERATION_RESOURCES_V WOR";
query+=" ON WOV.WIP_ENTITY_ID = WOR.WIP_ENTITY_ID";
query+=" INNER JOIN MFG_LOOKUPS ML";
query+=" ON WDJ.STATUS_TYPE = ML.LOOKUP_CODE";
query+=" INNER JOIN WIP_DEPT_RESOURCES_V WDR";
query+=" ON WOR.RESOURCE_ID = WDR.RESOURCE_ID";

query+=" WHERE ML.LOOKUP_TYPE = 'WIP_JOB_STATUS'";
query+=" AND WDJ.STATUS_TYPE IN (1, 3) AND WDR.RESOURCE_TYPE = 'Machine'";
query+=" AND WDR.SHARE_FROM_DEPARTMENT = WOV.DEPARTMENT_CODE AND WOV.OPERATION_SEQ_NUM =20";
query+=" AND WDR.RESOURCE_CODE='"+machine_id+"'";
query+=" AND to_char(WOV.FIRST_UNIT_START_DATE,'MM/DD/YYYY') between '"+paramFromDate+"' AND '"+paramToDate+"' ";

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
