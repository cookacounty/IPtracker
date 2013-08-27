$(document).ready(function() {

	//Retrive cdscells in a json stream
	var cdscells = [];
	$.ajax({
	  url: '/cdscells/all_json',
	  async: false,
	  dataType: 'json',
	  success: function (json) {
	    cdscells = json;
	    //console.log(json);
	  }
	});
	

    var mygrid = $("#mylist"),
    mygetUniqueNames = function(columnName) {
    	
    	var cells = cdscells.length,i;
    	var texts = [];
    	for (i=0;i<cells;i++) {
    		if (columnName == "cdslib.name") {
    			texts.push(cdscells[i].cdslib.name);

	    	} else {
	    		texts.push(cdscells[i][columnName]);
	       	}
		}
        var textsLength = texts.length;
        var uniqueTexts = [], text, textsMap = {};
            //alert(textsLength)
        for (i=0;i<textsLength;i++) {
            text = texts[i];
            if (text !== undefined && textsMap[text] === undefined) {
                // to test whether the texts is unique we place it in the map.
                textsMap[text] = true;
                uniqueTexts.push(text);
            }
        }
        return uniqueTexts;
    };

    mygrid.jqGrid({
            data: cdscells,
            datatype: "local",
            colNames:['Libray', 'Cell','area'],
            colModel:[                      
                    {name:'cdslib.name',index:'cdslib.name',width:225, search: true},
                    {name:'name',index:'name',width:225, search: true},
                    {name:'area',index:'area',width:75},
                  ],
		rowList: [10,20,50],
		rowNum: 20,
		rowTotal: 1000,
        loadonce : true,
		sortname: 'name',
        sortorder: 'asc',
		sortable: true,
        multiSort: true,
        ignoreCase: true,
        pager: '#mypager',
        pginput:false,
        autowidth:true,
        //width: 800,
        height: "auto",
        caption: "Browsing Libraries",
      
    //Load the page  
    //onSelectRow: function(asdf)   
    
    onSelectRow: function(ids) {
    	var selected_cell;
		$.ajax({
		  url: '/cdscells/browse_show/'+ids,
		  async: false,
		  dataType: 'html',
		  success: function (html) {
		    $("#cellview_view").html(html);
		    
		    //console.log(html);
		  }
		});
    },

    loadComplete: function(data) {
        if (true) {
            // build the set 'source' parameter of the autocomplete
            mygrid.jqGrid('setColProp', 'name', {
                searchoptions: {
                    sopt:['cn'],
                    dataInit: function(elem) {
                        $(elem).autocomplete({
                            source:mygetUniqueNames('name'),
                            delay:0,
                            minLength:0,
                            select: function( event, ui ) {
            					$(elem).val(ui.item.value);
            					$(elem).focus().trigger({ type: 'keypress', charCode: 13 });
                            }
                        });
                    }
                }
            });
            // build the set 'source' parameter of the autocomplete
            mygrid.jqGrid('setColProp', 'cdslib.name', {
                searchoptions: {
                    sopt:['cn'],
                    dataInit: function(elem) {
                        $(elem).autocomplete({
                            source:mygetUniqueNames('cdslib.name'),
                            delay:0,
                            minLength:0,
                            select: function( event, ui ) {
            					$(elem).val(ui.item.value);
            					$(elem).focus().trigger({ type: 'keypress', charCode: 13 });
                            }
                        });
                    }
                }
            });
            mygrid.jqGrid('filterToolbar',
                          {stringResult:true,searchOnEnter:true,
                           defaultSearch:"bw"});
        }
    }
    }).jqGrid('navGrid','#mypager',
              {edit:false, add:false, del:false, search:false, autosearch:true, refresh:true, searchOperators : true});


	//Update the view for the selected model
	function load_cellview() {
	  $.ajax({
	    type: "GET",
	    url: "/about",
	  });
	}

	$("#cellview_view").load(load_cellview());
	
});