$(document).on('ready page:load', function() {
	var timeslotNumber = 0
	$('.vote-submit').on('click', function() { $(this).hide() } );
	$('.time-button').on('click', function() { 
		$(this).css('margin-top', '4vh');
	} );
	$('#add-attendee-js').click();
	$('#add-time-js').click();

	$('.all-proposals').hide().fadeIn(1000);
	$('.form-block').hide().fadeIn(1000);

});
