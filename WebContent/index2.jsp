<html>
<head>
    <style>
    table.k-focusable{
    position:absolute;
    }
    #loading{
        display: none;
        position:absolute;
    }
    </style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="css/ui-darkness/jquery-ui-1.8.23.custom.css"  type="text/css" rel="stylesheet">
<link href="css/index.css" type="text/css" rel="stylesheet" >
<link href="kendo/styles/kendo.default.min.css" type="text/css" rel="stylesheet" >
<link href="kendo/styles/kendo.black.min.css" type="text/css" rel="stylesheet" >

<link href="kendo/styles/kendo.common.min.css" rel="stylesheet" type="text/css">
<link href="mygatt.css" rel="stylesheet" type="text/css">
<script src="js/jquery-1.8.0.min.js"></script>
<script src="kendo/js/kendo.all.min.js"></script>
<script src="js/jquery-ui-1.8.23.custom.min.js"></script>
<script type="text/javascript">
    
$(document).ready(function(){

//กำหนดภาพเลื่อน
var numDown1=0;
var numDown2=0;
var numDown3=0;
var numDown4=0;
var $i=0;
var $j=0;

//ฟังก์ชันจัดการในส่วนของกำหนดควบคุมข้อมูลส slide Start1
var defineTimeSlide1=function(){
    setTimeout(function(){
        var $numTR = $("#grid1 table.k-focusable tbody tr").length;
        if( $j < $numTR ){
        var $hieghtTR = $("#grid1 table.k-focusable tbody tr:eq("+$j+")").height();
        console.log($hieghtTR);
        console.log($j);
        numDown1+=-$hieghtTR;
        dataSlideDown1(numDown1);
        //console.log("call method1"+numDown1);
        defineTimeSlide1();
        $j++;
        
        }else{
        $j=0; 
        defineTimeSlide1();
        }
        
    },5000);
}

var dataSlideDown1=function(numDown){   
    
var $hieght = $("#grid1 table.k-focusable").height();
//alert(-$hieght);
    if(numDown>-$hieght){
        $("#grid1 table.k-focusable").animate({"top":numDown});
    }else{
        $("#grid1 table.k-focusable").css({"top":"0px"});
        numDown1=0;
        callAjaxByDepartment("PRMX.jsp","#grid1");
    }
}
//ฟังก์ชันจัดการในส่วนของกำหนดควบคุมข้อมูลส slide End1


//ฟังก์ชันจัดการในส่วนของกำหนดควบคุมข้อมูลส slide Start2
var defineTimeSlide2=function(){
    setTimeout(function(){
        numDown2+=-80;
        dataSlideDown2(numDown2);
        //console.log("call method2"+numDown2);
        defineTimeSlide2();
    },5000);
}


var dataSlideDown2=function(numDown){
$("#grid2 table.k-focusable").animate({"top":numDown});
}
//ฟังก์ชันจัดการในส่วนของกำหนดควบคุมข้อมูลส slide End2
//ฟังก์ชันจัดการในส่วนของกำหนดควบคุมข้อมูลส slide Start3
var defineTimeSlide3=function(){
    setTimeout(function(){
        numDown3+=-80;
        dataSlideDown3(numDown3);
        //console.log("call method3"+numDown3);
        defineTimeSlide3();
    },5000);
}

var dataSlideDown3=function(numDown){
$("#grid3 table.k-focusable").animate({"top":numDown});
}
//ฟังก์ชันจัดการในส่วนของกำหนดควบคุมข้อมูลส slide End3
//ฟังก์ชันจัดการในส่วนของกำหนดควบคุมข้อมูลส slide Start4
var defineTimeSlide4=function(){
    
    setTimeout(function(){
        var $numTR = $("#grid4 table.k-focusable tbody tr").length;
        if( $i < $numTR ){
        var $hieghtTR = $("#grid4 table.k-focusable tbody tr:eq("+$i+")").height();
        numDown4+=-$hieghtTR;
        
        }else{
        $i=0;   
        }
     
        
        
        dataSlideDown4(numDown4);
        //console.log("call method4"+numDown4);
        defineTimeSlide4();
        $i++;
    },5000);
}

var dataSlideDown4=function(numDown){
var $hieght = $("#grid4 table.k-focusable").height();

    if(numDown> -$hieght){
        $("#grid4 table.k-focusable").animate({"top":numDown});
    }else{
        $("#grid4 table.k-focusable").css({"top":"0px"});
        numDown4=0;
        callAjaxByDepartment("APKX.jsp","#grid4");
    }
}
//ฟังก์ชันจัดการในส่วนของกำหนดควบคุมข้อมูลส slide End4
//ลำดับการทำงาน
defineTimeSlide1();
setTimeout(function(){
defineTimeSlide2();
},1000);

setTimeout(function(){
defineTimeSlide3();
},1500);

setTimeout(function(){
defineTimeSlide4();

},2000);

$("body").css("background","black");
//jqueyUi tabs
$("#tabs").tabs();

//.kendoDropDownList  
$("#plaint").kendoDropDownList();

//defind function grid

var grid = function(gridName,gridData){
 $(gridName).kendoGrid({
                        /*dataSource: {
                            data: createRandomData(50),
                            pageSize: 10
                        },*/
					theme:$(document).data("kendoSkin") || "black",
					 dataSource: {
							 data:gridData,
						 
						 pageSize: 500
					 },

                       //groupable: true,
                       //sortable: true,
                       //scrollable:true,
					 pageable: {
                            refresh: true,
                            pageSizes: 10
                        },
                        columns: [ {
                                field: "Item",
                             
                                title: "Item"
                            },{
                                field:"StartingDate",
                                title:"Starting date"
                                
                            },{
                                field: "JobNo",
                   
                                title: "Job No"
                            },{
                                field: "Detail",
                           
                                title: "Detail"
                            },{
                                field: "PlanQty",
                              
                                title: "Plan Qty"
                            }
                        ]
                    });
//grid1
}
//call function grid
//เรียก functionในการสร้าง content ในรูปแบบ json สำหรับ ตาราง grid
var callAjaxByDepartment=function(paramUrl,paramNameGrid){
		$.ajax({
			   url:paramUrl,
			   //url:'PRMX.jsp'
			   dataType:'json',
                          cache: false,
			   success:function(data){
				   var gridData="[";
				   var Item="";
				   var StartingDate="";
				   var JobNo="";
				   var Detail="";
				   var PlanQty="";
				   var i=0;
				   $.each(data,function(index,intryIndex){
					  if(i==0){
						 gridData+="{";
					  }else{
						 gridData+=",{"; 
					  }
					  //console.log(intryIndex[3]);
					  gridData+="\"Item\":\""+intryIndex[1]+"\",";
					  gridData+="\"StartingDate\":\""+intryIndex[3]+"\",";
					  gridData+="\"JobNo\":\""+intryIndex[0]+"\",";
					  gridData+="\"Detail\":\""+intryIndex[2]+"\",";
					  gridData+="\"PlanQty\":\""+intryIndex[4]+"\"";
					  gridData+="}";
					  i++;
				   });
					gridData+="]";
				  var obj_gridData=eval("("+gridData+")");
                                  $(paramNameGrid).empty();
				  grid(paramNameGrid,obj_gridData);
				  /*
				  grid("#grid2",obj_gridData);
				  grid("#grid3",obj_gridData);
				  grid("#grid4",obj_gridData);
				  */
			   }
			});

}//callAjaxByDepartment



//Call function for run data content of  Department
callAjaxByDepartment("PRMX.jsp","#grid1");
callAjaxByDepartment("M5N7.jsp","#grid2");
callAjaxByDepartment("FRMX.jsp","#grid3");
callAjaxByDepartment("APKX.jsp","#grid4");
//ลำดับการแสดงผล

//config grid template
$(".k-grid td").css({"padding-top":"0px","padding-bottom":"0px"});

//ajax Start

$("#loading").ajaxStart(function(){
$(this).show();
});
//ajax Stop
$("#loading").ajaxStop(function(){
$(this).hide();
});  

});//jquery

</script>

<title>DashBoard</title>
</head>
<body>
<div id="loading">Loading....</div>
<div id="body">
	<div id="tabs">
		<ul>
			<li>
				<a href="#content1">Status overview</a>
			</li>
			<!--
			<li>
				<a href="#content2">Menu schedule</a>
			</li>
			
			<li>
				<a href="#content3">Schedule</a>
			</li>
			-->
		</ul>
		<div id="content1">
		<div id="plant" style="padding:5px;">

		<b>Plant</b> : <select name="plaint" id="plaint">
		<option>plant1</option>
		<option>plant2</option>
		<option>plant3</option>
		</select>
		</div>
				<!-- Dashboard Content-->
				<div id="content">
				
				<!-- box-->
					<div class="box">
						<div class="head">
							<div class="title">
							ชั่งสาร
							</div>
						</div>
						<div class="content">
						<!-- table-->
						   <div id="grid1" style="height: 270px"></div>
						<!-- table-->
							
						</div>
					</div>
				<!-- box-->
				<!-- box-->
					<div class="box">
						<div class="head">
						
							<div class="title">
							ผสม
							</div>
						</div>
						<div class="content">
						<!-- table-->
						  <div id="grid2" style="height: 270px"></div>
						<!-- table-->
						</div>
					</div>
				<!-- box-->
				<!-- box-->
					<div class="box">
						<div class="head">
							<div class="title">
							บรรจุ
							</div>
						</div>
						<div class="content">
						<!-- table-->
						  <div id="grid3" style="height: 270px"></div>
						<!-- table-->
						</div>
					</div>
				<!-- box-->
				<!-- box-->
					<div class="box">
						<div class="head">
							<div class="title">
							ประกอบ
							</div>
						</div>
						<div class="content">
						<!-- table-->
						  <div id="grid4" style="height: 270px"></div>
						<!-- box-->
				
				</div><!-- content1-->
				
				<!-- Dashboard Content-->
				<br style="clear:both">
				
			</div>
			<div id="content2">
			<!-- ganttChat-->

			<!-- ganttChat-->
				</div>
			<div id="content4">
			<!-- ganttChat-->

			<!-- ganttChat-->
				</div>
				<br style="clear:both">
	</div>
	
</div>
<div id="content3">
			<!-- ganttChat-->

			<!-- ganttChat-->
				</div>
            
</body>
</html>
