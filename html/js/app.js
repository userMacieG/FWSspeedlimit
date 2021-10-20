$(function() {
	window.addEventListener("message", function(event) {
		$('#speedlimit').text(event.data.speedlimit);

		if (event.data.show) {
            $('#speedlimit').fadeIn()
		} else {
			$('#speedlimit').fadeOut()
		}
	})
})
