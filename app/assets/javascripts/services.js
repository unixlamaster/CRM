function ping_service(id) {
    var $img=$("<img />",{"src":"/images/loader.gif"});
	$('#div_ping_loss_'+id).html($img);
	$.getJSON('/services/ping/'+id+'.json', function(data){
		console.log(data['loss']);
		$('#div_ping_loss_'+id).html(data['loss']+'%');
	});
}