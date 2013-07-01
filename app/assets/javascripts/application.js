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
//= require twitter/bootstrap
//= require_tree .
$(window).load(function(){
 $('.containerer').find('img').each(function(){
  var imgClass = (this.width/this.height > 1) ? 'wide' : 'tall';
  $(this).addClass(imgClass);
 });

 var colors = new Array();
 colors[0] = "#cb4c5c";
 colors[1] = "#b19d43";
 colors[2] = "#03ad9d";
 colors[3] = "#3d4f92";
 var counter = 0;

 $('.color_handle').each(function(){
 	this.style.backgroundColor = colors[counter];
 	counter=counter+1;
 });

	$('#profile_link').click(function(){
		window.location.replace("/users");
	});
	$('#trips_link').click(function(){
		window.location.replace("/trips");
	});
})