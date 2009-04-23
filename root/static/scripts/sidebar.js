/**************************************************
 *  Adds the show / hide sidebar functionality
 *************************************************/
// Store selection in cookie, turn on/off the sidebar
function flipSidebar() {
    if($("#sidebartoggle").toggle().is(':visible'))
        showSidebar();
    else
        hideSidebar();
}

function showSidebar()
{
    $.cookie('sidebar', 'on', { expires: 15000 });
    $("#sidebartoggle").show();
    $("#sidebar-toggle-a").html('Hide Sidebar');
    $('#content').css("margin-left","140px");
    $('#content').css("margin-top","0px");
}

function hideSidebar()
{
    $.cookie('sidebar', 'off', { expires: 15000 });
    $("#sidebartoggle").hide();
    $("#sidebar-toggle-a").html('Show Sidebar');
    $('#content').css("margin-left","0px");
    $('#content').css("margin-top","15px"); // For "Show Sidebar" text   
}

$(document).ready(function(){
    // Check that the sidebar is turned on in user
    // preferences).  Does nothing if it is off.
    if (!$('#sidebar').length)
        return;

    $('#id_toggle_target').append(' \
        <span id="sidebar-hide-toggle"> \
            <a href="javascript:flipSidebar()" id="sidebar-toggle-a"> \
                &nbsp;Hide Sidebar \
            </a> \
        </span>');
    
    // Make show / hide selection persistent
    if ($.cookie('sidebar') == 'off')
        hideSidebar();
    else
        showSidebar();
});
