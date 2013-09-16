		$(function(){
			/* ▼Change icon when touched */
			$("#header-logo img").bind('touchstart', function() {
				$("#header-logo img").attr('src', 'img/logo-on.png');
			});
			$("#header-logo img").bind('touchend', function() {
				$("#header-logo img").attr('src', 'img/logo.png');
			});
			$("#header-icon img").bind('touchstart', function() {
				var imgId  = $(this).attr("id");
				$("#"+imgId).attr('src', 'img/'+imgId+'-on.png');
			});
			$("#header-icon img").bind('touchend', function() {
				var imgId  = $(this).attr("id");
				$("#"+imgId).attr('src', 'img/'+imgId+'.png');
			});
			/* ▲Change icon when touched */
		})