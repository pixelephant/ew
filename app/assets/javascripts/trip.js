//= require jquery.fancybox.pack
//= require tablepag

$(document).ready(function(){

	 $('#additional-time table').tablePagination({
	 	rowsPerPage : 5,
	 	firstArrow : (new Image()).src="/assets/first.png",
        prevArrow : (new Image()).src="/assets/prev.png",
		lastArrow : (new Image()).src="/assets/last.png",
		nextArrow : (new Image()).src="/assets/next.png",
		optionsForRows : [5,10,20]
	 });

	$(".fancybox").fancybox({
	    fitToView : true,
	    autoSize  : true,
	    closeClick  : true,
	    openEffect  : 'elastic',
	    closeEffect : 'elastic'
  	});

	var minx= parseFloat($("#content").data("positionx"))-1;
	var maxx= parseFloat($("#content").data("positionx"))+1;

	var miny= parseFloat($("#content").data("positiony"))-1;
	var maxy= parseFloat($("#content").data("positiony"))+1;

	if(isNan(minx)){
		$("#sights").hide();
	}
	else{
		$.getJSON("http://www.panoramio.com/map/get_panoramas.php?set=public&from=0&to=6&miny="+miny+"&minx="+minx+"&maxy="+maxy+"&maxx="+maxx+"&size=square&mapfilter=true&callback=?",function(resp){
		$.each(resp.photos,function(i){
			$("#sights img").eq(i).attr("src",this.photo_file_url);
			$("#sights img").eq(i).parent().parent().attr("title",this.photo_title);
			$("#sights img").eq(i).parent().parent().attr("href", "http://static.panoramio.com/photos/original/"+this.photo_id+".jpg");
		});
	});
	}

	$("#tablePagination_prevPage,#tablePagination_nextPage").click(function(){
		$('html,body').animate({scrollTop: $("#additional-time").offset().top},'slow');
	});

});