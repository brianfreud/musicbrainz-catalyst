$(function() {
   /*******************************************************************************************
    *  Attaches handlers to artist and label fields on editing forms for lookup functionality.
    *
    *******************************************************************************************/
    if (typeof(filelocs) == "undefined") { // The main editing script (es_main.js) isn't loaded; ie, we're not on an editing form.
        filelocs       = {
                             serverBase       : location.href.split("/")[2],   // Base server url
                             serverJSON       : "/ws/priv/"                    // MusicBrainz JSON server path
                         };
    }
    var LOADING        = {
                             ERRORIMAGE   : "/static/images/scripts/120px-Gnome-dialog-warning.png",
                             ERRORTEXT    : text.LookupError,
                             ERRORALT     : text.ErrorTitle,
                             IMAGE        : "/static/images/scripts/loading.gif",
                             NOTHINGTEXT  : text.NothingToLookUp,
                             NORESULTS    : text.NoResults,
                             TEXT         : text.Loading
                         },
        CLASS          = {
                             ADD_ENTITY_BOX  : "lookupSelectAddEntityBox",
                             ADD_ENTITY_BTN  : "lookupSelectAddEntityButton",
                             ADD_ENTITY_FORM : "lookupSelectAddEntityForm",
                             ADD_ENTITY_ROW  : "lookupSelectAddEntityRow",
                             BUTTON_BOX      : "lookupSelectButtonBox",
                             CENTER          : "lookupSelectCenter",
                             HIDDEN          : "hidden",
                             LABELS          : "release_event_label",
                             LOOKUP_BOX      : "lookupBox",
                             LOOKUP_ERROR    : "lookupSelectError",
                             LOOKUP_RESULT   : "lookupSelectResult",
                             MAIN_BOX        : "lookupSelect",
                             MOUSE_NOT_OVER  : "lookupSelectMouseNotOver",
                             MOUSE_OVER      : "lookupSelectMouseOver",
                             NO_LOOKUP       : "lookupSelectNoLookup",
                             NORESULTS       : "lookupSelectNoResults",
                             NOW_SEARCHING   : "lookupSelectLoading",
                             RESULTS_BOX     : "lookupSelectResultList"
                         },
        HTML           = {
                             BUTTON            : '<input type="button" value="',
                             CLOSE_QUOTE       : '">',
                             CLOSE_QUOTE_SLASH : '" />',
                             DIV_OPEN          : '<div>',
                             DIV_CLASS_OPEN    : '<div class="',
                             DIV_CLOSE         : '</div>',
                             IMG               : '<img alt="',
                             NBSP              : '&nbsp;',
                             SMALL_OPEN        : '<small>',
                             SMALL_CLOSE       : '</small>',
                             SPAN_OPEN         : '<span>',
                             SPAN_CLOSE        : '</span>',
                             SPACE             : ' ',
                             ATTR_SRC          : '" src="'
                         },
        htmlLabel      = function(element, text) {
                                                     return '<label for="lookup-' + element + '">' + text + '</label>';
                                                 },
        htmlInput      = function(element, size) {
                                                     if (typeof(size) != "undefined") {
                                                         return '<input type="text" size="' + size + '" id="lookup-' + element +
                                                                '" style="width:' + size + 'em!important" class="' + CLASS.CENTER + '" />';
                                                     } else {
                                                         return '<input type="text" id="lookup-' + element + '" />';
                                                     }
                                                 },
        htmlOption     = function(value, text) {
                                                   return '<option value="' + value + '">' + text + '</option>';
                                               },
        ENTITY_ROW     = HTML.DIV_CLASS_OPEN + CLASS.ADD_ENTITY_ROW + HTML.CLOSE_QUOTE,
        LOOKUP_BOX1    = HTML.DIV_CLASS_OPEN + CLASS.MAIN_BOX + HTML.CLOSE_QUOTE +
                             HTML.DIV_CLASS_OPEN + '" id="lookup-main-box' + HTML.CLOSE_QUOTE +
                                 HTML.DIV_CLASS_OPEN + CLASS.RESULTS_BOX + HTML.CLOSE_QUOTE +
                                     HTML.DIV_CLASS_OPEN + CLASS.NOW_SEARCHING + HTML.SPACE + CLASS.HIDDEN + HTML.CLOSE_QUOTE +
                                         HTML.DIV_OPEN +
                                             HTML.IMG + LOADING.TEXT + HTML.ATTR_SRC + LOADING.IMAGE + HTML.CLOSE_QUOTE_SLASH +
                                             HTML.NBSP + LOADING.TEXT +
                                         HTML.DIV_CLOSE +
                                     HTML.DIV_CLOSE +
                                     HTML.DIV_CLASS_OPEN + CLASS.NO_LOOKUP + HTML.SPACE + CLASS.NOW_SEARCHING + HTML.SPACE + CLASS.HIDDEN + HTML.CLOSE_QUOTE +
                                         HTML.DIV_OPEN +
                                             HTML.IMG + LOADING.ERRORALT + HTML.ATTR_SRC + LOADING.ERRORIMAGE + HTML.CLOSE_QUOTE_SLASH +
                                             HTML.NBSP + LOADING.NOTHINGTEXT +
                                         HTML.DIV_CLOSE +
                                     HTML.DIV_CLOSE +
                                     HTML.DIV_CLASS_OPEN + CLASS.LOOKUP_ERROR + HTML.SPACE + CLASS.NOW_SEARCHING + HTML.SPACE + CLASS.HIDDEN + HTML.CLOSE_QUOTE +
                                         HTML.DIV_OPEN +
                                             HTML.IMG + LOADING.ERRORALT + HTML.ATTR_SRC + LOADING.ERRORIMAGE + HTML.CLOSE_QUOTE_SLASH +
                                             HTML.NBSP + LOADING.ERRORTEXT +
                                         HTML.DIV_CLOSE +
                                     HTML.DIV_CLOSE +
                                     HTML.DIV_CLASS_OPEN + CLASS.NORESULTS + HTML.SPACE + CLASS.NOW_SEARCHING + HTML.SPACE + CLASS.HIDDEN + HTML.CLOSE_QUOTE +
                                         HTML.DIV_OPEN +
                                             LOADING.NORESULTS +
                                         HTML.DIV_CLOSE +
                                     HTML.DIV_CLOSE +
                                 HTML.DIV_CLOSE +
                                 HTML.DIV_CLASS_OPEN + CLASS.BUTTON_BOX + HTML.CLOSE_QUOTE +
                                     HTML.DIV_OPEN +
                                         HTML.BUTTON + text.Lookup + '" id="lookup-entity-button' + HTML.CLOSE_QUOTE +
                                     HTML.DIV_CLOSE +
                                     HTML.DIV_OPEN +
                                         HTML.BUTTON + '" id="lookup-new-entity" class="' + CLASS.HIDDEN + HTML.CLOSE_QUOTE +
                                     HTML.DIV_CLOSE +
                                 HTML.DIV_CLOSE +
                             HTML.DIV_CLOSE +
                             HTML.DIV_CLASS_OPEN + CLASS.ADD_ENTITY_BOX + HTML.SPACE + CLASS.HIDDEN + HTML.CLOSE_QUOTE +
                                 HTML.DIV_CLASS_OPEN + '" id="lookup-new-entity-header' + HTML.CLOSE_QUOTE +
                                 HTML.DIV_CLOSE +
                                 HTML.DIV_CLASS_OPEN + CLASS.ADD_ENTITY_FORM + HTML.CLOSE_QUOTE +
                                     ENTITY_ROW +
                                         htmlLabel("-type", text.Type) +
                                         '<select id="lookup-type">',
        LOOKUP_BOX2_A  =                     htmlOption(0, text.Unknown) + htmlOption(1, text.Person) + htmlOption(2, text.Group),
        LOOKUP_BOX2_L  =                     htmlOption(0, text.Unknown) + htmlOption(1, text.Distributor) + htmlOption(2, text.Holding) +
                                             htmlOption(3, text.Production) + htmlOption(4, HTML.NBSP + HTML.NBSP + text.OriginalProduction) +
                                             htmlOption(5, HTML.NBSP + HTML.NBSP + text.BootlegProduction) +
                                             htmlOption(6, HTML.NBSP + HTML.NBSP + text.ReissueProduction) + htmlOption(7, text.Publisher),
        LOOKUP_BOX3    =                 '</select>' + 
                                     HTML.DIV_CLOSE +
                                     ENTITY_ROW +
                                         htmlLabel("name", text.Name) + htmlInput("name") + 
                                     HTML.DIV_CLOSE + 
                                     ENTITY_ROW +
                                         htmlLabel("sortname", text.SortName) + htmlInput("sortname") + 
                                     HTML.DIV_CLOSE + 
                                     ENTITY_ROW +
                                         htmlLabel("resolution", text.Comment) + htmlInput("resolution") + 
                                     HTML.DIV_CLOSE + 
                                     ENTITY_ROW,
        LOOKUP_BOX4_L  =                 htmlLabel("label-code", text.LabelCode) + htmlInput("label-code", 5) +
                                     HTML.DIV_CLOSE + 
                                     ENTITY_ROW,
        LOOKUP_BOX5    =                 htmlLabel("start-year", text.StartDate) + htmlInput("start-year", 4) + 
                                                                                   htmlInput("start-month", 2) + 
                                                                                   htmlInput("start-day", 2) +
                                     HTML.DIV_CLOSE + 
                                     ENTITY_ROW +
                                         htmlLabel("end-year", text.EndDate) + htmlInput("end-year", 4) + 
                                                                               htmlInput("end-month", 2) + 
                                                                               htmlInput("end-day", 2) +
                                     HTML.DIV_CLOSE + 
                                     ENTITY_ROW +
                                         htmlLabel("editnote", text.EditNote) + '<textarea id="lookup-edit-note" rows="4"></textarea>' +
                                     HTML.DIV_CLOSE + 
                                     HTML.DIV_CLASS_OPEN + CLASS.CENTER + HTML.SPACE + CLASS.ADD_ENTITY_ROW + HTML.CLOSE_QUOTE + 
                                         '<input type="button" id="lookup-new-entity-submit" class="' + CLASS.ADD_ENTITY_BTN +
                                         HTML.CLOSE_QUOTE + 
                                     HTML.DIV_CLOSE + 
                                     HTML.DIV_CLASS_OPEN + CLASS.CENTER + HTML.SPACE + CLASS.ADD_ENTITY_ROW + HTML.CLOSE_QUOTE + 
                                         '<strong><span id="lookup-message">' +
                                             text.ClickCaution + 
                                         HTML.SPAN_CLOSE + '</strong>' + 
                                     HTML.DIV_CLOSE + 
                                 HTML.DIV_CLOSE + 
                             HTML.DIV_CLOSE + 
                         HTML.DIV_CLOSE,
        LOOKUP_BOX_ARTIST = LOOKUP_BOX1 + LOOKUP_BOX2_A + LOOKUP_BOX3 + LOOKUP_BOX5,
        LOOKUP_BOX_LABEL  = LOOKUP_BOX1 + LOOKUP_BOX2_L + LOOKUP_BOX3 + LOOKUP_BOX4_L + LOOKUP_BOX5,
        currentField   = "",
        resultsArray   = [],
        bottomPixel    = function(element) {  // Return the bottom pixel of the field to be looked up.
                                               return $(element).offset().top + $(element).outerHeight();
                                           },
        rightPixel     = function(element) {  // Return the bottom pixel of the field to be looked up.
                                               return $(element).offset().left + $(element).outerWidth();
                                           },
        positionBox    = function(element) {  // Position the lookup box flush with the lower left corner of the field to be looked up.
                                               $("." + CLASS.MAIN_BOX).css({
                                                                               top  : bottomPixel(element) - 1,
                                                                               left : $(element).offset().left + 1
                                                                           });
                                           },
        positionButton = function() {
                                        $("#lookup-entity-button").parent().parent().attr("align", "center");
                                    },
        giveError      = function(msgtext) {
                                            $("#lookup-message").css("color", "red")
                                                                .text(text.Error + HTML.SPACE + msgtext);
                                        },
        giveInfo      = function(msgtext) {
                                            $("#lookup-message").css("color", "black")
                                                                .html(msgtext);
                                        },
        submitNewEntityEdit = function(element, type) {
                                                 var labelcode   = "",
                                                     end_day     = $("#lookup-end-day").val(),
                                                     end_month   = $("#lookup-end-month").val(),
                                                     end_year    = $("#lookup-end-year").val(),
                                                     entity_type = $("#lookup-type").val(),
                                                     start_day   = $("#lookup-start-day").val(),
                                                     start_month = $("#lookup-start-month").val(),
                                                     start_year  = $("#lookup-start-year").val(),
                                                     sortname    = $("#lookup-sortname").val();
                                                 if (type == "label") {
                                                     labelcode = $("#lookup-label-code").val();
                                                 }
                                                 $.post("http://" + filelocs.serverBase + "/" + type + "/create",
                                                     {
                                        /* artists */    "artist_type"      : entity_type,
                                        /* labels  */    "begin_date.day"   : start_day,
                                        /* labels  */    "begin_date.month" : start_month,
                                        /* labels  */    "begin_date.year"  : start_year,
                                        /* artists */    "do_add_artist"    : "Enter+Edit",
                                        /* labels  */    "do_add_label"     : "Enter+Edit",
                                        /* both    */    "edit_note"        : $("#lookup-edit-note").val(),
                                        /* artists */    "end.day"          : end_day,
                                        /* artists */    "end.month"        : end_month,
                                        /* artists */    "end.year"         : end_year,
                                        /* labels  */    "end_date.day"     : end_day,
                                        /* labels  */    "end_date.month"   : end_month,
                                        /* labels  */    "end_date.year"    : end_year,
                                        /* labels  */    "label_code"       : labelcode,
                                        /* both    */    "name"             : $("#lookup-name").val(),
                                        /* both    */    "resolution"       : $("#lookup-resolution").val(),
                                        /* artists */    "sortname"         : sortname,
                                        /* labels  */    "sort_name"        : $("#lookup-sortname").val(),
                                        /* artists */    "start.day"        : start_day,
                                        /* artists */    "start.month"      : start_month,
                                        /* artists */    "start.year"       : start_year,
                                        /* labels  */    "type"             : entity_type
                                                     },
                                                     function (data, textStatus) {
                                                         if (textStatus != "success") {
                                                             giveInfo(text.SubmittingEditError);
                                                         } else {
                                                                $(element).val($("#lookup-name").val());
                                                                $("." + CLASS.LOOKUP_RESULT).remove();
                                                                $("#lookup-entity-button").removeClass(CLASS.HIDDEN);
                                                                $("#lookup-new-entity").addClass(CLASS.HIDDEN);
                                                                $("#lookup-main-box").removeClass(CLASS.HIDDEN);
                                                                $("." + CLASS.ADD_ENTITY_BOX).addClass(CLASS.HIDDEN);
                                                                $("#lookup-entity-button").click();
                                                         }
                                                     }
                                                 );
                                             },
        setMouseEvents = function(element, type) {  // We can't use a css :hover, as that breaks in IE6.
                                                     $("." + CLASS.LOOKUP_RESULT).each(
                                                         function() {
                                                             $(this).mouseover(
                                                                 function() {
                                                                     $(this).removeClass(CLASS.MOUSE_NOT_OVER);
                                                                     $(this).addClass(CLASS.MOUSE_OVER);
                                                                 }
                                                             ).mouseout(
                                                                 function() {
                                                                     $(this).removeClass(CLASS.MOUSE_OVER);
                                                                     $(this).addClass(CLASS.MOUSE_NOT_OVER);
                                                                 }
                                                             ).click(
// TODO: Update this next to populate the correct field, once switch.tt is updated to work again (and that field again even exists).
                                                                 function() {
                                                                     $(element).val($(this).attr("id"));
                                                                     removeLookup();
                                                                 }
                                                             ).addClass(CLASS.MOUSE_NOT_OVER);
                                                         }
                                                     );
                                                     $("#lookup-new-entity").click(
                                                         function() {
                                                                        $("#lookup-main-box").addClass(CLASS.HIDDEN);
                                                                        $("." + CLASS.ADD_ENTITY_BOX).removeClass(CLASS.HIDDEN);
                                                                        $("#lookup-name").val($(element).val());
                                                                    }
                                                     );
                                                     $("#lookup-new-entity-submit").click(
                                                         function() {
                                                             /* Validate the data. */
                                                             if ($("#lookup-name").val().length === 0) {  // empty name field
                                                                 giveError(text.RequiredName);
                                                             } else if ($("#lookup-sortname").val().length === 0) {  // empty sortname field
                                                                 giveError(text.RequiredSortName);
                                                             } else if (type == "label") {
                                                                 if ($("#lookup-label-code").val().length > 0 &&  // invalid label code
                                                                     !(/^\d{4,5}$/).test($("#lookup-label-code").val())) {
                                                                     giveError(text.InvalidLabelCode);
                                                                 }
                                                             } else if ($("#lookup-end-year").val() > $("#lookup-start-year").val()) {  // time running backwards
                                                                 giveError(text.TimeBackwards);
                                                             } else if (jQuery.inArray($("#lookup-name").val(), resultsArray) > -1 &&
                                                                         $("#lookup-resolution").val().length === 0) {  // Disambig required, but disambig field is empty
                                                                 if (type == "artist") {
                                                                   giveError(text.RequiredDisambigA + HTML.SPACE + text.RequiredDisambigZ);
                                                                 } else {
                                                                   giveError(text.RequiredDisambigL + HTML.SPACE + text.RequiredDisambigZ);
                                                                 }
                                                             /* The data validated, submit the edit. */
                                                             } else {
                                                                        giveInfo(HTML.IMG + LOADING.TEXT + HTML.ATTR_SRC + LOADING.IMAGE + 
                                                                                 HTML.CLOSE_QUOTE_SLASH + HTML.SPAN_OPEN + HTML.NBSP + 
                                                                                 text.SubmittingEdit + HTML.SPAN_CLOSE);
                                                                        submitNewEntityEdit(element, type);
                                                             }
                                                         }
                                                     );
                                                 },
        /* Remove the lookup box. */
        removeLookup = function() {
                                      $("#lookup-entity-button").unbind();
                                      $("." + CLASS.MAIN_BOX).remove();
                                  },
        addResult      = function(i, result) {
                                                 var resultText = result.name.toString();
                                                 resultsArray.push(resultText);
                                                 if (typeof(result.resolution) != "undefined") {
                                                     if (null !== result.resolution) {
                                                         var disambigulation = result.resolution.toString();
                                                         if (disambigulation.length > 0) {
                                                             resultText += HTML.SMALL_OPEN + " (" + disambigulation + ")" + HTML.SMALL_CLOSE;
                                                         }
                                                     }
                                                 }
                                                 resultText = HTML.DIV_CLASS_OPEN + CLASS.LOOKUP_RESULT + '" id="result' + i.toString() + HTML.CLOSE_QUOTE +
                                                                   HTML.SPAN_OPEN +
                                                                       resultText +
                                                                   HTML.SPAN_CLOSE +
                                                               HTML.DIV_CLOSE;
                                                 $($("." + CLASS.RESULTS_BOX)[0]).append(resultText);
                                                 $('#result' + i.toString()).attr("id", result.id);
                                             },
        /* Attach the lookup to a click on the lookup button. */
        attachBtnEvent = function(element, type) {
                                        $("#lookup-entity-button").click(
                                            function(event) {
                                                if ($(element).val().length > 0) {
                                                    $("." + CLASS.NOW_SEARCHING).removeClass(CLASS.HIDDEN);
                                                    $("." + CLASS.NO_LOOKUP + ", ." + CLASS.LOOKUP_ERROR + ", ." + CLASS.NORESULTS).addClass(CLASS.HIDDEN);
                                                    query = 'http://' +
                                                            filelocs.serverBase +
                                                            filelocs.serverJSON +
                                                            'lookup?entitytype=' +
                                                            type +
                                                            '&query=' +
                                                            encodeURI($(element).val());
                                                    $.getJSON(query,
                                                        function(data, textStatus){
                                                            $("." + CLASS.NOW_SEARCHING).addClass(CLASS.HIDDEN);
                                                            if (textStatus == "timeout" || textStatus == "error") {
                                                                $("." + CLASS.LOOKUP_ERROR).removeClass(CLASS.HIDDEN);
                                                            } else {
                                                                if(data.results.length === 0) {
                                                                    $("." + CLASS.NORESULTS).removeClass(CLASS.HIDDEN);
                                                                } else {
                                                                    jQuery.each(data.results,
                                                                        function(i, result) {
                                                                                                addResult(i, result[type]);
                                                                                            }
                                                                    );
                                                                }
                                                                setMouseEvents(element, type);
                                                                $("#lookup-new-entity").removeClass(CLASS.HIDDEN);
                                                                $("#lookup-entity-button").addClass(CLASS.HIDDEN);
                                                            }
                                                        }
                                                    );
                                                } else {
                                                    $("." + CLASS.NO_LOOKUP).removeClass(CLASS.HIDDEN);
                                                }
                                                event.stopPropagation();
                                            }
                                        );
                                    },
        setUpText      = function(textA, textB) {
                                                    $("#lookup-new-entity").attr("value", textA);
                                                    $("#lookup-new-entity-header").html(HTML.NBSP + textA);
                                                    $("#lookup-new-entity-submit").attr("value", textB);
                                                },
        /* Create and attach a new lookup box. */
        makeLookup     = function(element, type) {
                                                 currentField = element;
                                                 removeLookup();
                                                 /* Break out of the label's overlabel div.  (Otherwise, the positioning
                                                    would be relative to the overlabel div, not the document body.) */
                                                 if ($(element).attr("class") == CLASS.LABELS) {
                                                     $(element).parent().after(LOOKUP_BOX_LABEL);
                                                 } else {
                                                     $(element).after(LOOKUP_BOX_ARTIST);
                                                 }
                                                 positionBox(element);
                                                 positionButton();
                                                 attachBtnEvent(element, type);
                                                 if (type == "artist") {
                                                     setUpText(text.AddANewArtist, text.AddArtist);
                                                 } else if (type == "label") {
                                                     setUpText(text.AddANewLabel, text.AddLabel);
                                                 }
                                             };
    /* Remove the lookup box on a click, unless the click is in the current parent form field, or within the lookup div itself. */
    $("*").click(
        function(event) {
            if ($("." + CLASS.MAIN_BOX).length > 0) {
                var searchbox = $($("." + CLASS.MAIN_BOX)[0]);
                if (currentField !== "" && event.target != currentField) {
                    if (event.pageX < $(searchbox).offset().left ||
                        event.pageY > bottomPixel(searchbox) ||
                        event.pageX > rightPixel(searchbox) ||
                        event.pageY < $(searchbox).offset().top)
                    {
                        removeLookup();
                    }
                }
            }
            event.stopPropagation();
        }
    );
    /* Attach the creation of a new lookup box to track artist fields. */
    if (typeof($artistGroup) != "undefined") {
        $($artistGroup).each(
            function() {
                $(this).click(
                    function() {
                        makeLookup(this, "artist");
                    }
                );
            }
        );
    }
    /* Attach the creation of a new lookup box to the release artist field. */
    $(".release-artist").each(
        function() {
            $(this).click(
                function() {
                    makeLookup(this, "artist");
                }
            );
        }
    );
    /* Attach the creation of a new lookup box to label field(s). */
    if (typeof($labelGroup) != "undefined") {
        $($labelGroup).each(
            function() {
                $(this).click(
                    function() {
                        makeLookup(this, "label");
                    }
                );
            }
        );
    }
    /* Pass a click on a label field's overlabel on to the label input itself. */
    $('label[id$="-label-label"]').each(
        function() {
            $(this).click(
                function() {
                    $(this + ' + input[class="release_event_label"]').click();
                }
            );
        }
    );
   /************************************************************
    *  Add switch toggle functionality for text fields
    *  that can be "locked".  Invoke with TT code such as:
    *      [%- INCLUDE 'forms/switchable.tt' object="artist_$i"
    *       field=form.field("artist_$i") label=l('Artist') -%]
    ************************************************************/
    $("img, .switchable").bind("click",
        function(){
            if ($(this).attr("src") == "/static/images/release_editor/edit-off.gif") {
                $(this).attr({
                    src: "/static/images/release_editor/edit-on.gif",
                    title: "Change",
                    alt: "Change"
                });
                $(this).nextAll("div").css("display", "inline");
            } else {
                $(this).attr({
                    src: "/static/images/release_editor/edit-off.gif",
                    title: "Set",
                    alt: "Set"
                });
                $(this).nextAll("div").css("display", "none");
            }
            $(this).nextAll("span").toggle();
            $(this).nextAll("input").toggle();
        }
    );
});
