    
$(document).ready(function(){
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
				//call ajax for dashboard by department
				$("select#plant").live("change",function(){
					$("#selectDepartment").html(this.value);
					//numDown==0 mean program must load new data
					numDown1=0;
					numDown2=0;
					numDown3=0;
					numDown4=0;
					callAjaxAndSort();
					sortSlide();
				
					
				});
				
		}
	});

	
//กำหนดภาพเลื่อน
var numDown1=0;
var numDown2=0;
var numDown3=0;
var numDown4=0;
var $i=0;
var $j=0;
var $k=0;
var $l=0;


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
        
        }
  
        
    },5000);
};

var dataSlideDown1=function(numDown){   
    
    var $hieght = $("#grid1 table.k-focusable").height();
    
    if(numDown>-$hieght){
        $("#grid1 table.k-focusable").animate({"top":numDown});
    }else{
        $("#grid1 table.k-focusable").css({"top":"0px"});
        $j=0; 
        numDown1=0;
        callAjaxByDepartment("PRMX.jsp","#grid1",$("#selectDepartment").text());
    }
};
//ฟังก์ชันจัดการในส่วนของกำหนดควบคุมข้อมูลส slide End1

//ฟังก์ชันจัดการในส่วนของกำหนดควบคุมข้อมูลส slide Start2
var defineTimeSlide2=function(){
   setTimeout(function(){
        var $numTR = $("#grid2 table.k-focusable tbody tr").length;
        
        if( $k< $numTR){
        var $hieghtTR = $("#grid2 table.k-focusable tbody tr:eq("+$k+")").height();
       // alert($hieghtTR);
        console.log($hieghtTR);
        console.log($k);
        numDown2+=-$hieghtTR;
        dataSlideDown2(numDown2);
        //console.log("call method1"+numDown1);
        defineTimeSlide2();
        $k++;
        
        }
        
    },5000);
};


var dataSlideDown2=function(numDown){
    var $hieght = $("#grid2 table.k-focusable").height();
    if(numDown>-$hieght){
        $("#grid2 table.k-focusable").animate({"top":numDown});
    }else{
        $("#grid2 table.k-focusable").css({"top":"0px"});
        numDown2=0;
        $k=0;;
        callAjaxByDepartment("M5N7.jsp","#grid2",$("#selectDepartment").text());
    }
};
//ฟังก์ชันจัดการในส่วนของกำหนดควบคุมข้อมูลส slide End2
//ฟังก์ชันจัดการในส่วนของกำหนดควบคุมข้อมูลส slide Start3
var defineTimeSlide3=function(){
    setTimeout(function(){
        var $numTR = $("#grid3 table.k-focusable tbody tr").length;
        if( $l < $numTR ){
        var $hieghtTR = $("#grid3 table.k-focusable tbody tr:eq("+$l+")").height();
        console.log($hieghtTR);
        console.log($l);
        numDown3+=-$hieghtTR;
        dataSlideDown3(numDown3);
        //console.log("call method1"+numDown1);
        defineTimeSlide3();
        $l++;
        
        }
        
    },5000);
};

var dataSlideDown3=function(numDown){
    var $hieght = $("#grid3 table.k-focusable").height();
    if(numDown>-$hieght){
        $("#grid3 table.k-focusable").animate({"top":numDown});
    }else{
        $("#grid3 table.k-focusable").css({"top":"0px"});
        numDown3=0;
        $l=0; 
        callAjaxByDepartment("FRMX.jsp","#grid3",$("#selectDepartment").text());
    }
};
//ฟังก์ชันจัดการในส่วนของกำหนดควบคุมข้อมูลส slide End3
//ฟังก์ชันจัดการในส่วนของกำหนดควบคุมข้อมูลส slide Start4
var defineTimeSlide4=function(){
    
    setTimeout(function(){
        var $numTR = $("#grid4 table.k-focusable tbody tr").length;
        if( $i < $numTR ){
        var $hieghtTR = $("#grid4 table.k-focusable tbody tr:eq("+$i+")").height();
        numDown4+=-$hieghtTR;
        $i++;
        }
       
        dataSlideDown4(numDown4);
        //console.log("call method4"+numDown4);
        defineTimeSlide4();
        
    },5000);
};

var dataSlideDown4=function(numDown){
var $hieght = $("#grid4 table.k-focusable").height();

    if(numDown> -$hieght){
        $("#grid4 table.k-focusable").animate({"top":numDown});
    }else{
        $("#grid4 table.k-focusable").css({"top":"0px"});
       
        numDown4=0;
        $i=0;  
        callAjaxByDepartment("APKX.jsp","#grid4",$("#selectDepartment").text());
    }
};
//ฟังก์ชันจัดการในส่วนของกำหนดควบคุมข้อมูลส slide End4




//define function grid

var grid = function(gridName,gridData){
	
 $(gridName).kendoGrid({
                        /*dataSource: {
                            data: createRandomData(50),
                            pageSize: 10
                        },*/
					theme:$(document).data("kendoSkin") || "black",
					 dataSource: {
							 data:gridData
						 
						 //pageSize: 500
					 },

                       //groupable: true,
                       //sortable: true,
                       scrollable:true,
			/* pageable: {
                            refresh: true,
                            pageSizes: 10
                        },*/
            
                        columns: [ {
                                field: "Item",
                                width:100,
                             
                                title: "<b>Item</b>"
                            },{
                                field:"StartingDate",
                                width:100,
                                
                                title:"<b>Start date</b>"
                                
                            },{
                                field: "JobNo_Detail",
                                width:230,
                   
                                title: "<b>JobNo/Detail</b>"
                            },{
                                field: "PlanQty",
                                width:100,
                              
                                title: "<b>Plan Qty</b>"
                            }
                        ]
                    });
              $("#grid1 >.k-grid-content").css({"overflow-y":"hidden"});
              $("#grid2 >.k-grid-content").css({"overflow-y":"hidden"});
              $("#grid3 >.k-grid-content").css({"overflow-y":"hidden"});
              $("#grid4 >.k-grid-content").css({"overflow-y":"hidden"});
              
              $("#grid1 tbody tr").each(function(){
            	 $("td:eq(3)",this).css({"text-align":"right"}); 
              });
              $("#grid2 tbody tr").each(function(){
             	 $("td:eq(3)",this).css({"text-align":"right"}); 
               });
              $("#grid3 tbody tr").each(function(){
             	 $("td:eq(3)",this).css({"text-align":"right"}); 
               });
              $("#grid4 tbody tr").each(function(){
             	 $("td:eq(3)",this).css({"text-align":"right"}); 
               });
              //check condition define font color.
           
              
              // Get the current date at midnight.
              var now = new Date(); 
			  var todayAtMidn = new Date(now.getFullYear(), now.getMonth(), now.getDate()-2,now.getHours(),now.getMinutes(),now.getSeconds());
			  
			
			//Output: Different
			var numLoopColor =0;
			var numJobReleased1 =0;
			var numJobReleased2 =0;
			var numJobReleased3 =0;
			var numJobReleased4 =0;
              $.each(gridData,function(index,indexIntry){

          		var substringYMD1=indexIntry['StartingDate'].substring("0","4");
          		var substringYMD2=indexIntry['StartingDate'].substring("5","7");
          		var substringYMD3=indexIntry['StartingDate'].substring("8","10");
  
          		var substringHIS=indexIntry['StartingDate'].substring("11","19");
          		console.log("substringHIS= "+substringHIS);
          		var dateTimeDb=""+substringYMD1+"/"+substringYMD2+"/"+substringYMD3+" "+substringHIS;
          	  	var dateTimeDbUsing = new Date(dateTimeDb);
          	  	
          	  	
          	  	console.log("dateTimeDbUsing"+dateTimeDbUsing);
          	  	console.log("Status"+indexIntry['Status']);
          	  	if((indexIntry['Status']==3) && (gridName=="#grid1")){
          	    numJobReleased1++;
          	  	}else if((indexIntry['Status']==3) && (gridName=="#grid2")){
          	  	numJobReleased2++;	
          	  	}else if((indexIntry['Status']==3) && (gridName=="#grid3")){
          	  	numJobReleased3++;		
          	  	}else if((indexIntry['Status']==3) && (gridName=="#grid4")){
          	  	numJobReleased4++;		
          	  	}
          	  	
          		if (indexIntry['Status']==4)
	  			  {
          			$(""+gridName+" table.k-focusable tbody tr:eq("+numLoopColor+")").css({"color":"#7cfc00"});
	  			  }
	  			  else if(todayAtMidn.getTime() >= dateTimeDbUsing.getTime())
	  			  {
	  				
	  				$(""+gridName+" table.k-focusable tbody tr:eq("+numLoopColor+")").css({"color":"red"});
	  			  }else{
	  				$(""+gridName+" table.k-focusable tbody tr:eq("+numLoopColor+")").css({"color":"white"});
	  			  }
         
          		numLoopColor++;
          		
          		
          	  });
              
              if(gridName=="#grid1"){
            	  
                  $("#jobLoadPrmx").html(numJobReleased1);
                  
            	  numJobReleased1 =0; 
              }else if(gridName=="#grid2"){
            	 
                  $("#jobLoadM5n7").html(numJobReleased2);
            	  numJobReleased2 =0; 
              }else if(gridName=="#grid3"){
            	 
                  $("#jobLoadFrmx").html(numJobReleased3);
            	  numJobReleased3 =0; 
              }else if(gridName=="#grid4"){
            	 
                  $("#jobLoadApkx").html(numJobReleased4);
            	  numJobReleased4 =0; 
              }
              
              var sumJobload = function(){
            	
            	  var jobload1 =parseInt($("#jobLoadPrmx").text());
            	  var jobload2 =parseInt($("#jobLoadM5n7").text());
            	  var jobload3 =parseInt($("#jobLoadFrmx").text());
            	  var jobload4 =parseInt($("#jobLoadApkx").text());
            	  var sumjob=(jobload1+jobload2+jobload3+jobload4);
            	  return sumjob;
              };
              
              //think is percentage of department. 
              var PercentageWorkLoad=function(element){
            	  var jobLoadPrmx=parseInt($(element).text());
                  var sumJobload1=sumJobload();
                  var jobLoadPrmxPercentage = ((jobLoadPrmx/sumJobload1)*100).toFixed(2);  
                  return jobLoadPrmxPercentage;
              };
              
              //(""+jobLoadPrmx/sumJobload)*100+"%"
              $("#jobLoadPrmxPercentage").html(""+PercentageWorkLoad("#jobLoadPrmx")+"%");
              $("#jobLoadApkxPercentage").html(""+PercentageWorkLoad("#jobLoadApkx")+"%");
              $("#jobLoadM5n7Percentage").html(""+PercentageWorkLoad("#jobLoadM5n7")+"%");
              $("#jobLoadFrmxPercentage").html(""+PercentageWorkLoad("#jobLoadFrmx")+"%");
              
              //alert(sumJobload());
              
              numLoopColor=0;
              
              	console.log("numLoopColor external"+numLoopColor);
              	
              
             // $("#grid1 table.k-focusable tbody tr").css({"color":"red"});
              
              
//grid1
};

//call function grid
//เรียก functionในการสร้าง content ในรูปแบบ json สำหรับ ตาราง grid
var callAjaxByDepartment=function(paramUrl,paramNameGrid,paramDepartment){
		$.ajax({
			   url:paramUrl,
			   //url:'PRMX.jsp'
			   dataType:'json',
			   data:{'paramdepartment':paramDepartment},
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
					  
					  gridData+="\"Item\":\""+intryIndex[1]+"\",";
					  gridData+="\"StartingDate\":\""+intryIndex[2]+"\",";
					  gridData+="\"JobNo_Detail\":\""+intryIndex[0]+"\",";
					  gridData+="\"PlanQty\":\""+intryIndex[3]+"\",";
					  gridData+="\"Status\":\""+intryIndex[4]+"\"";
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

};//callAjaxByDepartment



//Call function for run data content of  Department
var callAjaxAndSort = function(){
	callAjaxByDepartment("PRMX.jsp","#grid1",$("#selectDepartment").text());
	callAjaxByDepartment("M5N7.jsp","#grid2",$("#selectDepartment").text());
	callAjaxByDepartment("FRMX.jsp","#grid3",$("#selectDepartment").text());
	callAjaxByDepartment("APKX.jsp","#grid4",$("#selectDepartment").text());
};
//call ajaxAndSort on ready load dom 
callAjaxAndSort();

	//ลำดับการแสดงผล
var sortSlide = function(){	
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
};
sortSlide();



//config grid template
$(".k-grid td").css({"padding-top":"0px","padding-bottom":"0px"});
$("body").css("background","black");
//jqueyUi tabs
$("#tabs").tabs();



//ajax Start

$("#loading").ajaxStart(function(){
var	width = $("body").width();
	width = (width/2)-20;
	hieght =55;

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
//callAjaxByDepartment("PRMX.jsp","#searchGrid",$("#selectDepartment").text());
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
               field: "JobNo_Detail",
               width:230,
  
               title: "<b>JobNo/Detail</b>"
           },{
               field: "PlanQty",
               width:100,
               title: "<b>Plan Qty</b>"
           },{
               field: "Dept",
               width:80,
               title: "<b>Dept</b>"
           }
       ]
	});
	
	$("#searchGrid tbody tr").each(function(){
   	 $("td:eq(3)",this).css({"text-align":"right"}); 
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
$("#submit1").click(function(){
	//alert($("#search1").val());
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
				  gridData+="\"StartingDate\":\""+intryIndex[2]+"\",";
				  gridData+="\"JobNo_Detail\":\""+intryIndex[0]+"\",";
				  gridData+="\"PlanQty\":\""+intryIndex[3]+"\",";
				  gridData+="\"Status\":\""+intryIndex[4]+"\",";
				  gridData+="\"Dept\":\""+intryIndex[5]+"\"";
				  gridData+="}";
				  i++;
				  
				 
				 
          		
			   });
				gridData+="]";
			  var obj_gridData=eval("("+gridData+")");
                           $("#searchGrid").empty();
                        
			
			//alert(obj_gridData);
			//Dialogbox alert grid result when click search submit
			
			$("#dialogBox").dialog({
				height: 455,
				width: 800,
		        modal: true,
		        title:"ผลการค้นหา"
			});
			$(".ui-dialog-content").css({"padding":"0px"});
			$("#dialogBox").fadeIn();
			
			gridSeach(obj_gridData);
			
			
		}
	});
	
	
	
});


});//jquery
