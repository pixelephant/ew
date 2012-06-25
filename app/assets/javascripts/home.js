//= require jquery.anystretch.min

//= require jquery.cycle.min

$(document).ready(function(){

	var images = [];

	$(".slide").each(function(){
		images.push($(this).data("background"));
	})

	$(images).each(function(){
    	$("<img/>")[0].src = this; 
  	});

	 $('#promo-slider').anystretch(images[0], {speed: 1000, positionY: "center"});
	 	
	 	$('#slide-wrap').cycle({
	 		fx : "fade",
	 		slideExpr: ".slide",
	 		pause: true,
	 		speed : 1000,
	 		timeout: 4000,
	 		next:   '#next-slide', 
    		prev:   '#prev-slide',
	 		before : function(curr, next, opts){
	 			$('#promo-slider').anystretch($(next).data("background"), {speed: 1000, positionY: "center"});
	 		}
	 	});	 

});