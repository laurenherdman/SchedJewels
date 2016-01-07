$(document).on('ready page:load', function() {
	var timeslotNumber = 0
	$('.vote-submit').on('click', function() { $(this).hide() } );
	$('.time-button').on('click', function() { 
		timeslotNumber += 1
		console.log(timeslotNumber);
		$( "<hr>" ).append( ".timeslot-js-trig" );
	} );
});
