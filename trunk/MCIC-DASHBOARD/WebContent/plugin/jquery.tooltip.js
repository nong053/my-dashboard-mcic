jQuery.fn.tooltip = function(option){
	//alert("hello plugin");
	var optionDefault={
		//id:this.id,
		//txt:$(this).text(),
		txt:$("Empty String!"),
		color:"black"
	}
	var ex = jQuery.extend(optionDefault,option);

return	$(this).hover(function(e){
	alert(txt);
	},function(){
	$("#tootip").hide();
	});
	
}