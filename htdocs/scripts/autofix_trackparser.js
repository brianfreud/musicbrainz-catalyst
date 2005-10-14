trackParser = {
	config : new Array(),
		// configuration member variable
	configCheckBoxes : [
					["tp_hasAlbumTitle", 0, 
					 "First line is the album title", 
					 "First line is not parsed for a track title"],
					["tp_hasTrackNumber", 1, 
					 "Track titles start with a number",
					 "Lines which do not start with a number are skipped"],
					["tp_hasTrackTimes",  1, 
					 "Find track times (?:??)", 
					 "Round parantheses with numbers, : and ? in it get replaced"]
				],
		// config GUI values
	testCases : [
					[0, 'SA Album <a href="http://www.discogs.com/release/345107">The Prodigy - Always Outnumbered, Never Outgunned</a>'],
					[0, "Discogs", "1   Spitfire (5:08)\n	Vocals - Juliette Lewis\n2   Girls (4:07)\n	Vocals - Ping Pong Bitches\n3   Memphis Bells (4:28)\n	Vocals - Princess Superstar\n4   Get Up Get Off (4:19)\n	Co-producer - Dave Pemberton\n  Vocals - Twista\n5   Hotride (4:36)\n	Vocals - Juliette Lewis\n6   Wake Up Call (4:56)\n	Vocals - Hannah Robinson , Kool Keith , Louise Boone\n7   Action Radar (5:32)\n	Vocals - Louise Boone , Paul 'Dirtcandy' Jackson\n8   Medusa's Path (6:08)\n9   Phoenix (4:38)\n	Vocals - Louise Boone\n10   You'll Be Under My Wheels (3:56)\n	Vocals - Kool Keith\n11   The Way It Is (5:46)\n	Vocals - Louise Boone , Neil McLellan\n12   Shoot Down (4:32)\n	Co-producer - Jan 'Stan' Kybert\n  Featuring - Noel Gallagher\n  Vocals - Liam Gallagher\n13   More Girls (4:26)\n	Vocals - Juliette Lewis\n"],
					[0, "Amazon", "1. Spitfire        \n2. Girls        \n3. Memphis Bells        \n4. Get Up Get Off        \n5. Hot Ride        \n6. Wake Up Call        \n7. Action Radar        \n8. Medusa's Path        \n9. Phoenix        \n10. You'll Be Under My Wheels        \n11. Way It Is        \n12. Shootdown        \n13. More Girls [*]     \n"],
					[0, "Amazon with listen links", "1. Spitfire        Listen Listen Listen\n2. Girls        Listen Listen Listen\n3. Memphis Bells        Listen Listen Listen\n4. Get Up Get Off        Listen Listen Listen\n5. Hot Ride        Listen Listen Listen\n6. Wake Up Call        Listen Listen Listen\n7. Action Radar        Listen Listen Listen\n8. Medusa's Path        Listen Listen Listen\n9. Phoenix        Listen Listen Listen\n10. You'll Be Under My Wheels        Listen Listen Listen\n11. Way It Is        Listen Listen Listen\n12. Shootdown        Listen Listen Listen\n13. More Girls [*]     Listen Listen Listen\n"],


					[1, 'VA album <a href="http://www.discogs.com/release/171251">Factor E</a>'],
					[1, "Discogs (artist - tracktitle separated by 2xDoubleQuote)", "01 DJ Quest  Fuct Beat (Autobots Remix) (5:33) \n    Remix - Autobots  \n02 Factor E  Swing Punk (4:59) \n03 Knick  Kool Down (6:29) \n    Featuring - Factor E  \n04 Factor E  Street Schit (6:01) \n    Featuring - Knick  \n05 DJ Infiniti  Motormouth (Knick & Factor E Remix) (5:06) \n    Featuring - Franco D \n  Remix - Factor E , Knick  \n06 Pimphand Army  Ghetto Dope (4:38) \n07 Autobots  Rocky (Distortionz Remix) (6:29) \n    Remix - Distortionz  \n08 Rick West  The Flow (Factor E vs. Knick Remix) (4:38) \n    Remix - Factor E , Knick  \n09 Autobots  From Outerspace (5:06) \n    Featuring - Prodigy, The  \n10 Pimphand Army  Revenge (5:06) \n11 POF  Freakquency (Factor E Remix) (4:38) \n    Remix - Factor E  \n12 Factor E  CTM (Jackal & Hyde Remix) (5:12) \n    Remix - Jackal & Hyde  \n13 Factor E  Move This Bass (Infiniti Remix) (6:36) \n    Remix - DJ Infiniti  \n14 Knick & Factor E  Bounce Dem (5:06) \n    Featuring - Autobots"],

					[1, 'VA album <a href="http://www.amazon.de/exec/obidos/ASIN/B0000C6IY4/302-0112881-8345672">Best of Cafe Del Mar </a>'],
					[1, "Amazon (artist - tracktitle separated by ' - ')", "1.Paco De Lucia - Entre Dos Aguas\n2.Karen Ramirez - Troubled Girl\n3.Ben Onono - Tatouage Blue\n4.Mari Boine - Gula Gula\n5.Lux - Norther Light\n6.Jose Padilla - Adios Ayer\n7.Lamb - Angelica\n 8.Sabres Of Paradise - Smoke Belch\n9.Phil Mison - Lula\n10.Coldplay - God Put A Smile On My Face - Chris Martin's Brother Mix)\n11.Moonrock - Hill Street Blues\n12.The Ballistic Brothers - Uschi's Groove\n13.New Funky Generation - The Messanger"]

				],
		// for internal use
	isVA : false,
		// current mode (single|various) artists
	formRef : null,	
		// holds a reference to the form which this trackparser is in.
	TP_CHECKBOX_CONF : "TP_CHECKBOX_CONF", 
		// all trackParser config checkboxes use this name
	TP_TRACKSAREA : "TP_TRACKSAREA",
		// name,id of trackParser textarea
	TP_COOKIE_EXPANDED : "TP_COOKIE_EXPANDED",
		// name of cookie value for the expanded/collapsed setting

	// getConfiguration() -
	// Get values from the config checkboxes
	getConfiguration : function() {
		var obj = null;
		if ((obj = document.getElementsByName(this.TP_CHECKBOX_CONF)) != null) {
			this.formRef = obj[0].form;
			for (var i=0; i<obj.length; i++) {
				var el = obj[i];
				this.config[el.id] = el.checked;
				this.log("  "+el.id+" = "+el.checked);
			}
		}
		// TODO: is this enough?
		this.isVA = (this.formRef != null && this.formRef.artistname0 != null);
		this.log("  isVA = "+this.isVA);

	},

	// getConf() -
	// Get value for a specific configuration
	getConf : function(key) {
		return (this.config[key] == true);
	},

	// onRunTest() -
	// run a test
	onRunTest : function(i) {
		var obj = null;
		this.log("onRunTest()", true);
		if ((obj = document.getElementById(this.TP_TRACKSAREA)) != null) {
			this.log("Loading test "+this.testCases[i][1]+" ...");
			obj.value = this.testCases[i][2];
		}
		this.isVA = this.testCases[i][0]==1;
		this.parseNow();
	},

	// onParseClicked() -
	// Parse button clicked, process text in textarea
	onParseClicked : function() {
		this.log("onParseClicked()", true);
		this.parseNow();
	},

	// setVA() -
	// set VA mode (true|false)
	setVA : function(flag) {
		this.isVA = flag;
	},
										   
	// parseNow() -
	// Parse the track titles out of the textarea
	parseNow : function() {
		this.getConfiguration(); // get current settings from checkboxes
		var obj = null;
		var tracks = new Array();
		if ((obj = document.getElementById(this.TP_TRACKSAREA)) != null) {
			var text = obj.value;
			var lines = text.split("\n");
			var trackNumber, sTitle, sArtist;
			var si = 0;
			var sAlbumTitle = "";
			if (this.getConf("tp_hasAlbumTitle")) {
				sAlbumTitle = lines[0];
				this.log("Album Title = "+sAlbumTitle);
				si++;
			}
			var trackCounter = 1;
			for (var i=si; i<lines.length; i++) {
				sTitle = lines[i];

				// get rid of whitespace
				sTitle = this.trim(sTitle);
				if (sTitle != "") {

					// get track number from string, and replace
					var startsWithNumber = false;
					trackNumber = (sTitle.match(/^[0-9\.\s]+/g));
					if (trackNumber != null) {
						startsWithNumber = true;
						if (this.getConf("tp_hasTrackNumber")) {
							// only replace leading number if user configured
							// to do so. we need the startWithNumber flag
							// to check for extratitleinformation though
							sTitle = sTitle.replace(/^[0-9\.\s]+/, "");
						}
					}
					trackNumber = trackCounter;

					// get track time from string, and replace
					var trackTime = "";
					if (this.getConf("tp_hasTrackTimes")) {
						trackTime = sTitle.match(/\(?[0-9]+:[0-9]+\)?/gi);
						if (trackTime != null) {
							trackTime = this.trim(trackTime);
							trackTime = trackTime.replace(/\(|\)/g, "");
						}
						sTitle = sTitle.replace(/\(?[0-9]+:[0-9]+\)?/, "");
					}

					// amazon specific tweaks
					sTitle = sTitle.replace(/\[\*\]?/gi, ""); // remove [*]
					sTitle = sTitle.replace(/\s\s*(listen|\s)+$/gi, ""); // remove trailing "Listen"

					// if VA, get artist from string, and remove from title
					var sArtist = null;
					if (this.isVA) {
						if (! (this.getConf("tp_hasTrackNumber") && !startsWithNumber)) {
							// we want to look for extratitleinformation, if
							// * is configured that tracks start with numbers
							// * and current line does not start with a number.

							var vaRE = /  |\s+-\s+|\t/gi;
							// alert(sTitle+" --- "+sTitle.match(vaRE));
							if (sTitle.match(vaRE)) {			
								var parts = sTitle.split(vaRE);
								sArtist = parts[0];
								parts.splice(0,1);
								sTitle = parts.join(" - ");
							}
						}
					}

					// get rid of whitespace
					sTitle = this.trim(sTitle);

					// if we expect tracknumbers, and current line starts with a number,
					// or if we handle all lines as a new title, add to tracks
					if (!this.getConf("tp_hasTrackNumber") || startsWithNumber) {
						// add to tracks list.
						tracks[tracks.length] = {
							artist : sArtist,
							title  : sTitle,
							time   : trackTime,
							feat   : []
						};
						trackCounter++;

					} else if (tracks.length>0) {
						// else try to analyze current information to
						// add to track per SG5 (discogs parsing)
						var  x = sTitle.split(" - ");
						if (x[0].match(/remix/i) == null) {
							if (x.length > 1) {
								x.splice(0,1);
								sTitle = x.join("");
								sTitle = sTitle.replace(/\s*,/g, ",");
								sTitle = sTitle.replace(/^\s*/g, ""); // remove leading
								sTitle = sTitle.replace(/[ \s\r\n]*$/g, ""); // remove trailing
								if (sTitle != "") tracks[tracks.length-1].feat.push(sTitle);
							}
						}
					}
				}
			}
			this.log("-----------------------");
			for (var i=0; i<tracks.length; i++) {
				var track = tracks[i];
				if (track.feat.length>0) track.title += " (feat. "+track.feat.join(", ")+")";
				this.log("no="+(this.leadZero(i+1))
						+ (this.isVA ? ",     artist="+track.artist : "")
						+ ",     title="+track.title
						+ ",     time="+track.time);
			}
			this.fillFields(sAlbumTitle, tracks);
		}
	},

	// ----------------------------------------------------------------------------
	// trim()
	trim : function(strIn) {
		return new String(strIn)
			.replace(/^\s*/, "")
			.replace(/\s*$/, "");
	},

	// ----------------------------------------------------------------------------
	// getTextFields()
	// -- returns all the edit text fields (class="textfield")
	//    of the current form.
	getTextFields : function(f) {
		var fields = new Array();
		if (f) {
			var cnRE = /textfield(focus)?/i;
			var nameRE = /track\d+|title\d+/i;
			return this.fieldsWalker(f, cnRE, nameRE);
		}  
		return fields;
	},

	// ----------------------------------------------------------------------------
	// getArtistFields()
	// -- returns all the artist fields (class="textfield")
	//    of the current form.
	getArtistFields : function(f) {
		var fields = new Array();
		if (f) {
			var cnRE   = /textfield(focus)?/i;
			var nameRE = /artistname\d+/i;
			return this.fieldsWalker(f, cnRE, nameRE);
		}  
		return fields;
	},

	// ----------------------------------------------------------------------------
	// getTimeFields()
	// -- returns all the time edit fields (class="numberfield")
	//    of the current form.
	getTimeFields : function(f) {
		if (f) {
			var cnRE = /numberfield(focus)?/i;
			var nameRE = /tracklength\d+/i;
			return this.fieldsWalker(f, cnRE, nameRE);
		}  
	},

	// ----------------------------------------------------------------------------
	// fieldsWalker()
	// -- 
	fieldsWalker : function(f, cnRE, nameRE) {
		var fields = new Array();
		for (var i=0; i<f.elements.length; i++) { 
			if (el = f.elements[i]) {
				if ( (el.type == "text") && 
					 (el.className == null ? "" : el.className).match(cnRE) && 
					 (el.name.match(nameRE)) ) {
					fields.push(el);
				}
			}
		}
		return fields;
	},

	// ----------------------------------------------------------------------------
	// fillField() -
	fillField : function(field, newvalue) {
		af_addUndo(
			field.form, 
			new Array(field, 'parsetext', field.value, newvalue)
		);
		if (field == af_onFocusField) af_onFocusFieldState[1] = newvalue; 
		field.value = newvalue;
	},

	// ----------------------------------------------------------------------------
	// fillFields() -
	// write
	fillFields : function(albumtitle, tracks) {
		var i,field,fields,newvalue;

		// loop through all artist fields
		i=0;
		fields = this.getArtistFields(this.formRef);
		for (fi in fields) {
			field = fields[fi];
			if (tracks[i] && tracks[i].artist) {
				this.fillField(field, tracks[i].artist);
				i++;
			}
		}

		// loop through all time fields
		i=0;
		fields = this.getTimeFields(this.formRef);
		for (fi in fields) {
			field = fields[fi];
			if (tracks[i] && tracks[i].time) {
				this.fillField(field, tracks[i].time);
				i++;
			}
		}

		// loop through track/albumname fields
		i=0;
		var doAlbumTitle = this.getConf("tp_hasAlbumTitle");
		fields = this.getTextFields(this.formRef);
		for (fi in fields) {
			field = fields[fi];
			if (doAlbumTitle) {	 
				if (field.id.match(/cdi_m?enter_title/i)) {
					this.fillField(field, albumtitle);
				}
				doAlbumTitle = false;
			}
			if (field.id.match(/track[0-9]+/gi)) {
				if (tracks[i] && tracks[i].title) {
					this.fillField(field, tracks[i].title);
					i++; 
				}
			}
		}
	},

	// ----------------------------------------------------------------------------
	// writeConfiguration() -
	// write the different checkboxes
	writeConfiguration: function() {
		for (var i=0; i<this.configCheckBoxes.length; i++) {
			var cb = this.configCheckBoxes[i];
			document.writeln('<input type="checkbox" name="' + this.TP_CHECKBOX_CONF
						   + '" id="' + cb[0] + '" value="on" '
						   + (cb[1]?'checked':'') + '>' + cb[2]
						   + '<br/>');
		}
	},

	// ----------------------------------------------------------------------------
	// writeTests() -
	// print the different test cases
	writeTests : function() {
		document.writeln("<small>");
		for (var i=0; i<this.testCases.length; i++) {
			var tc = this.testCases[i];
			if (tc.length == 2) document.writeln("<h4 style='margin-bottom: 0px'>"+tc[1]+"</h4>");
			else document.writeln('-  <a href="javascript: ;" onClick="trackParser.onRunTest('+i+');">'+tc[1]+'</a><br/>');
		}
		document.writeln("</small>");
		document.writeln('<textarea id="logArea" rows="20" cols="90" style="width: 100%; font-family: Arial,Helvetica; font-size: 11px; "></textarea>');

	},

	// ----------------------------------------------------------------------------
	// writeGUI()
	// -- Write HTML for the trackparser functionality.
	writeGUI : function() {
		document.writeln('            <tr valign="top" id="trackparser-tr-expanded" style="display: none">');
		document.writeln('              <td nowrap><b>Track parser:</td>');
		document.writeln('              <td width="100%">');
		document.writeln('                <table border="0" cellspacing="0" cellpadding="0" width="100%">');
		document.writeln('                  <tr>');
		document.writeln('                    <td colspan="2">');
		document.writeln('                      <textarea name="'+this.TP_TRACKSAREA+'" rows="10" cols="90" id="'+this.TP_TRACKSAREA+'" style="width: 95%" style="font-family: Arial,Helvetica; font-size: 11px; overflow-y: scroll"></textarea>');
		document.writeln('                  </td></tr>');
		document.writeln('                  <tr valign="top">');
		document.writeln('                    <td>');
		document.writeln('                      <input type="button" onclick="trackParser.onParseClicked()" value="Parse">');
		document.writeln('                    </td><td><small>');
		this.writeConfiguration();
		// this.writeTests();
		document.writeln('                    </small></td>');
		document.writeln('                  </tr></table>');
		document.writeln('              </td>');
		document.writeln('              <td>&nbsp;</td>');
		document.writeln('              <td align="right">');
		document.writeln('                <a href="javascript:; // hide" onClick="trackParser.setExpanded(false)" ');
		document.writeln('                ><img src="/images/minus.gif" width="13" height="13" alt="Collapse Find & Replace function" border="0"></a>');
		document.writeln('              </td>');
		document.writeln('            </tr>');
		document.writeln('            <tr valign="top" id="trackparser-tr-collapsed">');
		document.writeln('              <td nowrap><b>Track parser:</td>');
		document.writeln('              <td width="100%">');
		document.writeln('                <small>Currently in collapsed mode</small>');
		document.writeln('              </td>');
		document.writeln('              <td>&nbsp;</td>');
		document.writeln('              <td align="right">');
		document.writeln('                <a href="javascript:; // show" onClick="trackParser.setExpanded(true)"');
		document.writeln('                ><img src="/images/plus.gif" width="13" height="13" alt="Expand Find & Replace function" border="0"></a>');
		document.writeln('              </td>');
		document.writeln('            </tr>');

		var ex = getCookie(this.TP_COOKIE_EXPANDED);
		if (ex == "1") this.setExpanded(true);
	},

	// ----------------------------------------------------------------------------
	// setExpanded()
	// -- toggle the GUI (collapsed|expanded)
	setExpanded : function(flag) {
		document.getElementById("trackparser-tr-collapsed").style.display = (!flag ? "" : "none");
		document.getElementById("trackparser-tr-expanded").style.display = (flag ? "" : "none");
		// set a persistent cookie for the next 365 days.
		setCookie(this.TP_COOKIE_EXPANDED, (flag ? "1" : "0"), 365);
	},

	// ----------------------------------------------------------------------------
	// leadZero()
	// add a leading zero to numbers < 10
	leadZero : function(x) {
		if (x < 10) return "0"+x;
		else return x;
	},

	// ----------------------------------------------------------------------------
	// log()
	// log message
	log : function(msg, reset) {
		var obj = null;
		if ((obj = document.getElementById("logArea")) != null) {
			if (reset) obj.value = "";
			obj.value = obj.value+"\n"+msg;
		}
	}

};