//= require jquery.anystretch.min

$(document).ready(function(){

$('#page-header').anystretch("assets/headers/europe.jpg", {speed: 1000, positionY: "center"});

$("#more-countries").toggle(function(){
 $(this).find("span").html("&#9650;");
 $("#other-countries").slideDown();
},function(){
 $(this).find("span").html("&#9660;");
 $("#other-countries").slideUp();
})

$("#filters_no_date").change(function(){
      var checked = $(this).is(":checked");
      if(checked){
        $("#filter-precise-row").slideUp("300",function(){
          $("#filter-imprecise-row").slideDown();
        });
      }
      else{
        $("#filter-imprecise-row").slideUp("300",function(){
          $("#filter-precise-row").slideDown();
        });
      }
   });

$(".only").change(function(){
  var checked = $(this).is(":checked");
  var boxes = $(this).parent().parent().find("input[type='checkbox']");
  if(checked){
    boxes.removeAttr("disabled");
  }
});

$(".all").change(function(){
  var checked = $(this).is(":checked");
  var boxes = $(this).parent().parent().find("input[type='checkbox']");
  if(checked){
    boxes.attr("disabled","disabled");
    boxes.attr("checked","checked");
  }
});

$(".collapsible a").toggle(function(){
  $(this).parent().next().slideDown();
  $(this).html("&uarr;")
},function(){
  $(this).parent().next().slideUp();
  $(this).html("&darr;")
});

$("#totop").click(function(){
   $('html,body').animate({scrollTop: $("#pagi-t").offset().top},'slow');
   return false;
});

});