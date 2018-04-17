

/*******************************************************************
Carousel Tool - jQuery Tools powered carousel	
********************************************************************/

	// Feature Banner
	$(document).ready(function() {
		$("#browsable").scrollable({circular:true}).navigator();
        // Hide arrows on load
        $('.browse').hide();
	   	// Show/hide prev & next arrows
		$('#feature-banner').hover(function(){
			$('.browse').fadeIn();
		}, function(){
			$('.browse').fadeOut();
		});
	});

	// At Stanford
	        $(document).ready(function() {  
                $(".slidetabs").tabs(".atstanford > div", { effect: 'fade', fadeOutSpeed: "slow", rotate: true }).slideshow({interval: 8000, clickable: false}); setTimeout('$(".slidetabs").data("slideshow").play();', 4000);});


/*******************************************************************
Search Box - drop down for Web / People
Uses hoverIntent r6 // 2011.02.26 // jQuery 1.5.1+ 
<http://cherne.net/brian/resources/jquery.hoverIntent.html>
********************************************************************/

(function($){$.fn.hoverIntent=function(f,g){var cfg={sensitivity:7,interval:100,timeout:0};cfg=$.extend(cfg,g?{over:f,out:g}:f);var cX,cY,pX,pY;var track=function(ev){cX=ev.pageX;cY=ev.pageY};var compare=function(ev,ob){ob.hoverIntent_t=clearTimeout(ob.hoverIntent_t);if((Math.abs(pX-cX)+Math.abs(pY-cY))<cfg.sensitivity){$(ob).unbind("mousemove",track);ob.hoverIntent_s=1;return cfg.over.apply(ob,[ev])}else{pX=cX;pY=cY;ob.hoverIntent_t=setTimeout(function(){compare(ev,ob)},cfg.interval)}};var delay=function(ev,ob){ob.hoverIntent_t=clearTimeout(ob.hoverIntent_t);ob.hoverIntent_s=0;return cfg.out.apply(ob,[ev])};var handleHover=function(e){var ev=jQuery.extend({},e);var ob=this;if(ob.hoverIntent_t){ob.hoverIntent_t=clearTimeout(ob.hoverIntent_t)}if(e.type=="mouseenter"){pX=ev.pageX;pY=ev.pageY;$(ob).bind("mousemove",track);if(ob.hoverIntent_s!=1){ob.hoverIntent_t=setTimeout(function(){compare(ev,ob)},cfg.interval)}}else{$(ob).unbind("mousemove",track);if(ob.hoverIntent_s==1){ob.hoverIntent_t=setTimeout(function(){delay(ev,ob)},cfg.timeout)}}};return this.bind('mouseenter',handleHover).bind('mouseleave',handleHover)}})(jQuery);

 $(function(){
    var config = {  sensitivity: 3, interval: 200, over: doOpen, timeout: 1000, out: doClose   
    };
    
    function doOpen() {
        $('.sb_dropdown',this).fadeIn();
    }
 
    function doClose() {
        $('.sb_dropdown',this).fadeOut();
    }

    $("#container_search").hoverIntent(config);
});
