$(document).ready(function() {
    $("#logo").click(function() {
        window.location.href = "/"
    });

    $("#arrow").click(function() {
        var citiesDropDown = $(this).find("#cities");
        if (citiesDropDown.hasClass('hidden'))
            citiesDropDown.removeClass('hidden');
        else
            citiesDropDown.addClass('hidden');
    });
});