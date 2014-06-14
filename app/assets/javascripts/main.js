$(function(){

	if( $('body').hasClass('preload') ){
		$('body').removeClass('preload');
		// mobile menu close
		$('#container').removeClass('navOpen');
	}
	
	// mobile menu
	
	$('.menuToggle').click(function(){
		$('#container').toggleClass('navOpen');
	});
	
	
	//index 
	
	if( $('body.index').length ){
		
		// apply 'loaded' class when page has finished intro
	
		$("footer.light").bind("transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd", function(){
			$('.index').addClass('loaded');
		});
		
	}

	//portfolio 
	
	if( $('body.portfolio').length ){
	
		// hide details section and add 'reveal' button
		$(".credits").hide();
		$(".titleReveal h1").after('<span class="toggle show">Details</span>');
		
		$('span.toggle').click(function(e){
		
			// expand section
			$(e.currentTarget.parentElement).siblings('.credits').animate({height: "toggle"}, 350, "easeOutQuad");
						
			// Toggle the icon
			if( $(this).hasClass('show') ){
				// add 'show'
				$(this).addClass('hide').removeClass('show');
			} else {
				// add 'hide'
				$(this).addClass('show').removeClass('hide');
			}
			
		});
		
		
		// apply carousels
						
		$(".slides").each(function( index ){
			
			// Get wrapping ID
			var sectionId = $(this).closest('section').attr('id');
			
			// Add Prev / Next buttons
			$(this).prepend('<div class="slideNav"><div class="next"></div><div class="prev"></div></div>');
			$("#" + sectionId + " .slideNav").wrap('<div class="frame" />');			

			// Set the options & nav targets
			var options = {
				keyNavigation: false,
				fadeFrameWhenSkipped: false,
				navigationSkip: true,
	            autoPlay: false,
	            swipeNavigation: true,
	            reverseAnimationsWhenNavigatingBackwards: false,
	            nextButton: "#" + sectionId + " .slideNav .next",
	            prevButton: "#" + sectionId + " .slideNav .prev",
	            fallback: {
	            	theme: "fade"
	            }
	        }
			
			// Init slider
			var sequence = $("#" + sectionId + " .slides .frame").sequence(options).data("sequence");
						
		});
						
	}
	
	//bio
	
	
	if( $('body.bio').length ){
	
		//if not ipad or mobile
		var isiPad = /ipad/i.test(navigator.userAgent.toLowerCase());
		if (!isiPad && !jQuery.browser.mobile){
		
			// parallax bio
	
			var $bgobj = $('.bio .intro'); // the background
			var $contentobj = $('.bio .intro .wrap, .bio header.top'); // the content
			var $titleobj = $('.bio .intro .wrap'); // the content
			
			var adjustContent = function(){
			
				var scrollDistance = $(window).scrollTop();
			
				var bgYpos = (scrollDistance / 2);
				var contentYpos = (scrollDistance / 8);
				
				// New background position
				var newBackgroundY = '50% '+ bgYpos + 'px';
				$bgobj.css({ backgroundPosition: newBackgroundY });
				
				// New content position
				var newContentY = 'translateY('+contentYpos+'px)';
				$contentobj.css({ transform: newContentY });
				
				// Opacity of title should fade as you scroll
				
				var heroPosition = $('.topLevel').offset();
				var heroScrollDistance = heroPosition.top - scrollDistance ;
				var heroHeight = $('.intro').outerHeight();
				var heroScrollPercent = Math.round( (heroScrollDistance / heroHeight) * 100 );

				var newOpacity = heroScrollPercent / 100;
				$titleobj.css({ opacity: newOpacity });
				
			}
			
			// apply function to scroll event
			$(window).scroll(function() {
				adjustContent()
			})	
		
		}
	}
	
	// blog
	
	
	if( $('body.blog').length ){
	
		// When gif preview is clicked, pause others and play requested.
		
		$('.gifToggle').click(function(event) {
		
			event.preventDefault();
		
			//if not playing
			
			if( !$(this).hasClass('gifPlaying') ){		
				
				// Pause others
			
				$('.gifToggle.gifPlaying').each( function(){
					//swap source
					var animSrc = $(this).children('img').attr('src');
					var staticSrc = $(this).attr('href');
					// change anchor link to animated
					$(this).attr('href', animSrc).addClass('gifPaused').removeClass('gifPlaying');
					// change img src to static
					$(this).children('img').attr('src', staticSrc); 
					
				});
			
				// swap requested

				var animSrc = $(this).attr('href');
				var staticSrc = $(this).children('img').attr('src');
				// change anchor link to animated
				$(this).attr('href', staticSrc).addClass('gifPlaying').removeClass('gifPaused');
				// change img src to static
				$(this).children('img').attr('src', animSrc); 
			}
			
		});
		
	
	/*
		var $container = $('.pinlist');
		
		$container.imagesLoaded(function(){
			$container.masonry({
				itemSelector : '.pin',
				columnWidth : function( containerWidth ) {
					if( containerWidth <= 765 ){
						return containerWidth;
					} else {
						return Math.floor(containerWidth / 2);
					}
				}
			});
		});	
	*/
	}
	
	
});