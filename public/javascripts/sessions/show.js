$(document).ready(function() {
    $(function() {
        $("#tabs").tabs();
    });

    $("#arrow").click(function() {
        var citiesDropDown = $(this).find("#cities");
        if (citiesDropDown.hasClass('hidden'))
            citiesDropDown.removeClass('hidden');
        else
            citiesDropDown.addClass('hidden');
    });
});