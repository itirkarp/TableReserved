(function($) {
    $(function() {
        $("#login").hover(function(){
            $("#signup").addClass("dull");
            $("#login").removeClass("dull");
        });
        $("#signup").hover(function(){
            $("#login").addClass("dull");
            $("#signup").removeClass("dull");
        });
    });
})(jQuery);