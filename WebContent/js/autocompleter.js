$(document).ready(function() {
	$(function() {
		
		$("#qUser").autocomplete({

			source : function(request, response) {
				$.ajax({
					url : "SearchController",
					type : "POST",
					data : {
						term : request.term
					},
					dataType : "json",
					success : function(data) {
						response(data);
					}
				});
			}
		});
	});
	
	$('div.dropdown ul.dropdown-menu li a').click(function (e) {
	    var $div = $(this).parent().parent().parent(); 
	    var $btn = $div.find('button');
	    $btn.html($(this).text() + ' <span class="caret"></span>');
	    $div.removeClass('open');
	    e.preventDefault();
	    return false;
	});

});


