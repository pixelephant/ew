//= require jquery.anystretch.min

$(document).ready(function(){

$('#page-header').anystretch("assets/headers/europe.jpg", {speed: 1000, positionY: "center"});


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

$("#filters_country").change(function(){
  $.ajax({
    type: 'POST',
    url: "/ajax/get_region",
    data: {id : $(this).val()},
    success: function(resp){
      if(resp.error == 'none'){
        options = '<option value="0">-- Mindegy --</option>';
        $("#filters_city").html(options);
        $.each(resp.data, function(){
          options += '<option value="' + this.id + '">' + this.name + '</option>';
        });
        $("#filters_region").html(options);
      }
  }});
  return false;
});

$("#filters_region").change(function(){
  $.ajax({
    type: 'POST',
    url: "/ajax/get_city",
    data: {id : $(this).val()},
    success: function(resp){
      if(resp.error == 'none'){
        options = '<option value="0">-- Mindegy --</option>';
        $.each(resp.data, function(){
          options += '<option value="' + this.id + '">' + this.name + '</option>';
        });
        $("#filters_city").html(options);
      }
  }});
  return false;
});

});