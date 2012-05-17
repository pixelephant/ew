$(document).ready(function(){

$("#filter-no-date").change(function(){
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
  var boxes = $(this).parent().parent().next().find("input[type='checkbox']");

  if(checked){
    boxes.removeAttr("disabled");
  }
});

$(".all").change(function(){
  var checked = $(this).is(":checked");
  var boxes = $(this).parent().parent().next().next().find("input[type='checkbox']");
  if(checked){
    boxes.attr("disabled","disabled");
    boxes.attr("checked","checked");
  }
});

$(".collapsible a").toggle(function(){
  $(this).parent().next().slideDown();
},function(){
  $(this).parent().next().slideUp();
});

$("#totop").click(function(){
   $('html,body').animate({scrollTop: $("#pagi-t").offset().top},'slow');
   return false;
});

});