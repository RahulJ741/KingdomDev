$(document).ready(function(){
	$('footer').addClass('accomdation-footer2 tour-footer-bg2');
	$('footer .black_logo').hide();
	$('footer .white_logo').show();
	$( "#datepicker" ).datepicker();
	
	
});
$(document).ready(function() {
    $(".tabs-menu a").click(function(event) {
        event.preventDefault();
        $(this).parent().addClass("current");
        $(this).parent().siblings().removeClass("current");
        var tab = $(this).attr("href");
        $(".tab-content").not(tab).css("display", "none");
        $(tab).fadeIn();
		

		
    });
});