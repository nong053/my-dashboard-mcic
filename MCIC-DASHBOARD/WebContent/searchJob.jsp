<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="config.jsp"%>
<%
String paramSearch = request.getParameter("paramSearch");
/*String paramSearch="JB5509";*/

ResultSet rs;
String query="";
query+="SELECT WEI.WIP_ENTITY_NAME,  MSI.segment1,  MSI.DESCRIPTION,  WOV.FIRST_UNIT_START_DATE,WDJ.START_QUANTITY,WDJ.STATUS_TYPE,WOV.OPERATION_CODE   ";
query+=" FROM WIP_ENTITIES WEI  INNER JOIN WIP_OPERATIONS_V WOV  ON WEI.WIP_ENTITY_ID = WOV.WIP_ENTITY_ID INNER JOIN WIP_DISCRETE_JOBS WDJ  ON WEI.WIP_ENTITY_ID = WDJ.WIP_ENTITY_ID  INNER JOIN MTL_SYSTEM_ITEMS MSI ON WEI.PRIMARY_ITEM_ID = MSI.INVENTORY_ITEM_ID";
query+=" WHERE WDJ.PROGRAM_ID IS NULL    AND WDJ.REQUEST_ID IS NULL AND (WDJ.STATUS_TYPE = 4 OR WDJ.STATUS_TYPE =3) AND FIRST_UNIT_START_DATE between sysdate-15 AND sysdate AND WEI.WIP_ENTITY_NAME like '%"+paramSearch+"%'";

rs = OracleConn.selectData(query);
JSONArray array_obj = new JSONArray();
JSONArray array_obj_sub = new JSONArray();
try{
while(rs.next()){
	
	array_obj_sub.add(rs.getString("WIP_ENTITY_NAME")+" "+rs.getString("DESCRIPTION"));
	array_obj_sub.add(rs.getString("segment1"));
	array_obj_sub.add(rs.getString("FIRST_UNIT_START_DATE"));
	array_obj_sub.add(rs.getString("START_QUANTITY"));
	 array_obj_sub.add(rs.getString("STATUS_TYPE"));
	 array_obj_sub.add(rs.getString("OPERATION_CODE"));
	 
	
	array_obj.add(array_obj_sub);
}

out.print(array_obj);
}catch(Exception ex){
	out.print("error"+ex);
}finally{
	conn.close();
}

%>
