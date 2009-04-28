$(function() {
    /* Insert the divs for the edit note toggler and the approve checkbox. */
    $('div[name="vote-summary"]').after('<div name="vote-toggle-note" /><div name="vote-approve" />');

    var colors = {
            "darkgreen"  : "#437C17",
            "green"      : "#EEFFEE",
            "red"        : "#FFEEEE",
            "yellow"     : "#FFFFCC",
            "darkred"    : "#F62817",
            "white"      : "white"
        },
        noteToggles = $('div[name="vote-toggle-note"]'),
        isAutoEditor = false,
        editTypes = [],
        editRows = $("table.moderation_list tbody tr.seperator, table.moderation_list tbody tr.edit-info, table.moderation_list tbody tr.edit-actions, table.moderation_list tbody tr.edit-notes"),
        setCellColors = function() {
            /* Clear the background color for an unchecked Cancel checkbox. */
            $('input[name^="vote_"]:not(:checked)').closest('td').parent().closest('td').css("background-color", colors.white);
            var voteRadioGroups = $('input[name^="vote_"]:checked');
            $(voteRadioGroups).each(function(counter) {
                var bgColor;
                switch ($(this).val()) {
                    case "p":  // Approve
                        bgColor = colors.darkgreen;
                        break;
                    case "y":  // Yes
                        bgColor = colors.green;
                        break;
                    case "n":  // No
                        bgColor = colors.red;
                        break;
                    case "a":  // Abstain
                        bgColor = colors.yellow;
                        break;
                    case "c":  // Cancel
                        bgColor = colors.darkred;
                        break;
                    default:
                        bgColor = colors.white;
                }
                $(this).closest('td').parent().closest('td').css("background-color", bgColor);
            });
        },
        /* displayedRow ( element ): Returns true only if edit row is currently displayed.  */
        displayedRow = function(element, row) {
            if (typeof(row) == "undefined") {
                row = "edit-actions";
            }
            if ($(element).closest("." + row).css("display") != "none") {
                return true;
            } else {
                return false;
            }
        }, voteAllTD = function(transText, voteText) {
        return '<td style="width: 25%;">' +
                   '<input type="radio" name="vote_all" id="vote-all-' + voteText + '" />' +
                   '<br />' +
                   '<label for="vote-all-' + voteText + '">' +
                       transText +
                   '</label>' +
               '</td>';
    }, resetVoteControls = function() {
        $('input[name="approve-edit-checkbox"]').attr("checked", "");  // Uncheck all approve checkboxes.
        $('input[name="approve-edit-checkbox"]').closest('tr')
                                                .next()
                                                .children('td.vote_choice')
                                                .children()
                                                .children()
                                                .children()
                                                .children()
                                                .show(); //  Re-show the voting radio controls.
        $('input[id^="id_vote_app_"]').parent().hide(); // Re-hide the Approve radio buttons.
        setCellColors();  // Reset the background colors.
    }, setCheckedRadio = function(vote) {
        $('input[id^="id_vote_' + vote + '_"]').each(function() {
            if (displayedRow(this)) {  // Only change votes for edits displayed under the current filter.
                $(this).attr("checked", "checked");
            }
        });
        resetVoteControls();
    }, setCheckedButton = function(filter, row) {
        $('input[' + filter + ']').each(function() {
            if (!$(this).attr("checked")) {
                if (displayedRow(this, row)) {  // Only change votes for edits displayed under the current filter.
                    $(this).click();
                    $(this).triggerHandler("change");
                }
            }
        });
    },
    /* unique ( array ) : Input an array, returns an uniqued version of that array. */
    /* From http://www.martienus.com/code/javascript-remove-duplicates-from-array.html */
    unique = function(a) {
        var r = [];
        o: for (var i = 0, n = a.length; i < n; i++) {
            for (var x = 0, y = r.length; x < y; x++) {
                if (r[x] == a[i]) {
                    continue o;
                }
            }
            r[r.length] = a[i];
        }
        return r;
    };

    /* Set the cell background colors for initial vote values. */
    setCellColors();

    /* Test for the presence of any Approve radio options to determine if this editor is an autoeditor. */
    if ($('input[id^="id_vote_app_"]').length > 0) {
        isAutoEditor = true;
    }

    /* Hide the add edit note <tr>s. */
    $('tr[id^="add-edit-note-"]').hide();

    $(noteToggles).each(function(count) {
        /* Set a variable within the data store for each element to store the current state. */
        /* Much faster to access than reading in the current .text() value. */
        $(this).data("state", "off")
               .text(text.EditNoteAdd)
               .css({
                   "color"  : "#534D8B",  // Same color as defined in layout.css for <a>.
                   "cursor" : "pointer"
               })
               /* Set the click handler for each link, to turn on or off the edit note field for that edit. */
               .bind("click", function() {
                   var commentRow = $(noteToggles[count]).closest('tr')
                                                         .next()
                                                         .next()
                                                         .children()
                                                         .children()
                                                         .children()
                                                         .children('tr[id^="add-edit-note-"]');
                   if ($(this).data("state")  == "off") {
                       $(this).data("state", "on");  // Update the current state in the data store.
                       $(this).text(text.EditNoteDelete);  // Change the edit note toggle's text.
                       $(commentRow).show();  // Show the new edit note row.
                   } else {
                       $(this).data("state", "off");  // Update the current state in the data store.
                       $(this).text(text.EditNoteAdd);  // Change the edit note toggle's text.
                       $(commentRow).hide();  // Hide the new edit note row.
                       $(commentRow.children()[1]).children('textarea')
                                                  .val("");  // Clear anything that's been entered into the textarea.
                   }
               });
    });

    /* Add checkboxes for Approve. */
    $('table.vote_choice input[id^="id_vote_app_"]').each(function(counter) {
        $(this).parents("tr")
               .parents("tr")
               .prev()
               .children("td.actions")
               .children('div[name="vote-approve"]')
               .html(
                   '<input type="checkbox" name="approve-edit-checkbox" id="edit-approve-' + counter + '" />' +
                   '<label class="optional" for="edit-approve-' + counter + '">' +
                       text.ApproveEdit +
                   '</label>'
               );
    });

    /* Hide the Approve radio buttons. */
    $('input[id^="id_vote_app_"]').parent().hide();

    $('input[name="approve-edit-checkbox"]').each(function(counter) {
        var votingRadios = $('input[name="approve-edit-checkbox"]:eq(' + counter + ')').closest('tr')
                                                                                       .next()
                                                                                       .children('td.vote_choice')
                                                                                       .children()
                                                                                       .children()
                                                                                       .children()
                                                                                       .children();
        /* Bind a change in the value of the approve checkbox to the selection of the approve radio button. */
        $(this).change(function() {
            if ($(this).attr("checked") === true) {
                $(votingRadios).children('input[id^="id_vote_app_"]').attr("checked", "checked");
                $(votingRadios).hide();
                setCellColors();  // Re-set the background colors.
            } else {
                $(votingRadios).children('input[id^="id_vote_nv_"]').attr("checked", "checked");
                $(votingRadios).show();
                $('input[id^="id_vote_app_"]').parent().hide(); // Re-hide the Approve radio button.
                setCellColors();  // Re-set the background colors.
            }
        });
    });

    /* Bind a change in the value of the radio buttons to update the background colors. */
    $('input[name^="vote_"]').each(function() {
        $(this).change(function() {
            setCellColors();  // Re-set the background colors.
        });
    });

    /* Insert the vote all controls. */
    $("tr.seperator:first").before('<tr style="border-left: 0!important;">' +
                                       '<td style="vertical-align: middle;" colspan="2">' +
                                           '<div style="float: left;" id="edits-div-filter">' +
                                           '</div>' +
                                           '<div style="float: right;">' +
                                               '<strong>' +
                                                   text.AllVotes +
                                                   '&nbsp;' +
                                               '</strong>' +
                                           '</div>' +
                                       '</td>' +
                                       '<td style="border-top: 1px solid black; border-left: 1px solid black; border-right: 1px solid black;">' +
                                           '<table class="vote_choice" style="width: 100%;">' +
                                               '<tbody>' +
                                                   '<tr id="vote-all-radios />' +
                                               '</tbody>' +
                                           '</table>' +
                                       '</td>' +
                                   '</tr>');
    $("#vote-all-radios").before('<tr id="vote-all-buttons />');
    $("#vote-all-buttons").html('<td colspan="4">' +
                                    '<input type="button" id="vote-all-buttons-approve" value="' + text.ApproveAll + '" />' +
                                    '<input type="button" id="vote-all-buttons-cancel" value="' + text.CancelAll + '" />' +
                                '</td>');
    $("#vote-all-radios").html(voteAllTD(text.Yes, "yes") +
                               voteAllTD(text.No, "no") +
                               voteAllTD(text.Abstain, "abstain") +
                               voteAllTD(text.NoVote, "novote"));

    /* Bind the vote all controls. */
    $("#vote-all-yes").click(function() {
        setCheckedRadio("yes");
    });
    $("#vote-all-no").click(function() {
        setCheckedRadio("no");
    });
    $("#vote-all-abstain").click(function() {
        setCheckedRadio("abs");
    });
    $("#vote-all-novote").click(function() {
        setCheckedRadio("nv");
    });
    if (isAutoEditor) {
        $("#vote-all-buttons-approve").click(function() {
            setCheckedButton('name="approve-edit-checkbox"', "edit-info");
        });
    } else {
        $("#vote-all-buttons-approve").remove();
    }
    $("#vote-all-buttons-cancel").click(function() {
        setCheckedButton('id^="id_vote_cancel_"', "edit-actions");
    });

    /* Get an unique array of all edit types on the current page. */
    $("tr.seperator").each(function() {
        editTypes[editTypes.length] = $(this).attr("name");
    });
    editTypes = unique(editTypes).sort();  // Unique the array, then sort it alphanumerically.

    /* Create the edit filter drop-down. */
    $("#edits-div-filter").html(text.FilterEdits + '&nbsp;<select id="edit-filter-select" />');
    $("#edit-filter-select").addOption("showall", text.EditsShowAll);
    jQuery.each(editTypes, function(i) {
        $("#edit-filter-select").addOption(editTypes[i], editTypes[i].replace(/_/g," "), false);
    });

    /* Attach filtering action to a change in the filter drop-down. */
    $("#edit-filter-select").change(function() {
        var selectedFilter = $("#edit-filter-select").selectedValues()[0];
        if (selectedFilter == "showall") {
                $("table.moderation_list tr").show();
        } else {
            $(editRows).each(function() {
                if ($(this).attr("name") == selectedFilter) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        }
    });
});
