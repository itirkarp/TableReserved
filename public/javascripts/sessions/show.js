$(document).ready(function() {
    $(function() {
        $("#tabs").tabs();
    });

    $('#container').height($('#tabs-1').height() + 200);
});