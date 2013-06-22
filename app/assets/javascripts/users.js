$(document).ready(function() {
	// Assign On Change event to the image_url text field
	
	$("#image_url_text_field").change(function(){
		
		var image_url = $("#image_url_text_field").val();
		
		if(validateURL(image_url)){
		
		$("#image_preview").empty();
		$("#image_preview").append("<a href=\"" + image_url + "\" target=\"_BLANK\"><img src=\"" + image_url + "\" border=0 height=60px width=60px></a>");
	}else{
		$("#image_preview").empty();
		$("#image_preview").append("<img src=\"/assets/no_image.png\" border=0 height=60px width=60px>");
		//alert("La URL de imagen no es válida!");
	}
	}
		);

});

function validateURL(textval) {
      var urlregex = new RegExp(
            "^(http|https|ftp)\://([a-zA-Z0-9\.\-]+(\:[a-zA-Z0-9\.&amp;%\$\-]+)*@)*((25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])|([a-zA-Z0-9\-]+\.)*[a-zA-Z0-9\-]+\.(com|edu|gov|int|mil|net|org|biz|arpa|info|name|pro|aero|coop|museum|[a-zA-Z]{2}))(\:[0-9]+)*(/($|[a-zA-Z0-9\.\,\?\'\\\+&amp;%\$#\=~_\-]+))*$");
      return urlregex.test(textval);
    }
    