$(document).ready(function() {
    $('#all-users').tablesorter({sortList: [[4,0]]});
    $('#container').height($('#users').height() + 200);
});