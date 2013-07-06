$(document).ready( function(){
	$("#invitation_name").keyup(textEntered);
	$("#invites_selected").on("click",".users_suggested_row",suggestionClicked);
	$("#invite_list").on("click",".red_cross_link",removeFromInvitationList);
});

function textEntered(){
	if ($("#invitation_name").val() == ""){
		$("#invites_selected").hide();
	}else{
	$.ajax({
        type: 'POST',
        url: "/users/match/" + $("#invitation_name").val() + ".json",
		data: $("#invitation_name").val(),
        success: textEnteredCallback
    });
}
}

function searchPlaces(){
	if (!($("#search_bar").val() == "")) {
		$.ajax({
        type: 'POST',
        url: "/places/search/" + $("#search_bar").val() + ".json",
		data: $("#search_bar").val(),
        success: searchPlacesCallback
    });
	}
}

function placeAddedToTrip(data){
	alert("Place Added" + data);
}

function placeDeletedFromTrip(data){
	alert("Place Deleted" + data);
}

function textEnteredCallback(data){
	
	$("#invites_selected").html(data.html);
	$("#invite_list").children().each(function(){
		var row = $(this);
		$("#invites_selected").children().children().each(function(){
			if (row.attr("user_id") == $(this).attr("user_id")){
				$(this).remove();
			}
		});
		
	});
		$(".invited_users").each(function(){
			var row = $(this);
			$("#invites_selected").children().children().each(function(){
				if (row.attr("user_id") == $(this).attr("user_id")){
					$(this).remove();
				}
			});

		});
	$("#invites_selected").show();
}

function suggestionClicked(){
	$(this).removeClass("users_suggested_row");
	$(this).append('<input id="invited_" name="invited[]" type="hidden" value="'+$(this).attr("user_id")+'">');
	$(this).append('<a href="#" id="'+ $(this).attr("user_id") +'" class="red_cross_link"><img alt="Redcross" src="/assets/redCross.png"></a>');
	$("#invite_list").append($(this));
	$("#invitation_name").val("");
	$("#invites_selected").hide();
	return false;
}

function removeFromInvitationList(){
	$(this).parent().remove();
	return false;
}




