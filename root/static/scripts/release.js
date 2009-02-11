/* Small helpers for viewing releases */

$(document).ready(function() {
    /* Add the Show / Hide Disc IDs options and functionality */
    $('#toggle_discids').click(function() {
        $('#release_discids').slideToggle("normal", function() {
            $('#toggle_discids').text(this.style.display == 'none' ?
                                      'Show Disc IDs' :
                                      'Hide Disc IDs');
        });
        return false;
    });

    $('#toggle_artists').click(function() {
        $('.release_tracks .artist').toggle();
        return false;
    });
    /* Coverart explode / implode on user click */
    $(".artwork > img").click(function() { 
        $(".release_top:eq("+0+")").css("overflow", "visible");
        if($(this).css('width') == "270px") {
            $(this).animate({ 
                height: "55pt"
            }, 500 );
            $(this).css({
                width: '',
                maxHeight: '55pt'
            });
            $(".releasetags:eq("+0+")").css('height','');
        } else {
            $(this).css({
                maxHeight: '',
                width: '',
                height: ''
            });
            $(".releasetags:eq("+0+")").css('height','160pt');
            $(this).animate({ 
                width: "270px"
            }, 500 );
        }
    });
});
