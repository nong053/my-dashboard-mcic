    
$(document).ready(function(){
	//define element from date and to date bind kendoDatePicker.
	$(".date").kendoDatePicker();
	
	//function select management plant for detect
	$.ajax({
		url:'PLANT.jsp',
		dataType:'json',
		success:function(data){
			var html="";	
		
			    html+="<option value=''>All-PLANT</option>";
				for(var i=0;i<data[0].length;i++){
					html+="<option value='"+data[0][i]+"'>"+data[0][i]+"</option>";
				}
				
				$("select#plant").html(html);
				//.kendoDropDownList  
				$("#plant").kendoDropDownList();
				//call ajax for dash board by department
				
				/*
				$("select#plant").live("change",function(){
					$("#selectDepartment").html(this.value);
					numDown1=0;
					numDown2=0;
					numDown3=0;
					numDown4=0;
					callAjaxAndSort();
					
				});
				*/
				
		}
	});
	
	//function select management Department for detect
	
	$.ajax({
		url:'Department.jsp',
		dataType:'json',
		success:function(data){
			var html="";	
		
			    html+="<option value=''>All-Department</option>";
				for(var i=0;i<data[0].length;i++){
					html+="<option value='"+data[0][i]+"'>"+data[0][i]+"</option>";
				}
				
				$("select#department").html(html);
				//.kendoDropDownList  
				$("#department").kendoDropDownList();
		}
	});
	
	
	//submit for search and display into dash board.
	
	$("#submit1").live("click",function(){
		numDown1=0;
		callAjaxAndSort();
		/*
		alert($("#plant").val());
		alert($("#from_date").val());
		alert($("#to_date").val());
		*/
		//alert($("#department").val());
		
		/*$.ajax({
			
			url:'production_progress.jsp',
			type:'get',
			dataType:'html',
			cache:'false',
			data:{"paramPlant":$("#plant").val(),"paramFromDate":$("#from_date").val(),"paramToDate":$("#to_date").val(),"paramDepartment":$("#department").val()},
			success:function(data){
				//alert(data);
				numDown1=0;
				callAjaxAndSort();
			}
			
		});*/
		
		
	});

	
//กำหนดภาพเลื่อน
var numDown1=0;

var $j=0;


//ฟังก์ชันจัดการในส่วนของกำหนดควบคุมข้อมูล slide Start1
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
};

var dataSlideDown1=function(numDown){   
    
    var $hieght = $("#grid1 table.k-focusable").height();
    
    if(numDown>-$hieght){
        $("#grid1 table.k-focusable").animate({"top":numDown});
    }else{
        $("#grid1 table.k-focusable").css({"top":"0px"});
        numDown1=0;
        callAjaxProductionProgress("production_progress.jsp","#grid1",$("#selectDepartment").text());
    }
};
//ฟังก์ชันจัดการในส่วนของกำหนดควบคุมข้อมูลส slide End1

//define function grid
var grid = function(gridName,gridData){
	

 $(gridName).kendoGrid({
                        
					 theme:$(document).data("kendoSkin") || "black",
					 dataSource: {
							 data:gridData
					 },
                       scrollable:true,
                       columns: [ {
                                field: "StartingDate",
                                width:100,
                             
                                title: "<b>Date</b>"
                            },{
                                field:"JobNo",
                                width:140,
                                
                                title:"<b>Job No</b>"
                                
                            },{
                                field: "Detail",
                                width:190,
                   
                                title: "<b>Detail</b>"
                            },{
                                field: "PlanQty",
                                width:70,
                           
                                title: "<b>Plan Qty</b>"
                            },{
                                field: "ActualQty",
                                width:80,
                              
                                title: "<b>Actual Qty</b>"
                            },{
                                field: "Progress",
                                width:89,
                              
                                title: "<b>%Progress</b>"
                            },{
                                field: "Unit",
                                width:70,
                              
                                title: "<b>Unit</b>"
                            },{
                                field: "Dept",
                                width:150,
                              
                                title: "<b>Dept</b>"
                            }
                        ]
                    });
              $("#grid1 >.k-grid-content").css({"overflow-y":"hidden"});
              $("#grid1 tbody tr").each(function(){
            	 $("td:eq(3)",this).css({"text-align":"right"}); 
            	 $("td:eq(4)",this).css({"text-align":"right"}); 
            	 $("td:eq(5)",this).css({"text-align":"right"}); 
              });
              
              //check condition define font color.
           
              
             
			  
			
			//Output: Different
			var numLoopColor =0;
			var numJobReleased1 =0;
			var numJobComplete1 =0;
			
              $.each(gridData,function(index,indexIntry){
            	
          	  	if((indexIntry['PlanQty']==indexIntry['ActualQty'])){
          	  	numJobComplete1++;	
          	    $(""+gridName+" table.k-focusable tbody tr:eq("+numLoopColor+")").css({"color":"#7cfc00"});
          	  	}else{
          	  	numJobReleased1++;
          	    $(""+gridName+" table.k-focusable tbody tr:eq("+numLoopColor+")").css({"color":"white"});
          	  	}
          		numLoopColor++;

          	  });
              
              if(gridName=="#grid1"){
            	  
                  $("#jobLoadResult").html(numJobReleased1);
                  $("#jobcompeleteResult").html(numJobComplete1);
            	  numJobReleased1=0; 
            	  numJobComplete1=0;
            	  
            	  
              }
              
              var jobPercentage = function(num){
            	
            	  var jobLoad =parseInt($("#jobLoadResult").text());
            	  var jobComplete =parseInt($("#jobcompeleteResult").text());
            	  
            	  var sumjob=(jobLoad+jobComplete);
            	  rePercentage=(num/sumjob)*100;
            	  return parseFloat(rePercentage).toFixed(2);
              };
              
              
              
              //(""+jobLoadPrmx/sumJobload)*100+"%"
             var jobLoadResult= parseFloat($("#jobLoadResult").text());
             var jobComResult= parseFloat($("#jobcompeleteResult").text());
              $("#jobLoadPercentage").html(jobPercentage(jobLoadResult)+"%");
              $("#jobCompletePercentage").html(jobPercentage(jobComResult)+"%");
            
              
              //alert(sumJobload());
              
              numLoopColor=0;
              
              	console.log("numLoopColor external"+numLoopColor);
              	
              
             // $("#grid1 table.k-focusable tbody tr").css({"color":"red"});
              
              
//grid1
};

//call function grid
//เรียก functionในการสร้าง content ในรูปแบบ json สำหรับ ตาราง grid
var callAjaxProductionProgress=function(paramUrl,paramNameGrid,paramJobNumber){
	
	//manage color status work load and work complete
	var numFlashing=0;
	var statusFlashing = function(){
		$("#jobLoadPercentage").hide(500);
		setTimeout(function(){
			if(numFlashing<1){
				$("#jobLoadPercentage").show(500);
				numFlashing++;
				statusFlashing();
			}else{
				numFlashing=0;
				$("#jobLoadPercentage").show(1000);
			}
			
		},1000);
	};
	statusFlashing();
	
	
		$.ajax({
			   url:paramUrl,
			   //url:'PRMX.jsp'
			   dataType:'json',
			   data:{"paramJobNumber":paramJobNumber,"paramPlant":$("#plant").val(),"paramFromDate":$("#from_date").val(),"paramToDate":$("#to_date").val(),"paramDepartment":$("#department").val()},
               cache: false,
			   success:function(data){
				
				   var gridData="[";
				   var i=0;
				   $.each(data,function(index,intryIndex){
					   
					  if(i==0){
						 gridData+="{";
					  }else{
						 gridData+=",{"; 
					  }
					  
					  gridData+="\"StartingDate\":\""+intryIndex[0]+"\",";
					  gridData+="\"JobNo\":\""+intryIndex[1]+"\",";
					  gridData+="\"Detail\":\""+intryIndex[3]+"\",";
					  gridData+="\"PlanQty\":\""+intryIndex[4]+"\",";
					  //check when value = null if =null the result are as 0 not result null.
					  if(intryIndex[7]==null){
						  gridData+="\"ActualQty\":\"0\",";
					  }else{
						  gridData+="\"ActualQty\":\""+intryIndex[7]+"\",";
					  }
					  
					  var PlanQty =intryIndex[4];
					  var ActualQty = intryIndex[7];
					  var Progress=0;
					
					  if(ActualQty==null){
						  Progress="0.00";
					  }else{
						  Progress=((parseInt(ActualQty))/(parseInt(PlanQty)))*100; 
					  }
					  
					  
					  gridData+="\"Progress\":\""+parseFloat(Progress).toFixed(2)+"%"+"\",";
					  gridData+="\"Unit\":\""+intryIndex[5]+"\",";
					  gridData+="\"Dept\":\""+intryIndex[6]+"\"";
					  
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

};//callAjaxProductionProgress



//Call function for run data content of  Department
var callAjaxAndSort = function(){
	callAjaxProductionProgress("production_progress.jsp","#grid1",$("#selectDepartment").text());
};
//call ajaxAndSort on ready load Dom 
callAjaxAndSort();

	//ลำดับการแสดงผล
	
	defineTimeSlide1();



//config grid template
$(".k-grid td").css({"padding-top":"0px","padding-bottom":"0px"});
$("body").css("background","black");
//jqueyUi tabs
$("#tabs").tabs();
//define element search add in tab  on left and top position.

$(".ui-tabs-nav").append("<div id='searchArea'>Search: <input type='text' id='search1' name='search1'><button id='submitSearh'>Search</button></div>");


//ajax Start

$("#loading").ajaxStart(function(){
var	width = $("body").width();
	width = (width/2)-20;
	hieght =18;

$(this).css({"top":hieght+"px","left":width}).show();
});
//ajax Stop
$("#loading").ajaxStop(function(){
$(this).hide();
});  
//search

var selectAuto = function(){
	$.ajax({
		url:'autoSelect.jsp',
		type:'get',
		dataType:'json',
		success:function(data){
			
		searchFunction(data[0]);
			
		}
	});
};
selectAuto();
var searchFunction  = function(paramDataSearAuto){
	$("#search1").kendoAutoComplete({
		dataSource: paramDataSearAuto,
	    filter: "startswith",
	    placeholder: "Select Job No...",
	    //separator: ", "
	});
};

//Management Dialog Box
//callAjaxProductionProgress("PRMX.jsp","#searchGrid",$("#selectDepartment").text());
//gridSearch Start
var gridSeach = function(argGridData){

	$("#searchGrid").kendoGrid({
		   
		theme:$(document).data("kendoSkin") || "black",
		 dataSource: {
				 data:argGridData
		
		 },
		   scrollable:true,
		
		
		    columns: [ {
		            field: "Item",
		            width:100,
		         
		            title: "<b>Item</b>"
		        },{
		            field:"StartingDate",
		            width:100,
		            
		            title:"<b>Start date</b>"
		            
		        },{
		            field: "JobNo",
		            width:100,
		
		            title: "<b>Job No</b>"
		        },{
		            field: "Detail",
		            width:100,
		       
		            title: "<b>Detail</b>"
		        },{
		            field: "PlanQty",
		            width:100,
		          
		            title: "<b>Plan Qty</b>"
		        }
		    ]
	});
	
	$("#searchGrid > .k-grid-content").css({"overflow-y":"show"});
	$("#dialogBox").css({"overflow-y":"hidden"});
	
	
	 // Get the current date at midnight.
    var now = new Date(); 
	var todayAtMidn = new Date(now.getFullYear(), now.getMonth(), now.getDate()-2,now.getHours(),now.getMinutes(),now.getSeconds());
	
	var numLoopColor=0;
	 $.each(argGridData,function(index,indexIntry){

   		var substringYMD1=indexIntry['StartingDate'].substring("0","4");
   		var substringYMD2=indexIntry['StartingDate'].substring("5","7");
   		var substringYMD3=indexIntry['StartingDate'].substring("8","10");

   		var substringHIS=indexIntry['StartingDate'].substring("11","19");
   		console.log("substringHIS= "+substringHIS);
   		var dateTimeDb=""+substringYMD1+"/"+substringYMD2+"/"+substringYMD3+" "+substringHIS;
   	  	var dateTimeDbUsing = new Date(dateTimeDb);
   	  	
   	  	
   	  	
   	  	
   		if (indexIntry['Status']==4)
			  {
   			$("#searchGrid table.k-focusable tbody tr:eq("+numLoopColor+")").css({"color":"#7cfc00"});
			  }
			  else if(todayAtMidn.getTime() >= dateTimeDbUsing.getTime())
			  {
				$("#searchGrid table.k-focusable tbody tr:eq("+numLoopColor+")").css({"color":"red"});
			  }else{
				$("#searchGrid table.k-focusable tbody tr:eq("+numLoopColor+")").css({"color":"white"});
			  }
  
   		numLoopColor++;
   		
   		
   	  });
	
};



//check condition define font color.

//gridSearch End


$("#submitSearh").click(function(){
	
	//Dialogbox alert grid result when click search submit
	$("#searchGrid").empty();
	callAjaxProductionProgress("production_progress.jsp","#searchGrid",$("#search1").val());
	
	$("#dialogBox").dialog({
		height: 450,
		width: 1300,
        modal: true,
        title:"ผลการค้นหา"
	}).hide();
	$(".ui-dialog-content").css({"padding":"0px"});
	$("#dialogBox").show(1000);

	
	
	/*
	$.ajax({
		url:'searchJob.jsp',
		type:'get',
		dataType:'json',
		data:{'paramSearch':$("#search1").val()},
		success:function(data){
			//alert(data);
			
			
			var gridData="[";
			   
			   var i=0;
			   $.each(data,function(index,intryIndex){
			    
				   
				  if(i==0){
					 gridData+="{";
				  }else{
					 gridData+=",{"; 
				  }
				  
				  gridData+="\"Item\":\""+intryIndex[1]+"\",";
				  gridData+="\"StartingDate\":\""+intryIndex[3]+"\",";
				  gridData+="\"JobNo\":\""+intryIndex[0]+"\",";
				  gridData+="\"Detail\":\""+intryIndex[2]+"\",";
				  gridData+="\"PlanQty\":\""+intryIndex[4]+"\",";
				  gridData+="\"Status\":\""+intryIndex[5]+"\"";
				  gridData+="}";
				  i++;
				  
				 
				 
          		
			   });
				gridData+="]";
			  var obj_gridData=eval("("+gridData+")");
                           $("#searchGrid").empty();
                        
			gridSeach(obj_gridData);
		
			
			//Dialogbox alert grid result when click search submit
			$("#dialogBox").dialog({
				height: 420,
				width: 800,
		        modal: true,
		        title:"ผลการค้นหา"
			});
			$(".ui-dialog-content").css({"padding":"0px"});
			$("#dialogBox").fadeIn();
			
			
			
		}
	});
	
	
	*/
	
});


});//jquery
