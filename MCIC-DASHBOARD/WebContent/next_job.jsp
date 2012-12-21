<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="config.jsp"%>
<%

String paramNextJobNumber = request.getParameter("paramNextJobNumber");
ResultSet rs;
JSONArray array_obj = new JSONArray();

String query="";


query+="select DISTINCT WOV.OPERATION_SEQ_NUM,WOV.OPERATION_CODE,WOV.DESCRIPTION ";
query+=" from WIP_OPERATIONS_V WOV ";
query+="where WOV.OPERATION_SEQ_NUM='"+paramNextJobNumber+"'";


rs = OracleConn.selectData(query);

	
		while(rs.next()){
			JSONArray array_obj_sub = new JSONArray();
			
			array_obj_sub.add(rs.getString(3));
			
			array_obj.add(array_obj_sub);
			
		}
		out.print(array_obj);
		conn.close();
	
%>
