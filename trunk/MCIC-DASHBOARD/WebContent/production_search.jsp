<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="config.jsp"%>
<%


String paramJobNumber = request.getParameter("paramJobNumber");


ResultSet rs;
JSONArray array_obj = new JSONArray();

String query="";

query+="SELECT DISTINCT WDJ.SCHEDULED_START_DATE,";

query+="WEI.WIP_ENTITY_NAME,";
query+="MSI.segment1,";
query+="MSI.DESCRIPTION,";
query+="WOV.SCHEDULED_QUANTITY,";
query+="MSI.PRIMARY_UOM_CODE,";
query+="BD.DESCRIPTION,";
query+="WOV.QUANTITY_COMPLETED,";
query+="WOV.OPERATION_CODE,";
query+="BD.DEPARTMENT_CODE,";
query+="WOV.NEXT_OPERATION_SEQ_NUM";

query+=" FROM WIP_ENTITIES WEI";

query+=" INNER JOIN WIP_OPERATIONS_V WOV";
query+=" ON WEI.WIP_ENTITY_ID = WOV.WIP_ENTITY_ID";
query+=" INNER JOIN WIP_DISCRETE_JOBS WDJ";
query+=" ON WEI.WIP_ENTITY_ID = WDJ.WIP_ENTITY_ID";
query+=" INNER JOIN MTL_SYSTEM_ITEMS MSI";
query+=" ON WEI.PRIMARY_ITEM_ID = MSI.INVENTORY_ITEM_ID";
query+=" INNER JOIN BOM_DEPARTMENTS BD";
query+=" ON WOV.DEPARTMENT_ID = BD.DEPARTMENT_ID";

query+=" WHERE WDJ.PROGRAM_ID IS NULL";
query+=" AND WOV.OPERATION_SEQ_NUM = 10";
query+=" AND (WDJ.STATUS_TYPE = 4 OR WDJ.STATUS_TYPE =3)";
query+=" AND MSI.ORGANIZATION_ID = 104";

query+=" AND WDJ.REQUEST_ID IS NULL";

query+=" AND (WOV.OPERATION_CODE in ('PRMX','M5N7','APKX') OR WOV.OPERATION_CODE like 'F%')";

query+=" AND WIP_ENTITY_NAME like '%"+paramJobNumber+"%'";

query+=" AND FIRST_UNIT_START_DATE between sysdate-15 AND sysdate";	

query+=" ORDER BY SCHEDULED_START_DATE ASC";


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
			array_obj_sub.add(rs.getString("NEXT_OPERATION_SEQ_NUM"));
			
			array_obj.add(array_obj_sub);
			
		}
		out.print(array_obj);
		conn.close();
	
%>
