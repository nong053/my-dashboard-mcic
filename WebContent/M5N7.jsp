<%@ page contentType="text/html; charset=TIS-620" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" import="net.sf.json.JSONArray" %>
<%
String paramDepartment=request.getParameter("paramdepartment");
Connection conn = null;
try
{
Class.forName("oracle.jdbc.driver.OracleDriver");
conn = DriverManager.getConnection("jdbc:oracle:thin:@172.18.88.205:1525:prod","apps","apps");
Statement st = conn.createStatement();
String query = "SELECT WEI.WIP_ENTITY_NAME,  MSI.segment1,  MSI.DESCRIPTION, WOV.FIRST_UNIT_START_DATE,  WDJ.START_QUANTITY,WDJ.STATUS_TYPE FROM WIP_ENTITIES WEI  INNER JOIN WIP_OPERATIONS_V WOV  ON WEI.WIP_ENTITY_ID = WOV.WIP_ENTITY_ID  INNER JOIN WIP_DISCRETE_JOBS WDJ  ON WEI.WIP_ENTITY_ID = WDJ.WIP_ENTITY_ID  INNER JOIN MTL_SYSTEM_ITEMS MSI ON WEI.PRIMARY_ITEM_ID = MSI.INVENTORY_ITEM_ID WHERE     WOV.OPERATION_SEQ_NUM = 20   AND WOV.OPERATION_CODE = 'M5N7'  AND (WDJ.STATUS_TYPE = 4 OR WDJ.STATUS_TYPE =3)   AND WDJ.PROGRAM_ID IS NULL  AND WDJ.REQUEST_ID IS NULL AND FIRST_UNIT_START_DATE between sysdate-30 AND sysdate AND WOV.OPERATION_CODE  like '%"+paramDepartment+"%' ORDER BY FIRST_UNIT_START_DATE ASC"; 
ResultSet rs = st.executeQuery(query);
JSONArray arrayObj=new JSONArray();
while(rs.next())
{ 
JSONArray arrayObj_sub=new JSONArray();
arrayObj_sub.add(rs.getString("WIP_ENTITY_NAME")+" "+rs.getString("DESCRIPTION"));
 arrayObj_sub.add(rs.getString("segment1"));
 arrayObj_sub.add(rs.getString("FIRST_UNIT_START_DATE"));
 arrayObj_sub.add(rs.getString("START_QUANTITY"));
 arrayObj_sub.add(rs.getString("STATUS_TYPE"));
 

 arrayObj.add(arrayObj_sub);
}
 out.println(arrayObj);
   
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
