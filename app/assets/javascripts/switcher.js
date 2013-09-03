/* Style Switcher */

window.console = window.console || (function(){
	var c = {}; c.log = c.warn = c.debug = c.info = c.error = c.time = c.dir = c.profile = c.clear = c.exception = c.trace = c.assert = function(){};
	return c;
})();

$(document).ready(function(){ 

	var styleswitcherstr = ' \
		<h2>Style Switcher <a href="#"></a></h2> \
		<div class="content"> \
		<h3>Layout Style</h3> \
		<div class="layout-switcher"> \
		<a id="wide" class="layout">Wide</a> \
		<a id="boxed" class="layout">Boxed</a> \
		</div> \
		<div class="clear"></div> \
		<h3>Color Style</h3> \
		<div class="switcher-box"> \
		<a id="green" class="styleswitch color"></a> \
		</div><!-- End switcher-box --> \
		<div class="clear"></div>  \
		<div class="bg hidden">  \
		<h3>BG Pattern</h3>  \
		<a id="wood" class="pattern"></a> \
		<a id="greyfloral" class="pattern"></a> \
		<a id="little_pluses" class="pattern"></a> \
		<a id="norwegian_rose" class="pattern"></a> \
		<a id="arab_tile" class="pattern"></a> \
		<a id="escheresque" class="pattern"></a> \
		<a id="dark_wood" class="pattern"></a> \
		<a id="tex2res1" class="pattern"></a> \
		<a id="tileable_wood_texture" class="pattern"></a> \
		<a id="old_mathematics" class="pattern"></a> \
		<a id="random_grey_variations" class="pattern"></a> \
		<a id="type" class="pattern"></a> \
		</div> \
		<div class="clear"></div> \
		</div><!-- End content --> \
		';
	
	$(".switcher").prepend( styleswitcherstr );

});

/* boxed & wide syle */
$(document).ready(function(){ 

	var cookieName = 'wide';
	function changeLayout(layout) {
		$.cookie(cookieName, layout);
		$('head link[name=layout]').attr('href', 'css/layout/' + layout + '.css');
	}

	if( $.cookie(cookieName)) {
		changeLayout($.cookie(cookieName));
	}

	$("#wide").click( function(){ $
		changeLayout('wide');
	});

	$("#boxed").click( function(){ $
		changeLayout('boxed');
	});

});


/* background images */
$(document).ready(function(){ 
  
	var startClass = $.cookie('mycookie');
	$("body").addClass("wood");

	/* wood */
	$("#wood").click( function(){ 
		$("body").removeClass('greyfloral'); 
		$("body").removeClass('little_pluses');
		$("body").removeClass('norwegian_rose');
		$("body").removeClass('arab_tile');
		$("body").removeClass('escheresque');
		$("body").removeClass('dark_wood');
		$("body").removeClass('tex2res1');
		$("body").removeClass('tileable_wood_texture');
		$("body").removeClass('old_mathematics');
		$("body").removeClass('random_grey_variations');
		$("body").removeClass('type');
		$("body").addClass('wood');
		$.cookie('mycookie','wood');
	});
	
	/* greyfloral */
	$("#greyfloral").click( function(){ 
		$("body").removeClass('wood');
		$("body").removeClass('little_pluses');
		$("body").removeClass('norwegian_rose');
		$("body").removeClass('arab_tile');
		$("body").removeClass('escheresque');
		$("body").removeClass('dark_wood');
		$("body").removeClass('tex2res1');
		$("body").removeClass('tileable_wood_texture');
		$("body").removeClass('old_mathematics');
		$("body").removeClass('random_grey_variations');
		$("body").removeClass('type');
		$("body").addClass('greyfloral');
		$.cookie('mycookie','greyfloral');
	});
	
	/* little_pluses */
	$("#little_pluses").click( function(){ 
		$("body").removeClass('wood');
		$("body").removeClass('greyfloral');
		$("body").removeClass('norwegian_rose');
		$("body").removeClass('arab_tile');
		$("body").removeClass('escheresque');
		$("body").removeClass('dark_wood');
		$("body").removeClass('tex2res1');
		$("body").removeClass('tileable_wood_texture');
		$("body").removeClass('old_mathematics');
		$("body").removeClass('random_grey_variations');
		$("body").removeClass('type');
		$("body").addClass('little_pluses');
		$.cookie('mycookie','little_pluses');
	});
	
	/* norwegian_rose */
	$("#norwegian_rose").click( function(){ 
		$("body").removeClass('wood');
		$("body").removeClass('greyfloral');
		$("body").removeClass('little_pluses');
		$("body").removeClass('arab_tile');
		$("body").removeClass('escheresque');
		$("body").removeClass('dark_wood');
		$("body").removeClass('tex2res1');
		$("body").removeClass('tileable_wood_texture');
		$("body").removeClass('old_mathematics');
		$("body").removeClass('random_grey_variations');
		$("body").removeClass('type');
		$("body").addClass('norwegian_rose');
		$.cookie('mycookie','norwegian_rose');
	});
	
	/* arab_tile */
	$("#arab_tile").click( function(){ 
		$("body").removeClass('wood');
		$("body").removeClass('greyfloral');
		$("body").removeClass('little_pluses');
		$("body").removeClass('norwegian_rose');
		$("body").removeClass('escheresque');
		$("body").removeClass('dark_wood');
		$("body").removeClass('tex2res1');
		$("body").removeClass('tileable_wood_texture');
		$("body").removeClass('old_mathematics');
		$("body").removeClass('random_grey_variations');
		$("body").removeClass('type');
		$("body").addClass('arab_tile');
		$.cookie('mycookie','arab_tile');
	});
	
	/* escheresque */
	$("#escheresque").click( function(){ 
		$("body").removeClass('wood');
		$("body").removeClass('greyfloral');
		$("body").removeClass('little_pluses');
		$("body").removeClass('norwegian_rose');
		$("body").removeClass('arab_tile');
		$("body").removeClass('dark_wood');
		$("body").removeClass('tex2res1');
		$("body").removeClass('tileable_wood_texture');
		$("body").removeClass('old_mathematics');
		$("body").removeClass('random_grey_variations');
		$("body").removeClass('type');
		$("body").addClass('escheresque');
		$.cookie('mycookie','escheresque');
	});
	
	/* dark_wood */
	$("#dark_wood").click( function(){ 
		$("body").removeClass('wood');
		$("body").removeClass('greyfloral');
		$("body").removeClass('little_pluses');
		$("body").removeClass('norwegian_rose');
		$("body").removeClass('arab_tile');
		$("body").removeClass('escheresque');
		$("body").removeClass('tex2res1');
		$("body").removeClass('tileable_wood_texture');
		$("body").removeClass('old_mathematics');
		$("body").removeClass('random_grey_variations');
		$("body").removeClass('type');
		$("body").addClass('dark_wood');
		$.cookie('mycookie','dark_wood');
	});
	
	/* tex2res1 */
	$("#tex2res1").click( function(){ 
		$("body").removeClass('wood');
		$("body").removeClass('greyfloral');
		$("body").removeClass('little_pluses');
		$("body").removeClass('norwegian_rose');
		$("body").removeClass('arab_tile');
		$("body").removeClass('escheresque');
		$("body").removeClass('dark_wood');
		$("body").removeClass('tileable_wood_texture');
		$("body").removeClass('old_mathematics');
		$("body").removeClass('random_grey_variations');
		$("body").removeClass('type');
		$("body").addClass('tex2res1');
		$.cookie('mycookie','tex2res1');
	});
	
	/* tileable_wood_texture */
	$("#tileable_wood_texture").click( function(){ 
		$("body").removeClass('wood');
		$("body").removeClass('greyfloral');
		$("body").removeClass('little_pluses');
		$("body").removeClass('norwegian_rose');
		$("body").removeClass('arab_tile');
		$("body").removeClass('escheresque');
		$("body").removeClass('dark_wood');
		$("body").removeClass('tex2res1');
		$("body").removeClass('old_mathematics');
		$("body").removeClass('random_grey_variations');
		$("body").removeClass('type');
		$("body").addClass('tileable_wood_texture');
		$.cookie('mycookie','tileable_wood_texture');
	});
	
	/* old_mathematics */
	$("#old_mathematics").click( function(){ 
		$("body").removeClass('wood');
		$("body").removeClass('greyfloral');
		$("body").removeClass('little_pluses');
		$("body").removeClass('norwegian_rose');
		$("body").removeClass('arab_tile');
		$("body").removeClass('escheresque');
		$("body").removeClass('dark_wood');
		$("body").removeClass('tex2res1');
		$("body").removeClass('tileable_wood_texture');
		$("body").removeClass('random_grey_variations');
		$("body").removeClass('type');
		$("body").addClass('old_mathematics');
		$.cookie('mycookie','old_mathematics');
	});
	
	/* random_grey_variations */
	$("#random_grey_variations").click( function(){ 
		$("body").removeClass('wood');
		$("body").removeClass('greyfloral');
		$("body").removeClass('little_pluses');
		$("body").removeClass('norwegian_rose');
		$("body").removeClass('arab_tile');
		$("body").removeClass('escheresque');
		$("body").removeClass('dark_wood');
		$("body").removeClass('tex2res1');
		$("body").removeClass('tileable_wood_texture');
		$("body").removeClass('old_mathematics');
		$("body").removeClass('type');
		$("body").addClass('random_grey_variations');
		$.cookie('mycookie','random_grey_variations');
	});
	
	/* type */
	$("#type").click( function(){ 
		$("body").removeClass('wood');
		$("body").removeClass('greyfloral');
		$("body").removeClass('little_pluses');
		$("body").removeClass('norwegian_rose');
		$("body").removeClass('arab_tile');
		$("body").removeClass('escheresque');
		$("body").removeClass('dark_wood');
		$("body").removeClass('tex2res1');
		$("body").removeClass('tileable_wood_texture');
		$("body").removeClass('old_mathematics');
		$("body").removeClass('random_grey_variations');
		$("body").addClass('type');
		$.cookie('mycookie','type');
	});

	if ($.cookie('mycookie')) {
		$('body').addClass($.cookie('mycookie'));
	}

});

/* Skins Style */
$(document).ready(function(){ 

	var cookieName = 'green';

	function changeLayout(layout) {
		$.cookie(cookieName, layout);
		$('head link[name=skins]').attr('href', 'css/skins/' + layout + '.css');
	}

	if( $.cookie(cookieName)) {
		changeLayout($.cookie(cookieName));
	}

	$("#green").click( function(){ changeLayout('green'); });

});

/* Fonts 01 */
$(document).ready(function(){ 

	var cookieName = 'Droid+Sans';

	function changeLayout(layout) {
		$.cookie(cookieName, layout);
		$('head link[name=fonts]').attr('href', 'http://fonts.googleapis.com/css?family=' + layout);
	}

	if( $.cookie(cookieName)) {
		changeLayout($.cookie(cookieName));
	}

	$("#menu-style").change(function(){
		if( $(this).val() == 1){
			changeLayout('Droid+Sans');        
		} else{
			changeLayout('Droid+Serif');        
		}
	})

});


/* Reset Switcher */
$(document).ready(function(){ 

	// Style Switcher	
	$('.switcher').animate({
		left: '-196px'
	});

	$('.switcher h2 a').click(function(e){
		e.preventDefault();
		var div = $('.switcher');
		if (div.css('left') === '-196px') {
			$('.switcher').animate({
				left: '0px'
			}); 
		} else {
			$('.switcher').animate({
				left: '-196px'
			});
		}
	});
	
});						   

