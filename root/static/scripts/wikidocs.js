/*********************************************************
   This is a very low-key script, with the goal that it
   never actually be noticed by the users.  It captures
   WikiDoc page requests on any /doc page (but NOT /doc/bare)
   and takes control of any anchor links which link to other
   WikiDoc pages, so they load the bare version.
   -----------------------------------------------------
   Adds 4.2k and 2 requests to the initial WikiDocs page
   load (assuming the 2 scripts are not cached), but
   saves 18.4 kb of uncacheable XHTML being sent for
   every WikiDoc page served, after that first one.
*********************************************************/

            $(function() {
                
                $.ui.history('add', 'show', function() {
                    $('#wiki_content').show();
                });
                $.ui.history('add', 'hide', function() {
                    $('#wiki_content').hide();
                });
                
                $('#wiki_content a').eq(0).
                    click(function() {
                        $.ui.history('go', 'show');
                        return false;
                    }).
                    end().eq(1).
                    click(function() {
                        $.ui.history('go', 'hide'); 
                        return false;
                    });
                    
                $.ui.history('enable');
                
                
            });


$(document).ready(function() {
    fixLinks();
    $().ajaxComplete(function(evt, request, settings) {
        fixLinks();
    });
    $().ajaxError(function(event, request, settings) {
        $("#wiki_content").text('There was an error loading this WikiDoc.');
        $("#wiki_content").load('/doc/error');
    });
});

/*********************************************************
   Check all anchor links within loaded WikiDoc pages.
   If they link to other WikiDoc pages, 1) load the /bare 
   version, and 2) load within the DIV, and don't browse 
   the user away from the edit page.
*********************************************************/
function fixLinks() {
    $("#wiki_content a").each(function() {
        if ($(this).attr("href") != undefined) {
            $(this).addClass("remote");
            if(window.location.href.split("/")[3] == "doc") {
                var oldtarget = $(this).attr("href");
                $(this).click(function(e) {
                    e.preventDefault();
                    $("#wiki_content").empty();
                    jQuery(function($) {
                        $("#wiki_content").load(oldtarget.replace('/doc/', '/doc/bare/'));
                        fixLinks();
                    });
                });
            }
        }
    });
}
