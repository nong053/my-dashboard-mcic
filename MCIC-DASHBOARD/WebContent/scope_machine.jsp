<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="config.jsp"%>
<%


String paramFromDate = request.getParameter("paramFromDate");
String paramToDate = request.getParameter("paramToDate");
String machine_id = request.getParameter("machine_id");
String paramYear = request.getParameter("paramYear");

//String paramFromDate = "01/22/2013";
//String paramToDate = "02/22/2013";
//String paramYear = "2013";
/*
String paramFromDate = "";
String paramToDate = "";
String paramYear = "2013";
*/
String nameMMFrom="";
String nameMMTo="";
String SplitDateFrom[];
String SplitDateTo[];
SplitDateFrom=paramFromDate.split("/");
SplitDateTo=paramToDate.split("/");

//out.println("SplitDateFrom[0]"+SplitDateFrom[0]);
if(paramFromDate!= "" && paramToDate!= ""){

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
}//if
//out.println(SplitDateTo[1]+"-"+nameMMTo+"-"+SplitDateTo[2]);


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
//query+=" AND WDR.RESOURCE_CODE='"+machine_id+"'";
if(machine_id != null) {
query+=" AND WDR.RESOURCE_CODE='"+machine_id+"'";
}
if((paramFromDate !="") && (paramToDate !="")){

//query+=" AND to_char(WOV.FIRST_UNIT_START_DATE,'MM/DD/YYYY') between '"+paramFromDate+"' AND '"+paramToDate+"' ";
query+=	"AND TRUNC(WOV.FIRST_UNIT_START_DATE) between '"+SplitDateFrom[1]+"-"+nameMMFrom+"-"+SplitDateFrom[2]+"' and '"+SplitDateTo[1]+"-"+nameMMTo+"-"+SplitDateTo[2]+"'";

}else if(paramYear !=""){

query+=" AND to_char(WOV.FIRST_UNIT_START_DATE,'YYYY') ='"+paramYear+"'";	
}
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
