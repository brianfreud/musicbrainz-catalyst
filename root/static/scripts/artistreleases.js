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


/* Breaks on Live and Other release title at http://brianfreud.info:3001/artist/183d6ef6-e161-47ff-9085-063c8b897e97?show_all=1 */
