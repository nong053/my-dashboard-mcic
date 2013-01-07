<%
/*
1/01/2013
*/
String date = "05/22/2013";
String SplitDate[]=date.split("/");
String nameMM="";
//01-JAN-2013
switch(Integer.parseInt(SplitDate[0])){

case 1 : nameMM="JAN"; break;
case 2 : nameMM="FEB"; break;
case 3 : nameMM="MAR"; break;
case 4 : nameMM="APR"; break;
case 5 : nameMM="MAY"; break;
case 6 : nameMM="JUN"; break;
case 7 : nameMM="JUL"; break;
case 8 : nameMM="AUG"; break;
case 9 : nameMM="SEP"; break;
case 10 : nameMM="OCT"; break;
case 11 : nameMM="NOV"; break;
case 12 : nameMM="DEC"; break;

}

out.println(SplitDate[1]+"-"+nameMM+"-"+SplitDate[2]);
%>