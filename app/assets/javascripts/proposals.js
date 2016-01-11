$(document).on('ready page:load', function() {

	$('.start-hidden').hide();

	$('.vote-form').on('click', function() { 

		var function_One = function() {
			 var r = $.Deferred();

			$('.vote-form').fadeOut()

			return r
		}

		var function_Two = function() {
		 	$('.start-hidden').delay(100).fadeIn();
		};

		function_One().done( function_Two() );

	});


	$('.time-button').on('click', function() { 
		$(this).css('margin-top', '4vh');
	} );

	$('#add-attendee-js').click();
	$('#add-time-js').click();

	$('.all-proposals').hide().fadeIn(1000);
	$('.form-block').hide().fadeIn(1000);

});
