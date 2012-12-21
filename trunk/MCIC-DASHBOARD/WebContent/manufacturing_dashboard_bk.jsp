<html>
<head>
    <style>
   table.k-focusable{
    position:absolute;
    }
   
    #loading{
        display: none;
        position:absolute;
        z-index:10000;
    }
    .k-grid-content{
        overflow-y:hidden;
    }
    #selectDepartment{
    	display:none;
    }
    .greenColor{
    	color:#7cfc00;
    }
    .redColor{
    	color:red;
    }
    #dialogBox{
    	display:none;
    }
    #searchArea{
    float:right;
    padding:5px;
    }
    #jobload{
    display:inline;
    }
    #jobComplete{
    display:inline;
    }
   
    </style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="css/ui-darkness/jquery-ui-1.8.23.custom.css"  type="text/css" rel="stylesheet">
<link href="css/manufacturing_dashboard.css" type="text/css" rel="stylesheet" >
<link href="kendo/styles/kendo.default.min.css" type="text/css" rel="stylesheet" >
<link href="kendo/styles/kendo.black.min.css" type="text/css" rel="stylesheet" >
<link href="kendo/styles/kendo.common.min.css" rel="stylesheet" type="text/css">

<link rel="stylesheet" href="css/style.css" />
        <link rel="stylesheet" href="http://twitter.github.com/bootstrap/assets/css/bootstrap.css" />
        <link rel="stylesheet" href="http://taitems.github.com/UX-Lab/core/css/prettify.css" />
		<style type="text/css">
			body {
				font-family: Helvetica, Arial, sans-serif;
				font-size: 13px;
				padding: 0 0 50px 0;
			}
			.contain {
				width: 800px;
				margin: 0 auto;
			}
			h1 {
				margin: 40px 0 20px 0;
			}
			h2 {
				font-size: 1.5em;
				padding-bottom: 3px;
				border-bottom: 1px solid #DDD;
				margin-top: 50px;
				margin-bottom: 25px;
			}
			table th:first-child {
				width: 150px;
			}
		</style>
		
		
<!-- <script src="js/jquery-1.8.0.min.js"></script>-->
<script src="http://code.jquery.com/jquery-1.7.2.min.js"></script>
<script src="kendo/js/kendo.all.min.js"></script>
<script src="js/jquery-ui-1.8.23.custom.min.js"></script>
<script type="text/javascript" src="dev_js/manufacturing_dashboard.js"></script>

	<script src="js/jquery.fn.gantt.js"></script>
	<script src="http://twitter.github.com/bootstrap/assets/js/bootstrap-tooltip.js"></script>
	<script src="http://twitter.github.com/bootstrap/assets/js/bootstrap-popover.js"></script>
	<script src="http://taitems.github.com/UX-Lab/core/js/prettify.js"></script>
    <script>
    
    //function convert date to timestamp
    //date:12-11-2012 20:16:01
    //timestamp:1352726161000
    
    //date:13-11-2012 20:16:01
    //timestamp:1352726161000
    
    //date:14-11-2012 20:16:01
    //timestamp:1352898961000
    
    //date:15-11-2012 20:16:01
    //timestamp:1352985361000
    
    //date:16-11-2012 20:16:01
    //timestamp:1353071761000
    
    //date:17-11-2012 20:16:01
    //timestamp:1353158161000
    
    //date:18-11-2012 20:16:01
    //timestamp:1353244561000
    
    //date:18-12-2012 20:16:01
    //timestamp:1355836561000
    
    
    var myDate="14-11-2012 20:16:01";
    myDate=myDate.split("-");
    var newDate=myDate[1]+"/"+myDate[0]+"/"+myDate[2];
    //alert(new Date(newDate).getTime());
    
   
    $(document).ready(function(){
    	$(".date").kendoDatePicker();
    	$(".listSelect").kendoDropDownList();
    	
    });

		$(function() {

			"use strict";

			$(".gantt").gantt({
				source: [{
					name: "Machine1",
					desc: "&nbsp;",
					values: [{
						from: "/Date(1352726161000)/",
						to: "/Date(1355836561000)/",
						label: "Machine1", 
						customClass: "ganttYellow",

					},{
						from: "/Date(1352726161000)/",
						to: "/Date(1352898961000)/",
						label: "", 
						customClass: "ganttGreen",

					}]
				},{
					name: " ",
					desc: "&nbsp;",
					values: [{
						from: "/Date(1352726161000)/",
						to: "/Date(1352898961000)/",
						label: "Job3", 
						customClass: "ganttYellow"
					}]
				},{
					name: " ",
					desc: "&nbsp;",
					values: [{
						from: "/Date(1352726161000)/",
						to: "/Date(1352898961000)/",
						label: "Job33", 
						customClass: "ganttYellow"
					}]
				},{
					name: " ",
					desc: "&nbsp;",
					values: [{
						from: "/Date(1352726161000)/",
						to: "/Date(1352898961000)/",
						label: "Job34", 
						customClass: "ganttYellow"
					}]
				},{
					name: " ",
					desc: "&nbsp;",
					values: [{
						from: "/Date(1352726161000)/",
						to: "/Date(1352898961000)/",
						label: "Job35", 
						customClass: "ganttYellow"
					}]
				},{
					name: " ",
					desc: "&nbsp;",
					values: [{
						from: "/Date(1352985361000)/",
						to: "/Date(1355836561000)/",
						label: "Job4", 
						customClass: "ganttYellow"
					}]
				},{
					name: "Machine2",
					desc: "&nbsp;",
					values: [{
						from: "/Date(1352726161000)/",
						to: "/Date(1353244561000)/",
						label: "Machine2", 
						customClass: "ganttYellow"
					},{
						from: "/Date(1352726161000)/",
						to: "/Date(1352726161000)/",
						label: "", 
						customClass: "ganttGreen",

					}]
				},{
					name: "",
					desc: "&nbsp;",
					values: [{
						from: "/Date(1352726161000)/",
						to: "/Date(1352726161000)/",
						label: "Job1", 
						customClass: "ganttYellow"
					}]
				},{
					name: "",
					desc: "&nbsp;",
					values: [{
						from: "/Date(1352726161000)/",
						to: "/Date(1352726161000)/",
						label: "Job11", 
						customClass: "ganttYellow"
					}]
				},{
					name: "",
					desc: "&nbsp;",
					values: [{
						from: "/Date(1352726161000)/",
						to: "/Date(1352726161000)/",
						label: "Job12", 
						customClass: "ganttYellow"
					}]
				},{
					name: "",
					desc: "&nbsp;",
					values: [{
						from: "/Date(1352898961000)/",
						to: "/Date(1353158161000)/",
						label: "Job2", 
						customClass: "ganttYellow"
					}]
				},{
					name: "",
					desc: "&nbsp;",
					values: [{
						from: "/Date(1352726161000)/",
						to: "/Date(1352898961000)/",
						label: "Job21", 
						customClass: "ganttYellow"
					}]
				},{
					name: " ",
					desc: "&nbsp;",
					values: [{
						from: "/Date(1352985361000)/",
						to: "/Date(1353158161000)/",
						label: "Job22", 
						customClass: "ganttYellow"
					}]
				}],
				navigate: "scroll",
				scale: "days",
				maxScale: "months",
				minScale: "days",
				itemsPerPage: 20,
				onItemClick: function(data) {
					alert("Item clicked - show some details");
				},
				onAddClick: function(dt, rowId) {
					alert("Empty space clicked - add an item!");
				}
			});

			$(".gantt").popover({
				selector: ".bar",
				title: "I'm a popover",
				content: "And I'm the content of said popover."
			});

			prettyPrint();
			
			//manage manual
			var html="";
			html+="<table id='headerTable' width='100%'><tr><td width='80'><b>Machine</b></td><td width='100'><b>Job</b></td><td width='100'><b>Sub Job</b></td><td><b>Plan Qty</b></td><td><b>Actual Qty</b></td></tr></table>";
			setTimeout(function(){
		    $(".leftPanel div.spacer").html(html);
		    $("#headerTable").css({"margin-top":"73px","margin-left":"","font-size":"13px"});
		    $("#RowdId_1")
		    .html("<table class='contentTable' width='100%'><tr><td width='120'>job3</td><td width='120'></td><td width='90'>100</td><td>80</td></tr></table>");
		    $("#RowdId_2")
		    .html("<table class='contentTable' width='100%'><tr><td width='120'>job4</td><td width='120'></td><td width='90'>100</td><td>90</td></tr></table>");
		    
		    $("#RowdId_4")
		    .html("<table class='contentTable' width='100%'><tr><td width='120'>job1</td><td width='120'></td><td width='90'>100</td><td>90</td></tr></table>");
		    $("#RowdId_5")
		    .html("<table class='contentTable' width='100%'><tr><td width='120'></td><td width='120'>job11</td><td width='90'>100</td><td>90</td></tr></table>");
		    $("#RowdId_6")
		    .html("<table class='contentTable' width='100%'><tr><td width='120'></td><td width='120'>job12</td><td width='90'>100</td><td>90</td></tr></table>");
		    $("#RowdId_7")
		    .html("<table class='contentTable' width='100%'><tr><td width='120'>job2</td><td width='120'></td><td width='90'>100</td><td>90</td></tr></table>");
		    $("#RowdId_8")
		    .html("<table class='contentTable' width='100%'><tr><td width='120'></td><td width='120'>job21</td><td width='90'>100</td><td>90</td></tr></table>");
		    $("#RowdId_9")
		    .html("<table class='contentTable' width='100%'><tr><td width='120'></td><td width='120'>job22</td><td width='90'>100</td><td>90</td></tr></table>");
		    
		    //management table header
		    $("table#headerTable tr").css({"border-top":"1px solid #cccccc"});
		    $("table#headerTable tr td:eq(0)").css({"padding-left":"5px"});
		    
		    //management table content
		    $("table.contentTable").css({"font-family":"Tahoma","font-size":"13px"});
			},1000);
			
			
			
			
			$.ajax({
				url:'manufacturing_dashboard.jsp',
				type:'get',
				dataType:'json',
				cache:false,
				success:function(data){
					//alert(data);
					$.each(data,function(intry,indexIntry){
						console.log(indexIntry[1]);
					});
				}
			});
		});

    
    </script>

<title>Manufacturing Dashboard</title>
</head>
<body>
<div id="selectDepartment"></div>
<div id="dialogBox" title="ผลการค้นหา">
	<div id="searchGrid" style="height: 390px"></div>
</div>

<div id="loading">Loading....</div>
<div id="body">
	<div id="tabs">
		<ul>
			<li>
				<a href="#content1">Manufacturing Dashboard</a>
			</li>
			
		</ul>
		<div id="content1">
		<div id="plantArea" style="padding:5px;">

			<b>Machine</b> : <select name="plant" id="plant" class="listSelect">
			
			<option value=''>All-Machine</option>
			
			<option>Machine1</option>
			<option>Machine2</option>
			
			</select>
			<!-- from date area-->
			<b>Month From</b> : <input type="text" id="from_date" name="from_date" class="date" value=''>
			<!-- to date area -->
			<b>Month To</b> : <input type="text" id="to_date" name="to_date" class="date" value=''>
			<!-- department area -->
			<b>Year</b> : <input type="text" id="year" name="year" class="date" value=''>
			
			<!-- search area -->
			<!--  
	        <b> Search: </b><input type="text" name="search1" id="search1"/>
	        <input type="submit" id="submit1" name="submit1" value="ค้นหา"/>
	        -->
	        <button id="submit1"> &nbsp; OK  &nbsp;</button>
		</div>
				<!-- Dash board Content-->
				<div id="content">
				
				<!-- box-->
					<div class="box">
						<div class="head">
							<div class="title">
							
							</div>
                                                        <div class="percen-work-load">
                                                        <div id="jobload">
                                                         Work Load: <span id="jobLoadResult"></span> Jobs(<span id="jobLoadPercentage" class="redColor">--%</span>)
                                                         </div>
                                                         
                                                         <div id="jobComplete">
                                                         Work Complete: <span id="jobcompeleteResult"></span> Jobs(<span id="jobCompletePercentage" class="greenColor">--%</span>)
                                                         </div>
                                                        
                                                        </div>
                                                        <div id="select_veiw" id="select_veiw">
                                                        <b>View</b>:
                                                        <select>
                                                        	<option>Months</option>
                                                        	<option>Weeks</option>
                                                        	<option>Days</option>
                                                        	<option>Hours</option>
                                                        </select>
                                                        </div>
						</div>
						<div class="content">
						<!-- schedule plan machine -->
						   <div class="gantt"></div>
						<!-- schedule plan machine-->
							
						</div>
					</div>
				<!-- box-->

				</div>
				<!-- content1-->
				<!-- Dash board Content-->
				<br style="clear:both">
				
			</div>
			
				
	</div>
	
</div>
      
</body>
</html>