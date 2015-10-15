/**
 * written by Harinath
 */

$(document).ready(function() {
	$('#submit').click(function() {
		console.log("Clicked Submit button..")

		var userName = $('#un').val();
		var passWord = $('#pw').val();

		if ($.trim(userName) == "") {
			$('.error_message_login').fadeIn(500);
			return false;
		}
		if ($.trim(passWord) == "") {
			$('.error_message_login').fadeIn(500);
			return false;
		}
	});
});
