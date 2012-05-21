$(document).ready(function(){
	$("a.thumb").click(function(){
		$(this).siblings().removeClass("active").removeClass("arrow_box").end().addClass("active").addClass("arrow_box");
		return false;
	});
});