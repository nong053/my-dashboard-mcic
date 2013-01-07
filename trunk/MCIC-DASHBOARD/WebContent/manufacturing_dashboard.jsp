<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="config.jsp"%>
<%


String paramFromDate =request.getParameter("paramFromDate");
String paramToDate =request.getParameter("paramToDate");
String SplitDateFrom[];
String SplitDateTo[];
String nameMMFrom="";
String nameMMTo="";
SplitDateFrom=paramFromDate.split("/");
SplitDateTo=paramToDate.split("/");

if(paramFromDate!= "" && paramToDate!= ""){
//String paramFromDate = "01/22/2013";
//String paramToDate = "05/22/2013";



switch(Integer.parseInt(SplitDateFrom[0])){

case 1 : nameMMFrom="JAN"; break;
case 2 : nameMMFrom="FEB"; break;
case 3 : nameMMFrom="MAR"; break;
case 4 : nameMMFrom="APR"; break;
case 5 : nameMMFrom="MAY"; break;
case 6 : nameMMFrom="JUN"; break;
case 7 : nameMMFrom="JUL"; break;
case 8 : nameMMFrom="AUG"; break;
case 9 : nameMMFrom="SEP"; break;
case 10 : nameMMFrom="OCT"; break;
case 11 : nameMMFrom="NOV"; break;
case 12 : nameMMFrom="DEC"; break;

}
//out.println(SplitDateFrom[1]+"-"+nameMMFrom+"-"+SplitDateFrom[2]);

switch(Integer.parseInt(SplitDateTo[0])){

case 1 : nameMMTo="JAN"; break;
case 2 : nameMMTo="FEB"; break;
case 3 : nameMMTo="MAR"; break;
case 4 : nameMMTo="APR"; break;
case 5 : nameMMTo="MAY"; break;
case 6 : nameMMTo="JUN"; break;
case 7 : nameMMTo="JUL"; break;
case 8 : nameMMTo="AUG"; break;
case 9 : nameMMTo="SEP"; break;
case 10 : nameMMTo="OCT"; break;
case 11 : nameMMTo="NOV"; break;
case 12 : nameMMTo="DEC"; break;

}

}// if

//out.println(SplitDateTo[1]+"-"+nameMMTo+"-"+SplitDateTo[2]);

//out.println("paramFromDate"+paramFromDate);
//out.println("paramToDate"+paramToDate);
//String paramFromDate = "01-JAN-2013";
//String paramToDate = "06-JAN-2013";

String paramYear = request.getParameter("paramYear");
String machine_id =request.getParameter("machine_id");
//String machine_id ="M3MM-10000";



ResultSet rs;
JSONArray array_obj = new JSONArray();

String query="";


query+="SELECT WDR.RESOURCE_CODE AS MACHINE_CODE , WDR.RESOURCE_DESCRIPTION AS MACHINE_NAME ,WE.WIP_ENTITY_NAME AS JOB , WOV.FIRST_UNIT_START_DATE AS START_DATE,WOV.LAST_UNIT_COMPLETION_DATE AS END_DATE, WOV.SCHEDULED_QUANTITY AS QUANTITY , WOV.QUANTITY_COMPLETED AS ACTSUAL, WOV.NEXT_OPERATION_SEQ_NUM, ML.MEANING, WOV.WIP_ENTITY_ID, ( SELECT COUNT(*) FROM WIP_ENTITIES WE2 INNER JOIN WIP_DISCRETE_JOBS_V WDJ2 ON WE2.WIP_ENTITY_ID = WDJ2.WIP_ENTITY_ID INNER JOIN WIP_OPERATIONS_V WOV2 ON WE2.WIP_ENTITY_ID = WOV2.WIP_ENTITY_ID INNER JOIN WIP_OPERATION_RESOURCES_V WOR2 ON WOV2.WIP_ENTITY_ID = WOR2.WIP_ENTITY_ID INNER JOIN MFG_LOOKUPS ML2 ON WDJ2.STATUS_TYPE = ML2.LOOKUP_CODE INNER JOIN WIP_DEPT_RESOURCES_V WDR2 ON WOR2.RESOURCE_ID = WDR2.RESOURCE_ID WHERE ML2.LOOKUP_TYPE = 'WIP_JOB_STATUS' AND WDJ2.STATUS_TYPE IN (1, 3) AND WDR2.RESOURCE_TYPE = 'Machine' AND WDR2.SHARE_FROM_DEPARTMENT = WOV2.DEPARTMENT_CODE AND WOV2.OPERATION_SEQ_NUM =20 ";
if(machine_id != null) {
query+=" AND WDR.RESOURCE_CODE='"+machine_id+"'";
}


if(paramFromDate!="" && paramToDate!=""){
//query+=" AND to_char(START_DATE,'MM/DD/YYYY') between '"+paramFromDate+"' AND '"+paramToDate+"'";
query+=	"AND TRUNC(WOV2.FIRST_UNIT_START_DATE) between '"+SplitDateFrom[1]+"-"+nameMMFrom+"-"+SplitDateFrom[2]+"' and '"+SplitDateTo[1]+"-"+nameMMTo+"-"+SplitDateTo[2]+"'";
}else if(paramYear!=""){

query+=" AND to_char(START_DATE,'YYYY')='"+paramYear+"'";
}

query+="AND WDR2.RESOURCE_CODE = WDR.RESOURCE_CODE AND TO_CHAR(WOV2.FIRST_UNIT_START_DATE,'YYYY/MM/DD') = TO_CHAR(WOV.FIRST_UNIT_START_DATE,'YYYY/MM/DD') AND (WOV.FIRST_UNIT_START_DATE < WOV2.LAST_UNIT_COMPLETION_DATE) AND (WOV.LAST_UNIT_COMPLETION_DATE > WOV2.FIRST_UNIT_START_DATE) ) AS OVERLAP_FLAG FROM WIP_ENTITIES WE INNER JOIN WIP_DISCRETE_JOBS_V WDJ ON WE.WIP_ENTITY_ID = WDJ.WIP_ENTITY_ID INNER JOIN WIP_OPERATIONS_V WOV ON WE.WIP_ENTITY_ID = WOV.WIP_ENTITY_ID INNER JOIN WIP_OPERATION_RESOURCES_V WOR ON WOV.WIP_ENTITY_ID = WOR.WIP_ENTITY_ID INNER JOIN MFG_LOOKUPS ML ON WDJ.STATUS_TYPE = ML.LOOKUP_CODE INNER JOIN WIP_DEPT_RESOURCES_V WDR ON WOR.RESOURCE_ID = WDR.RESOURCE_ID WHERE ML.LOOKUP_TYPE = 'WIP_JOB_STATUS' AND WDJ.STATUS_TYPE IN (1, 3) AND WDR.RESOURCE_TYPE = 'Machine' AND WDR.SHARE_FROM_DEPARTMENT = WOV.DEPARTMENT_CODE AND WOV.OPERATION_SEQ_NUM =20 ";
/*
query+="SELECT  WDR.RESOURCE_CODE AS MACHINE_CODE ,";
query+=" WDR.RESOURCE_DESCRIPTION AS MACHINE_NAME ,";
query+="WE.WIP_ENTITY_NAME AS JOB ,";
query+="WOV.FIRST_UNIT_START_DATE AS START_DATE,";
query+="WOV.LAST_UNIT_COMPLETION_DATE AS END_DATE, ";
query+="WOV.SCHEDULED_QUANTITY AS QUANTITY ,";
query+="WOV.QUANTITY_COMPLETED AS ACTSUAL ,";
query+="WOV.NEXT_OPERATION_SEQ_NUM ,";
query+="ML.MEANING ,";
query+="WOV.WIP_ENTITY_ID ,";

query+="(";
query+="SELECT COUNT(*) ";
query+="FROM WIP_OPERATIONS_V WOV2 ";
query+="WHERE WOV2.WIP_ENTITY_ID = WOV.WIP_ENTITY_ID ";
query+="AND (WOV.FIRST_UNIT_START_DATE < WOV2.LAST_UNIT_COMPLETION_DATE) AND (WOV.LAST_UNIT_COMPLETION_DATE > WOV2.FIRST_UNIT_START_DATE) )AS OVERLAP_FLAG ";



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

*/

if(machine_id != null){
query+=" AND WDR.RESOURCE_CODE='"+machine_id+"'";

}
if(paramFromDate!="" && paramToDate!=""){
//query+=" AND to_char(START_DATE,'MM/DD/YYYY') between '"+paramFromDate+"' AND '"+paramToDate+"'";
query+=	"AND TRUNC(WOV.FIRST_UNIT_START_DATE) between '"+SplitDateFrom[1]+"-"+nameMMFrom+"-"+SplitDateFrom[2]+"' and '"+SplitDateTo[1]+"-"+nameMMTo+"-"+SplitDateTo[2]+"'";
}else if(paramYear!=""){
query+=" AND to_char(START_DATE,'YYYY')='"+paramYear+"'";
}
query+=" ORDER BY JOB";



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
			array_obj_sub.add(rs.getString(9));
			/*array_obj_sub.add(rs.getString(9));*/
			array_obj_sub.add(rs.getString("OVERLAP_FLAG"));
			
			array_obj.add(array_obj_sub);
			
		}
		out.print(array_obj);
		conn.close();
	
%>
