/* Small helpers for viewing artist release listings */

$(document).ready(function() {
    /* Turn on table sorting */
    $(".releases").tablesorter({
        textExtraction: "complex",
    });
    /* Remove, then re-zebra stripe the rows */
    $(".releases").each(function() {
        $(this).bind("sortStart",function() {
            jQuery(this).find(".odd").each(function() {
                $(this).removeClass("odd");
            });
        }).bind("sortEnd",function() {
            jQuery(this).find("tr:odd").each(function() {
                $(this).addClass("odd");
            });
        });
    });
});

