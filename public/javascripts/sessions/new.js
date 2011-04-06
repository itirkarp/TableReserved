(function($) {
    $(function() {
        $("#login").hover(function(){
            $("#signup").removeClass("less-dull");
            $("#signup").addClass("more-dull");
            $("#login").removeClass("more-dull");
            $("#login").addClass("less-dull");
        });
        $("#signup").hover(function(){
            $("#login").removeClass("less-dull");
            $("#login").addClass("more-dull");
            $("#signup").removeClass("more-dull");
            $("#signup").addClass("less-dull");
        });
    });
})(jQuery);