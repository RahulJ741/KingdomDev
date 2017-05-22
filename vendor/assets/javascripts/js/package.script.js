$(document).ready(function(){
	$('footer').addClass('accomdation-footer2 event-tickets-footer2');
	$('footer .black_logo').hide();
	$('footer .white_logo').show();
	$( "#datepicker" ).datepicker();
	
	
});

var dropdowns = $(".dropdown");

// Onclick on a dropdown, toggle visibility
dropdowns.find("dt").click(function(){
	dropdowns.find("dd ul").hide();
	$(this).next().children().toggle();
});

// Clic handler for dropdown
dropdowns.find("dd ul li a").click(function(){
	var leSpan = $(this).parents(".dropdown").find("dt a span");
  
	// Remove selected class
	$(this).parents(".dropdown").find('dd a').each(function(){
    $(this).removeClass('selected');
  });
  
	// Update selected value
	leSpan.html($(this).html());
  
	// If back to default, remove selected class else addclass on right element
	if($(this).hasClass('default')){
    leSpan.removeClass('selected')
  }
	else{
		leSpan.addClass('selected');
		$(this).addClass('selected');
	}
  
	// Close dropdown
	$(this).parents("ul").hide();
});

// Close all dropdown onclick on another element
$(document).bind('click', function(e){
	if (! $(e.target).parents().hasClass("dropdown")) $(".dropdown dd ul").hide();
});

$(document).ready(function(){
	/* This code is executed after the DOM has been completely loaded */
	
	$('nav a,footer a.up').click(function(e){
										  
		// If a link has been clicked, scroll the page to the link's hash target:
		
		$.scrollTo( this.hash || 0, 1000);
		e.preventDefault();
	});

});





/**
 * Parallax Scrolling Tutorial
 * For NetTuts+
 *  
 * Author: Mohiuddin Parekh
 *	http://www.mohi.me
 * 	@mohiuddinparekh   
 */


$(document).ready(function(){
	// Cache the Window object
	$window = $(window);
                
   $('section[data-type="background"]').each(function(){
     var $bgobj = $(this); // assigning the object
                    
      $(window).scroll(function() {
                    
		// Scroll the background at var speed
		// the yPos is a negative value because we're scrolling it UP!								
		var yPos = -($window.scrollTop() / $bgobj.data('speed')); 
		
		// Put together our final background position
		var coords = '50% '+ yPos + 'px';

		// Move the background
		$bgobj.css({ backgroundPosition: coords });
		
}); // window scroll Ends

 });	

}); 
/* 
 * Create HTML5 elements for IE's sake
 */

document.createElement("article");
document.createElement("section");


/*
 * Create your own package
 */

jQuery('#packageCheckIn').on('change', function(e) {
    
    var package_date = jQuery(this).val();
    var num_nights = jQuery('#packageNights').val();

    if (package_date == 0) {
    	jQuery('.package-row').hide();
    	jQuery('.'+num_nights+'-nights').show(500);
    } else {
    	jQuery('.package-row').hide();

    	var row_class = num_nights+'-nights'+'.'+package_date+'-check-in';
    	jQuery('.'+row_class).show(500);
    }

});


jQuery('#packageNights').on('change', function(e) {
    
    var num_nights = jQuery(this).val();

    if (num_nights == 0) {
    	jQuery('.package-row').show(500);
    } else {
    	jQuery('.package-row').hide();
    	jQuery('.'+num_nights+'-nights').show(500);
    }

	jQuery.ajax({
        
        type : "post",
        url : base_url+'CreateYourOwnPackage/getCheckInDates',
        
        statusCode: {
            500: function() {
                alert(" 500 data still loading");
                console.log('500 ');
            }
        },
        
        data : { num_nights: num_nights },

        success: function(response) {
            
            //alert(response);
            jQuery('#packageCheckIn').html(response);

        },

    });
}); 
