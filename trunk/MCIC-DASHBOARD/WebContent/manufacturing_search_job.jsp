<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="config.jsp"%>
<%


String paramJob = request.getParameter("paramJob");
//out.print("paramJob"+paramJob);
ResultSet rs;
JSONArray array_obj = new JSONArray();

String query="";


query+="SELECT  WDR.RESOURCE_CODE AS MACHINE_CODE ,";
query+=" WDR.RESOURCE_DESCRIPTION AS MACHINE_NAME ,";
query+="WE.WIP_ENTITY_NAME AS JOB ,";
query+="WOV.FIRST_UNIT_START_DATE AS START_DATE,";
query+="WOV.LAST_UNIT_COMPLETION_DATE AS END_DATE, ";
query+="WOV.SCHEDULED_QUANTITY AS QUANTITY ,";
query+="WOV.QUANTITY_COMPLETED AS ACTSUAL ,";
query+="ML.MEANING";

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

query+=" AND WE.WIP_ENTITY_NAME LIKE '%"+paramJob+"%'";
//query+=" AND ROWNUM <100";
query+=" ORDER BY JOB";
/*AND ROWNUM <5*/


rs = OracleConn.selectData(query);

	
		while(rs.next()){
			JSONArray array_obj_sub = new JSONArray();
			
			array_obj_sub.add(rs.getString(1));
			array_obj_sub.add(rs.getString(2));
			array_obj_sub.add(rs.getString(3));
			array_obj_sub.add(rs.getString(4));
			array_obj_sub.add(rs.getString(5));
			array_obj_sub.add(rs.getString(6));
			array_obj_sub.add(rs.getString(7));
			array_obj_sub.add(rs.getString(8));

			
			array_obj.add(array_obj_sub);
			
		}
		out.print(array_obj);
		conn.close();
	
%>
