$(document).on('ready page:load', function() {

	$('.start-hidden').hide();

	$('.vote-form').on('click', function() { 
		var self = $(this),
			votedButton = self.next('.start-hidden');

		$(this).fadeOut(400, function() {
		 	votedButton.delay(500).fadeIn();
		});

	});


	$('.time-button').on('click', function() { 
		$(this).css('margin-top', '4vh');
	} );

	$('#add-attendee-js').click();
	$('#add-attendee-js').click();
	$('#add-attendee-js').click();


	$('#add-time-js').click();
	$('#add-time-js').click();

	$('.all-proposals').hide().fadeIn(1000);
	$('.form-block').hide().fadeIn(1000);
	$('.prop-holder').hide().fadeIn(1000);
});
