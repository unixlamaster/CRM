function client_notification(id) {
    var $img=$("<img />",{"src":"/images/loader.gif"});
	$('#div_email').html($img);
	$.getJSON('/client/'+id+'/client_notification.json', function(data){
		console.log(data['email']);
		$('#div_email').html(data['res']);
	});
}