<%@ page contentType="text/html; charset=TIS-620" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" import="net.sf.json.JSONArray" %>
<%
Connection conn = null;
try
{
Class.forName("oracle.jdbc.driver.OracleDriver");
conn = DriverManager.getConnection("jdbc:oracle:thin:@172.18.88.205:1525:prod","apps","apps");
Statement st = conn.createStatement();
String query = "select max(bwo.DESCRIPTION) DEPT,max(wo.OPERATION_SEQ_NUM) OPER_NUM "+
",max(MIC.INVENTORY_ITEM_ID) ITEM_ID "+
",max(WE.WIP_ENTITY_NAME) JOB_NO,max(MSI.DESCRIPTION) ITEM_DESCRIPTION "+
", max(WMT.TRANSACTION_QUANTITY) TRAN_QTY,max(WO.QUANTITY_COMPLETED) PLAN_QTY "+
",max(WMT.LAST_UPDATE_DATE) JOB_MOVE_DATE "+
",max(WDJ.STATUS_TYPE_DISP) STATUS " +
" from WIP_ENTITIES WE left join "+
  "WIP_OPERATIONS_V WO on WE.WIP_ENTITY_ID = WO.WIP_ENTITY_ID left join WIP_MOVE_TRANSACTIONS WMT "+
  "on WE.WIP_ENTITY_ID = WMT.WIP_ENTITY_ID left join MTL_ITEM_CATEGORIES MIC "+
  "on WMT.PRIMARY_ITEM_ID = MIC.INVENTORY_ITEM_ID left join MTL_CATEGORIES MC "+
   "on MIC.CATEGORY_ID = MC.CATEGORY_ID left join "+
  "MTL_SYSTEM_ITEMS MSI on MIC.INVENTORY_ITEM_ID = MSI.INVENTORY_ITEM_ID left join "+
   "(select QSCV.char_name,QSCV.uom_code uomlab,QSCV.target_value,QSCV.lower_user_defined_limit "+
	",QSCV.upper_user_defined_limit,QSCV.ATTRIBUTE15 METHOD,QSV.ITEM_ID "+
	"from QA_SPECS_V QSV inner join QA_SPEC_CHARS_V QSCV on QSV.SPEC_ID = QSCV.SPEC_ID ) QSV "+
	"on WMT.PRIMARY_ITEM_ID = QSV.ITEM_ID "+
	"LEFT JOIN BOM_DEPARTMENTS_V  bwo on WO.DEPARTMENT_CODE = bwo.DEPARTMENT_CODE "+
        "LEFT JOIN WIP_DISCRETE_JOBS_V WDJ on WE.WIP_ENTITY_ID = WDJ.WIP_ENTITY_ID "+
"where  MIC.ORGANIZATION_ID = 104 and MSI.ORGANIZATION_ID = 104 "+
"and WMT.LAST_UPDATE_DATE between to_date ('2012/08/01', 'yyyy/mm/dd') AND to_date ('2012/08/08', 'yyyy/mm/dd') "+
"and bwo.DEPARTMENT_CODE like '0314' "+
"group by WE.WIP_ENTITY_NAME"; 
ResultSet rs = st.executeQuery(query);
JSONArray arrayObj=new JSONArray();
while(rs.next())
{ 
JSONArray arrayObj_sub=new JSONArray();
 arrayObj_sub.add(rs.getString("DEPT"));
 arrayObj_sub.add(rs.getString("ITEM_ID"));
 arrayObj_sub.add(rs.getString("JOB_NO"));
 arrayObj_sub.add(rs.getString("ITEM_DESCRIPTION"));
 arrayObj_sub.add(rs.getString("PLAN_QTY"));
 arrayObj.add(arrayObj_sub);
}
 out.println(arrayObj);
response.setContentType("application/json");

   for(int i=0;i<arrayObj.size();i++){  
	  arrayObj.getString(i);
  }
}
catch(SQLException e)
{
out.println("SQLException: " + e.getMessage() + "<BR>");
while((e = e.getNextException()) != null)
out.println(e.getMessage() + "<BR>");
}
catch(ClassNotFoundException e)
{
out.println("ClassNotFoundException: " + e.getMessage() + "<BR>");
}
finally
{
//Clean up resources, close the connection.
if(conn != null)
{
try
{
conn.close();
}
catch (Exception ignored) {}
}
}
%>
