$(document).ready(function() {


	//HEADER SEARCH ------------

	$('.search-icon__mobile').click(function(){

		$('.header__contacts').children('.copyright__search').toggleClass('copyright__search--active');
		if($(document).width() > 400){
			$('.header__logo').toggleClass('header__logo--hidden');
		}

		else{
			return
		}
		

	});

	//newItems SLIDER

	$('.newsItem__slider').slick({

		slidesToShow: 1,
		slidesToScroll: 1,
		arrows: true,
		dots: true,
		nextArrow: $(".newItem__slider-next"),
		prevArrow: $(".newItem__slider-prev"),
	});

	$('.newsItem__slider-mobile').slick({

		slidesToShow: 1,
		slidesToScroll: 1,
		arrows: false,
		dots: true
	});

	//ADVANTAGES MOBILE SLIDER

	$('.advantages__mobile').slick({

		slidesToShow: 1,
		slidesToScroll: 1,
		arrows: false,
		dots: true
	});

	//Banner SLIDER

	$('.right-banner__slider').slick({

		slidesToShow: 1,
		slidesToScroll: 1,
		arrows: false,
		dots: false,
		autoplay: true,
		autoplaySpeed: 4500,
		fade: true,
		cssEase: 'cubic-bezier(0.7, 0, 0.3, 1)',
		infinite:true,
		touchThreshold: 100
	});

	//Carousel Slider

	/*$('.carousel__slider').slick({
		slidesToShow: 1,
		slidesToScroll: 1,
		arrows: false,
		dots: false,
		autoplay: true,
		autoplaySpeed: 2000,
		centerMode: true,
		responsive: [
			{
				breakpoint: 1024,
				settings: {
					slidesToShow: 1,
					slidesToScroll: 1,
					infinite: true,
					dots: true
				}
			},
			{
				breakpoint: 600,
				settings: {
					slidesToShow: 1,
					slidesToScroll: 1
				}
			},
			{
				breakpoint: 480,
				settings: {
					slidesToShow: 1,
					slidesToScroll: 1
				}
			}
		]
	});*/

	//FactsSlider

	$('.facts__slider').slick({
		autoplay: true,
		autoplaySpeed: 5000,
		infinite:true,
		slidesToShow: 1,
		slidesToScroll: 1,
		arrows: false,
		dots: true
	});

	//Production Slider

	$('.production__slider').slick({
		autoplay: true,
		autoplaySpeed: 5000,
		slidesToShow: 1,
		slidesToScroll: 1,
		arrows: false,
		dots: true
	});

	//About Slider

	$('.about__slider').slick({
		// autoplay: true,
		// autoplaySpeed: 5000,
		infinite:true,
		slidesToShow: 1,
		slidesToScroll: 1,
		arrows: false,
		dots: true
	});

	//More Products Slider

	$('.more__slider').slick({
		slidesToShow: 4,
		slidesToScroll: 4,
		arrows: true,
		dots: true,
		nextArrow: $(".more__slider-next"),
		prevArrow: $(".more__slider-prev"),
		responsive: [{
				breakpoint: 1200,
				settings: {
					slidesToShow: 3,
					slidesToScroll: 3
				}
			},
			{
				breakpoint: 1000,
				settings: {
					slidesToShow: 2,
					slidesToScroll: 2
				}
			},
			{
				breakpoint: 700,
				settings: {
					slidesToShow: 1,
					slidesToScroll: 1,
					infinite: false
				}
			},
		]
	});


	// VIDEO MODAL SCRIPT

	$('.video').magnificPopup({
		type: 'iframe',


		iframe: {
			patterns: {
				dailymotion: {

					index: 'dailymotion.com',

					id: function(url) {
						var m = url.match(/^.+dailymotion.com\/(video|hub)\/([^_]+)[^#]*(#video=([^_&]+))?/);
						if (m !== null) {
							if (m[4] !== undefined) {

								return m[4];
							}
							return m[2];
						}
						return null;
					},

					src: 'https://www.dailymotion.com/embed/video/%id%'

				}
			}
		}


	});

	//VIDEO MOBILE SLIDER

	// Ð¤Ð»Ð°Ð³ Ð²ÐºÐ»ÑŽÑ‡Ñ‘Ð½Ð½Ð¾ÑÑ‚Ð¸ ÑÐ»Ð°Ð¹Ð´ÐµÑ€Ð°
	var slickSliderActive = false;
	var slickSliderActive2 = false;

	// Ð’ÐºÐ»ÑŽÑ‡ÐµÐ½Ð¸Ðµ Ð¸Ð»Ð¸ Ð²Ñ‹ÐºÐ»ÑŽÑ‡ÐµÐ½Ð¸Ðµ ÑÐ»Ð°Ð¹Ð´ÐµÑ€Ð° (Ð² Ð·Ð°Ð²Ð¸ÑÐ¸Ð¼Ð¾ÑÑ‚Ð¸ Ð¾Ñ‚ ÑˆÐ¸Ñ€Ð¸Ð½Ñ‹)
	function checkSlider() {

		// Ð•ÑÐ»Ð¸ Ð²ÑŒÑŽÐ¿Ð¾Ñ€Ñ‚ ÑƒÐ¶Ðµ Ñ‡ÐµÐ¼ 768 
		if ($(window).width() < 700 - getScroll()) {

			// Ð•ÑÐ»Ð¸ Ñ„Ð»Ð°Ð³ Ð²ÐºÐ»ÑŽÑ‡Ñ‘Ð½Ð½Ð¾ÑÑ‚Ð¸ Ð¾Ð¿ÑƒÑ‰ÐµÐ½, Ñ‚Ð¾ Ð²ÐºÐ»ÑŽÑ‡Ð¸Ð¼ Ð¸ Ð¿Ð¾Ð´Ð½Ð¸Ð¼ÐµÐ¼ Ñ„Ð»Ð°Ð³
			if (slickSliderActive == false) {
				$('.videos__slider').slick({
					dots: true,
					infinite: false,
					arrows: false,
					slidesToShow: 1,
					slidesToScroll: 1
				});
				slickSliderActive = true;
			}

			// Ð˜Ð½Ð°Ñ‡Ðµ (Ð²ÑŒÑŽÐ¿Ð¾Ñ€Ñ‚ ÐÐ• ÑƒÐ¶Ðµ Ñ‡ÐµÐ¼ 768)
		} else {

			// Ð•ÑÐ»Ð¸ Ñ„Ð»Ð°Ð³ Ð²ÐºÐ»ÑŽÑ‡Ñ‘Ð½Ð½Ð¾ÑÑ‚Ð¸ Ð¿Ð¾Ð´Ð½ÑÑ‚, Ð²Ñ‹ÐºÐ»ÑŽÑ‡Ð°ÐµÐ¼ Ð¸ Ð¾Ð¿ÑƒÑÐºÐ°ÐµÐ¼ Ñ„Ð»Ð°Ð³
			if (slickSliderActive) {
				$('.videos__slider').slick('unslick');
				slickSliderActive = false;
			}

		}
	};

	function checkSlider2() {

		// Ð•ÑÐ»Ð¸ Ð²ÑŒÑŽÐ¿Ð¾Ñ€Ñ‚ ÑƒÐ¶Ðµ Ñ‡ÐµÐ¼ 768 
		if ($(window).width() < 701 - getScroll()) {

			// Ð•ÑÐ»Ð¸ Ñ„Ð»Ð°Ð³ Ð²ÐºÐ»ÑŽÑ‡Ñ‘Ð½Ð½Ð¾ÑÑ‚Ð¸ Ð¾Ð¿ÑƒÑ‰ÐµÐ½, Ñ‚Ð¾ Ð²ÐºÐ»ÑŽÑ‡Ð¸Ð¼ Ð¸ Ð¿Ð¾Ð´Ð½Ð¸Ð¼ÐµÐ¼ Ñ„Ð»Ð°Ð³
			if (slickSliderActive2 == false) {
				$('.certificates__slider').slick({
					dots: true,
					infinite: false,
					arrows: false,
					slidesToShow: 1,
					slidesToScroll: 1
				});
				slickSliderActive2 = true;
			}

			// Ð˜Ð½Ð°Ñ‡Ðµ (Ð²ÑŒÑŽÐ¿Ð¾Ñ€Ñ‚ ÐÐ• ÑƒÐ¶Ðµ Ñ‡ÐµÐ¼ 768)
		} else {

			// Ð•ÑÐ»Ð¸ Ñ„Ð»Ð°Ð³ Ð²ÐºÐ»ÑŽÑ‡Ñ‘Ð½Ð½Ð¾ÑÑ‚Ð¸ Ð¿Ð¾Ð´Ð½ÑÑ‚, Ð²Ñ‹ÐºÐ»ÑŽÑ‡Ð°ÐµÐ¼ Ð¸ Ð¾Ð¿ÑƒÑÐºÐ°ÐµÐ¼ Ñ„Ð»Ð°Ð³
			if (slickSliderActive2) {
				$('.certificates__slider').slick('unslick');
				slickSliderActive2 = false;
			}

		}
	};


	// ÐŸÐ¾ Ð³Ð¾Ñ‚Ð¾Ð²Ð½Ð¾ÑÑ‚Ð¸ DOM...
	$(document).ready(function() {
		checkSlider();
		checkSlider2();
	});

	// ÐŸÐ¾ Ð»ÑŽÐ±Ð¾Ð¼Ñƒ Ð¸Ð·Ð¼ÐµÐ½ÐµÐ½Ð¸ÑŽ Ñ€Ð°Ð·Ð¼ÐµÑ€Ð° Ð²ÑŒÑŽÐ¿Ð¾Ñ€Ñ‚Ð°...
	$(window).on('resize', function() {
		checkSlider();
		checkSlider2();
	});

	function getScroll() {
		var div = document.createElement('div');
		div.style.overflowY = 'scroll';
		div.style.width = '50px';
		div.style.height = '50px';
		div.style.visibility = 'hidden';
		document.body.appendChild(div);
		var scrollWidth = div.offsetWidth - div.clientWidth;
		document.body.removeChild(div);
		return scrollWidth;
	}

	// FORM POPUP

	$('.popup-modal').magnificPopup({
		type: 'inline',
		preloader: false,
		modal: true
	});
	$(document).on('click', '.popup-modal-dismiss', function(e) {
		e.preventDefault();
		$.magnificPopup.close();
	});

	//HEADER STICKY
	var header1 = $('.header__sticky');

	$(window).scroll(function() {
		if ($(this).scrollTop() > 80 && $(window).width() > 1200) {
			header1.show();
		} else {
			header1.hide();
		}
	});

	$(".eshop__radio").click(function() {

		if ($(this).hasClass("active")) {

		} else {
			$(".retail__radio").removeClass("active");
			$(".retail__list").removeClass("active");
			$(this).toggleClass("active");
			$(".eshop__list").toggleClass("active");
		}

	});

	$(".retail__radio").click(function() {

		if ($(this).hasClass("active")) {

		} else {
			$(".eshop__radio").removeClass("active");
			$(".eshop__list").removeClass("active");
			$(this).toggleClass("active");
			$(".retail__list").toggleClass("active");
		}

	});


	//FILTER POPUP

	$(".results__filter").click(function() {
		$(this).toggleClass('active')
		$(".results__selects").toggleClass('active')
	})
	if($('.carousel__slider_n').length){
	$.ajax({
		url: 'https://www.instagram.com/stilfortrus/?__a=1',
		dataType: 'json',
		type: 'GET',
		data: {},
		success: function(data){
			var html = '';
			for(var x in data.graphql.user.edge_owner_to_timeline_media.edges ){
				var n = data.graphql.user.edge_owner_to_timeline_media.edges[x];
				var t = n.node;
				var shortcode = t.shortcode;
				var thumbnail_src = t.thumbnail_src;
				var text = t.edge_media_to_caption.edges[0].node.text;
				html += '<div class="carousel__slide"><div class="carousel__image"><img src="'+thumbnail_src+'" alt="'+text+'"/></div></div>';
				
			}
			$('.carousel__slider_n').html(html).removeClass('carousel__slider_n').addClass('carousel__slider');
			
			//Carousel Slider
			
			$('.carousel__slider').slick({
				slidesToShow: 5,
				slidesToScroll: 1,
				arrows: false,
				dots: false,
				autoplay: true,
				autoplaySpeed: 2000,
				centerMode: true,
				responsive: [
				{
					breakpoint: 1024,
					settings: {
						slidesToShow: 4,
						slidesToScroll: 1,
						infinite: true,
						dots: true
					}
				},
				{
					breakpoint: 600,
					settings: {
						slidesToShow: 3,
						slidesToScroll: 1
					}
				},
				{
					breakpoint: 480,
					settings: {
						slidesToShow: 2,
						slidesToScroll: 1
					}
				}
				]
			});
		},
		error: function(data){
			console.log(data); // send the error notifications to console
		}
	});
	}
});

/*!
 * Bootstrap v3.3.7 (http://getbootstrap.com)
 * Copyright 2011-2018 Twitter, Inc.
 * Licensed under MIT (https://github.com/twbs/bootstrap/blob/master/LICENSE)
 */

/*!
 * Generated using the Bootstrap Customizer (<none>)
 * Config saved to config.json and <none>
 */
if (typeof jQuery === 'undefined') {
	throw new Error('Bootstrap\'s JavaScript requires jQuery')
}
+function ($) {
	'use strict';
	var version = $.fn.jquery.split(' ')[0].split('.')
	if ((version[0] < 2 && version[1] < 9) || (version[0] == 1 && version[1] == 9 && version[2] < 1) || (version[0] > 3)) {
		throw new Error('Bootstrap\'s JavaScript requires jQuery version 1.9.1 or higher, but lower than version 4')
	}
}(jQuery);

/* ========================================================================
 * Bootstrap: tab.js v3.3.7
 * http://getbootstrap.com/javascript/#tabs
 * ========================================================================
 * Copyright 2011-2016 Twitter, Inc.
 * Licensed under MIT (https://github.com/twbs/bootstrap/blob/master/LICENSE)
 * ======================================================================== */


+function ($) {
	'use strict';
	
	// TAB CLASS DEFINITION
	// ====================
	
	var Tab = function (element) {
		// jscs:disable requireDollarBeforejQueryAssignment
		this.element = $(element)
		// jscs:enable requireDollarBeforejQueryAssignment
	}
	
	Tab.VERSION = '3.3.7'
	
	Tab.TRANSITION_DURATION = 150
	
	Tab.prototype.show = function () {
		var $this    = this.element
		var $ul      = $this.closest('ul:not(.dropdown-menu)')
		var selector = $this.data('target')
		
		if (!selector) {
			selector = $this.attr('href')
			selector = selector && selector.replace(/.*(?=#[^\s]*$)/, '') // strip for ie7
		}
		
		if ($this.parent('li').hasClass('active')) return
			
			var $previous = $ul.find('.active:last a')
			var hideEvent = $.Event('hide.bs.tab', {
				relatedTarget: $this[0]
			})
			var showEvent = $.Event('show.bs.tab', {
				relatedTarget: $previous[0]
			})
			
			$previous.trigger(hideEvent)
			$this.trigger(showEvent)
			
			if (showEvent.isDefaultPrevented() || hideEvent.isDefaultPrevented()) return
				
				var $target = $(selector)
				
				this.activate($this.closest('li'), $ul)
				this.activate($target, $target.parent(), function () {
					$previous.trigger({
						type: 'hidden.bs.tab',
					   relatedTarget: $this[0]
					})
					$this.trigger({
						type: 'shown.bs.tab',
				   relatedTarget: $previous[0]
					})
				})
	}
	
	Tab.prototype.activate = function (element, container, callback) {
		var $active    = container.find('> .active')
		var transition = callback
		&& $.support.transition
		&& ($active.length && $active.hasClass('fade') || !!container.find('> .fade').length)
		
		function next() {
			$active
			.removeClass('active')
			.find('> .dropdown-menu > .active')
			.removeClass('active')
			.end()
			.find('[data-toggle="tab"]')
			.attr('aria-expanded', false)
			
			element
			.addClass('active')
			.find('[data-toggle="tab"]')
			.attr('aria-expanded', true)
			
			if (transition) {
				element[0].offsetWidth // reflow for transition
				element.addClass('in')
			} else {
				element.removeClass('fade')
			}
			
			if (element.parent('.dropdown-menu').length) {
				element
				.closest('li.dropdown')
				.addClass('active')
				.end()
				.find('[data-toggle="tab"]')
				.attr('aria-expanded', true)
			}
			
			callback && callback()
		}
		
		$active.length && transition ?
		$active
		.one('bsTransitionEnd', next)
		.emulateTransitionEnd(Tab.TRANSITION_DURATION) :
		next()
		
		$active.removeClass('in')
	}
	
	
	// TAB PLUGIN DEFINITION
	// =====================
	
	function Plugin(option) {
		return this.each(function () {
			var $this = $(this)
			var data  = $this.data('bs.tab')
			
			if (!data) $this.data('bs.tab', (data = new Tab(this)))
				if (typeof option == 'string') data[option]()
		})
	}
	
	var old = $.fn.tab
	
	$.fn.tab             = Plugin
	$.fn.tab.Constructor = Tab
	
	
	// TAB NO CONFLICT
	// ===============
	
	$.fn.tab.noConflict = function () {
		$.fn.tab = old
		return this
	}
	
	
	// TAB DATA-API
	// ============
	
	var clickHandler = function (e) {
		e.preventDefault()
		Plugin.call($(this), 'show')
	}
	
	$(document)
	.on('click.bs.tab.data-api', '[data-toggle="tab"]', clickHandler)
	.on('click.bs.tab.data-api', '[data-toggle="pill"]', clickHandler)
	
}(jQuery);
$( function() {
	var city = $('.city-name');
	var letter = $('.abc > a');
	city.click( function(e) {
		e.preventDefault();
		var cityID = $(this).data('city-id');
		//city.removeClass('active-city');
		//$(this).toggleClass('active-city');
		console.log(this);
		console.log();
		if($(this).hasClass('active-city')){
			$(this).removeClass('active-city');
			$('.city-shops').removeClass('active-city-container mt20 mb30');
		} else {
			city.removeClass('active-city');
			$(this).toggleClass('active-city');
			$('.city-shops').removeClass('active-city-container mt20 mb30');
			$(cityID).toggleClass('active-city-container mt20 mb30');
		}
	});
	letter.click( function(e) {
		e.preventDefault();
		var target = $(this).attr('href') + '-target';
		if($(target).length){
			$('html, body').animate({
				scrollTop: $(target).offset().top - 100
			}, 500);
		}
	});
});