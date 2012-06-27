// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui

function FormatNumberBy3(num, decpoint, sep) {
  // check for missing parameters and use defaults if so
  if (arguments.length == 2) {
    sep = ",";
  }
  if (arguments.length == 1) {
    sep = ",";
    decpoint = ".";
  }
  // need a string for operations
  num = num.toString();
  // separate the whole number and the fraction if possible
  a = num.split(decpoint);
  x = a[0]; // decimal
  y = a[1]; // fraction
  z = "";


  if (typeof(x) != "undefined") {
    // reverse the digits. regexp works from left to right.
    for (i=x.length-1;i>=0;i--)
      z += x.charAt(i);
    // add seperators. but undo the trailing one, if there
    z = z.replace(/(\d{3})/g, "$1" + sep);
    if (z.slice(-sep.length) == sep)
      z = z.slice(0, -sep.length);
    x = "";
    // reverse again to get back the number
    for (i=z.length-1;i>=0;i--)
      x += z.charAt(i);
    // add the fraction back in, if it was there
    if (typeof(y) != "undefined" && y.length > 0)
      x += decpoint + y;
  }
  return x;
}

jQuery(function($){
  $.datepicker.regional['hu'] = {
    closeText: 'bezár',
    prevText: 'vissza',
    nextText: 'előre',
    currentText: 'ma',
    monthNames: ['Január', 'Február', 'Március', 'Április', 'Május', 'Június',
    'Július', 'Augusztus', 'Szeptember', 'Október', 'November', 'December'],
    monthNamesShort: ['Jan', 'Feb', 'Már', 'Ápr', 'Máj', 'Jún',
    'Júl', 'Aug', 'Szep', 'Okt', 'Nov', 'Dec'],
    dayNames: ['Vasárnap', 'Hétfő', 'Kedd', 'Szerda', 'Csütörtök', 'Péntek', 'Szombat'],
    dayNamesShort: ['Vas', 'Hét', 'Ked', 'Sze', 'Csü', 'Pén', 'Szo'],
    dayNamesMin: ['V', 'H', 'K', 'Sze', 'Cs', 'P', 'Szo'],
    weekHeader: 'Hét',
    dateFormat: 'yy.mm.dd.',
    firstDay: 1,
    isRTL: false,
    showMonthAfterYear: true,
    yearSuffix: ''};
  $.datepicker.setDefaults($.datepicker.regional['hu']);
});


$(document).ready(function(){


  var dates = $( "#search_arrival, #search_departure" ).datepicker({
      changeMonth: true,
      changeYear: true,
      showButtonPanel: true,
      minDate: 1,
      dateFormat : "yy-mm-dd",
      defaultDate: "+1w",
      onSelect: function( selectedDate ) {
        var d1=new Date($("#search_arrival").val());
        var d2=new Date($('#search_departure').val());
        if($("#search_arrival").val() != '' && $('#search_departure').val() != ''){
          $('#search_between').html((Math.abs((d2-d1)/86400000)));
        }

        var option = this.id == "search_arrival" ? "minDate" : "maxDate",
          instance = $( this ).data( "datepicker" ),
          date = $.datepicker.parseDate(
            instance.settings.dateFormat ||
            $.datepicker._defaults.dateFormat,
            selectedDate, instance.settings );
        dates.not( this ).datepicker( "option", option, date );
      }
    });

  var dates1 = $( "#filters_arrival, #filters_departure" ).datepicker({
      changeMonth: true,
      changeYear: true,
      showButtonPanel: true,
      minDate: 0,
      dateFormat : "yy-mm-dd",
      defaultDate: "+1w",
      onSelect: function( selectedDate ) {
        var d1=new Date($("#filters_arrival").val());
        var d2=new Date($('#filters_departure').val());
        $('#filter-between').html((Math.abs((d2-d1)/86400000)));

        var option = this.id == "filters_arrival" ? "minDate" : "maxDate",
          instance = $( this ).data( "datepicker" ),
          date = $.datepicker.parseDate(
            instance.settings.dateFormat ||
            $.datepicker._defaults.dateFormat,
            selectedDate, instance.settings );
        dates.not( this ).datepicker( "option", option, date );
      }
    });



  $("#advanced-search :input,#advanced-search select").change(function(){
    var formData = $("#advanced-search").serialize();
    $.post("/ajax/search_estimate",{
      data : formData
    },function(resp){
      $("#estimate").html(resp.data);
    })
  });

  var searchHeight = $("#search").height();

	 $("#search-button").toggle(function(){
	 	$("#search").stop().animate({
	 		top:0,
      marginTop:0
	 	},"slow",function(){
	 		$("#inner-search").animate({
	 			opacity: 1
	 		});
	 	});
	 },function(){
	 	$("#inner-search").stop().animate({
	 		opacity: 0
	 	},"normal",function(){
	 		$("#search").animate({
        top:-searchHeight,
	 			marginTop:-searchHeight
	 		},"slow");
	 	});
	 });

	 /*$("input[type='range']").change(function(){
	 	var id = $(this).data("textbox");
	 	$("#" + id).val(FormatNumberBy3($(this).val(),"."," "));
	 });*/

   $("#search_no_date").change(function(){
      var checked = $(this).is(":checked");
      if(checked){
        $("#precise-row").slideUp("300",function(){
          $("#imprecise-row").slideDown();
        });
      }
      else{
        $("#imprecise-row").slideUp("300",function(){
          $("#precise-row").slideDown();
        });
      }
   });

   function init(){
      var checked = $("#search_no_date").is(":checked");
      if(checked){
        $("#precise-row").slideUp("300",function(){
          $("#imprecise-row").slideDown();
        });
      }
      else{
        $("#imprecise-row").slideUp("300",function(){
          $("#precise-row").slideDown();
        });
      }
   }

   init();

  $("#filters_country, #search_country").change(function(){
    $.ajax({
      type: 'POST',
      url: "/ajax/get_region",
      data: {id : $(this).val()},
      success: function(resp){
        if(resp.error == 'none'){
          options = '<option value="0">-- Mindegy --</option>';
          $.each(resp.region, function(){
            options += '<option value="' + this.id + '">' + this.name + '</option>';
          });
          $("#filters_region").html(options);
          $("#search_region").html(options);

          options = '<option value="0">-- Mindegy --</option>';
          $.each(resp.city, function(){
            options += '<option value="' + this.id + '">' + this.name + '</option>';
          });
          $("#filters_city").html(options);
          $("#search_city").html(options);
        }
    }});
    return false;
  });


  $("#filters_region, #search_region").change(function(){
    if(this.id == 'filters_region'){
      val = $("#filters_country").val();
    }else{
      val = $("#search_country").val();
    }
    $.ajax({
      type: 'POST',
      url: "/ajax/get_city",
      data: {id : $(this).val(), country_id : val},
      success: function(resp){
        if(resp.error == 'none'){
          options = '<option value="0">-- Mindegy --</option>';
          $.each(resp.data, function(){
            options += '<option value="' + this.id + '">' + this.name + '</option>';
          });
          $("#filters_city").html(options);
          $("#search_city").html(options);
        }
    }});
    return false;
  });




});