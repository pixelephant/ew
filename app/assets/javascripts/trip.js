//= require jquery.fancybox.pack
//= require jquery.anystretch.min
//= require tablepag

$(document).ready(function(){

	$('#page-header').anystretch("http://dev.virtualearth.net/REST/V1/Imagery/Map/AerialWithLabels/space%20needle%20seattle?mapLayer=TrafficFlow&mapSize=900,260&zoomLevel=21&key=Av6Kw-8aShNgPZa-xG8X_Xt_m3uoVBSF4vfq21lymtZ7iYmYHxFVFO8svAUOThu5", {speed: 1000, positionY: "center"});

	 $('#additional-time table').tablePagination({
	 	rowsPerPage : 2,
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


	$.getJSON("http://www.panoramio.com/map/get_panoramas.php?set=public&from=0&to=6&miny=48.87933648812424&minx=2.2969794273376465&maxy=49.87933648812424&maxx=3.2969794273376465&size=square&mapfilter=true&callback=?",function(resp){
		$.each(resp.photos,function(i){
			$("#sights img").eq(i).attr("src",this.photo_file_url);
			$("#sights img").eq(i).parent().parent().attr("title",this.photo_title);
			$("#sights img").eq(i).parent().parent().attr("href", "http://static.panoramio.com/photos/original/"+this.photo_id+".jpg");
		});
	});

	$("#tablePagination_prevPage,#tablePagination_nextPage").click(function(){
		$('html,body').animate({scrollTop: $("#additional-time").offset().top},'slow');
	});

	//$("a.thumb").click(function(){
		//$(this).siblings().removeClass("active").removeClass("arrow_box").end().addClass("active").addClass("arrow_box");
		//return false;
	//});
});