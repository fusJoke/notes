
jQuery(function($){
	//Autocomplete lesson feedback after submitting the form
	var nextLesson = function(){
		//if there's a mark complete button
		if($('.learndash_mark_complete_button').size()) {
			$('.learndash_mark_complete_button').trigger('click');
		}
		//if there's no mark complete button, click next button
		else {
			$('.learndash_next_prev_link .next-link > span').trigger('click');
		}
	};

	//General KK popup events
	$('.kk-popup').on('click', function(e){
		if($(e.target).hasClass('kk-popup')) {
			$(e.target).removeClass('show');
		}
		if($(e.target).hasClass('btn-close')) {
			$(e.target).closest('.kk-popup').removeClass('show');
		}
	});

	//IFRAMES ON LESSON PAGES
	$('.learndash_content_wrap iframe').on("load", function() {
		var player;

		//VIMEO IFRAME
		if(this.getAttribute('src').indexOf('vimeo.com') !== -1) {
			player = new Vimeo.Player(this);
			console.log('player', player);

			player.on('ended', function() {
				console.log('Finished.');
				nextLesson();
			});

		}
		//GOOGLE DOCS IFRAME - feedback form
		else if(this.getAttribute('src').indexOf('docs.google.com/forms') !== -1){
			if(!this.loaded) {
				console.log('first load', this);
				this.loaded = 1;
			}else{
				console.log('second load', this);
				nextLesson();
			}
		}

		// if(!window.addedMouseMoveEventHandler && !window.videoAlreadyAutoplayed) {
		// 	window.addedMouseMoveEventHandler = true;
		// 	document.body.addEventListener("mousemove", function () {
		// 		window.videoAlreadyAutoplayed = true;
		// 		if(player) {
		// 			player.play()
		// 		}
		// 	})
		// }
	});

	//LESSON & TOPIC BAR WITH COMMANDS - ADD TOOLTIP SHOW ON BOTTOM, NOT ON TOP (down)
	if(
		$('body').hasClass('sfwd-topic-template-default') ||
		$('body').hasClass('sfwd-lessons-template-default')
	){
		$('span.meta-nav').attr('data-balloon-pos', 'down');
	}

	//ONLY ON AFFILIATE DASHBOARD PAGE
	if($('.esaf-pro-dashboard').size()) {
		$('.esaf-pro-dashboard-header-logo > img').wrap('<a href="' + window.location.origin + '"></a>');
	}

	//run on topics page only
	if(document.body.classList.contains('sfwd-topic-template-default')){
		//add special class for google docs feedback, so we can apply CSS to it
		var $i = $('.ld-tab-content iframe');
		if($i.length && $i.attr('src').indexOf('docs.google') !== -1 ){
			$('body').addClass('feedback-form');
		}
	}

	//UPDATE SHARE LINKS WHEN CERTIFICATE SHARE WIDGET IS VISIBLE
	if(
		$('.ld-alert-certificate').size() || //certificate alert widget
		$('.ld-cvss-certificate').size() //certificate single page
	) {

		var windowOpenTemplate = "window.open('%url%', 'Share on %network%', 'width=600,height=600,left=0,top=0,location=1,scrollbars=1,status=1,resizable=1,toolbar=0,menubar=0');return false;";

		//TWITTER
		var $twitterShareLink = $('.ld-cvss-social-buttons-list .ld-cvss-social-button-twitter > a');
		var updatedHrefTwitter = $twitterShareLink.attr('href') + '&hashtags=KodeKloud%2CKodeKloudCertificate';
		$twitterShareLink
			.attr('href', updatedHrefTwitter)
			.attr('onclick',
				windowOpenTemplate
					.replace('%url%', updatedHrefTwitter)
					.replace('%network%', 'Twitter')
			);

		//FACEBOOK
		var $fbShareLink = $('.ld-cvss-social-buttons-list .ld-cvss-social-button-facebook > a');
		var updatedHrefFB = $fbShareLink.attr('href') + '&hashtag=%23KodeKloudCertificate'; //one hashtag only on fb
		$fbShareLink
			.attr('href', updatedHrefFB)
			.attr('onclick',
				windowOpenTemplate
					.replace('%url%', updatedHrefFB)
					.replace('%network%', 'Facebook')
			);
	}

});

// AJAX
var kkAjax = {
	post: function(data, onSuccess, onError){
		jQuery.ajax({
			type : "post",
			dataType : "json",
			url : ajaxurl,
			data: data,
			success: function(response) {
				if(response.type === "success") {
					if(onSuccess) {
						onSuccess(response);
					}
				}
				else if(onError){
					onError(response);
				}else {
					console.log('ERROR', response);
				}
			}
		});
	}
};