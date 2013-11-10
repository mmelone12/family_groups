/*------------------------------------------------------
/* Custom JS
----------------------------------------------------- */

/* ----------------- Start Document ----------------- */
jQuery(document).ready(function() {

/*--------------------------------------------------- */
/*	Main Navigation
/*--------------------------------------------------- */

$('ul#nav').superfish({
	delay:         100,
	animation:   {opacity:'show',height:'show'},
	speed:       'normal',
	disableHI:     true,
	autoArrows:  false,  
	dropShadows: false  
});

/*----------------------------------------------------*/
/*	Image Overlay
/*----------------------------------------------------*/

$('a.img-overlay').hover( 
function() {
	$(this).find('.img-overlay-div').stop().fadeTo('fast', 1);
},
function() {
	$(this).find('.img-overlay-div').stop().fadeTo('fast', 0);
});

$('a.img-overlay2').hover( 
function() {
	$(this).find('.img-overlay-div2').stop().fadeTo('fast', 1);
},
function() {
	$(this).find('.img-overlay-div2').stop().fadeTo('fast', 0);
});

/*----------------------------------------------------*/
/*	Client List Overlay
/*----------------------------------------------------*/

$('.client-list li').hover( 
function() {
	$(this).parent().find('li img').stop().animate({'opacity': '0.5'}, 200)
	.end().end().find('img').stop().animate({'opacity': '1'}, { queue: false, duration: 200 });
},
function() {
	$(this).parent().find('li img').stop().animate({'opacity': '1'}, 200);
});

/*----------------------------------------------------*/
/*	Tabs
/*----------------------------------------------------*/

(function() {

	var $tabsNav = $('.tabs-nav'),
		$tabsNavLis = $tabsNav.children('li'),
		$tabContent = $('.tab-content');

	$tabsNav.each(function() {
		var $this = $(this);

		$this.next().children('.tab-content').stop(true,true).hide().first().show();

		$this.children('li').first().addClass('active').stop(true,true).show();
	});

	$tabsNavLis.on('click', function(e) {
		var $this = $(this);

		$this.siblings().removeClass('active').end().addClass('active');
		
		$this.parent().next().children('.tab-content').stop(true,true).hide().siblings( $this.find('a').attr('href') ).fadeIn();

		e.preventDefault();
	});

})();

/*----------------------------------------------------*/
/*	Alert
/*----------------------------------------------------*/

(function() {
	var $close = $('.alert-close');
	
	$close.on('click', function() {
		$(this).parent().slideUp(200);
	});
})();

/*----------------------------------------------------*/
/*	Accordion
/*----------------------------------------------------*/

(function() {

	var $container = $('.acc-container'),
		$trigger = $('.acc-trigger');

	$container.hide();
	$trigger.first().addClass('active').next().show();

	$trigger.on('click', function(e) {
		if( $(this).next().is(':hidden') ) {
			$trigger.removeClass('active').next().slideUp(300);
			$(this).toggleClass('active').next().slideDown(300);
		}
		e.preventDefault();
	});

})();

/*----------------------------------------------------*/
/*	Isotope Portfolio Filter
/*----------------------------------------------------*/

$(window).load(function(){
	$('#portfolio-wrapper').isotope({
		itemSelector : '.portfolio-item',
		layoutMode : 'fitRows'
	});
		
	$('#filters a.selected').trigger("click");
});

$('#filters a').click(function(e){
	e.preventDefault();

	var selector = $(this).attr('data-option-value');
	$('#portfolio-wrapper').isotope({ filter: selector });

	$(this).parents('ul').find('a').removeClass('selected');
	$(this).addClass('selected');
});

/*--------------------------------------------------- */
/*	That's all folks!
/*--------------------------------------------------- */
});