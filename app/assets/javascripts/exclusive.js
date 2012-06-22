//= require jquery.anystretch.min

$(document).ready(function(){

$('#page-header').anystretch($("#page-header-inner").data("image"), {speed: 1000, positionY: "center"});

});