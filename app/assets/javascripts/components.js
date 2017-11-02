
jQuery(document).ready(function() {

	$("#comp_folders").jstree( {	
			"core": {"check_callback": true },
			"plugins": ["themes","html_data","contextmenu","types"],
			"contextmenu": {
				"items": function($node) {
					var tree = $("#comp_folders").jstree(true);
					return {
						"new folder": {
							"separator_before" 	: false,
							"separator_after"		: false,
							"label"							: "Add Folder",
							"action"						: function (obj) {
								$node = tree.create_node($node, {"icon":"fa fa-folder-open-o"}); 
								tree.edit($node);
							}
						},
						"new component": {
							"separator_before" 	: false,
							"separator_after"		: false,
							"label"							: "Add Component",
							"action"						: function (obj) {
								$node = tree.create_node($node, {"icon":"fa fa-puzzle-piece"});
								tree.edit($node);
							}
						},
						"rename": {
							"separator_before" 	: false,
							"separator_after"		: false,
							"label"							: "Rename",
							"action"						: function (data) {
								var inst 	= $.jstree.reference(data.reference),
										obj 	= inst.get_node(data.reference);
								if ((obj.parent != '#') && (obj.text.indexOf("Projects") != 0 ) && (obj.text.indexOf("Misc") != 0 )) {
									inst.edit(obj);
								} else {
									alert("Sorry but you cannot rename this node!");
								}
							}
						},
						"delete": {
							"separator_before" 	: false,
							"separator_after"		: false,
							"label"							: "Delete",
							"action"						: function (data) {
								var inst 	= $.jstree.reference(data.reference),
										obj 	= inst.get_node(data.reference);
								console.log(obj.parent);
								console.log(obj.text);		
								if ((obj.parent != '#') && (obj.text.indexOf("Projects") != 0 ) && (obj.text.indexOf("Misc") != 0 )) {
									inst.delete_node(obj);
								} else {
									if ((obj.text.indexOf("Projects") == 0) && (obj.text.replace(/\s/g,'').length > 8)) {
										inst.delete_node(obj);
									} else if ((obj.text.indexOf("Misc") == 0) && (obj.text.replace(/\s/g,'').length > 4)) {
										inst.delete_node(obj);
									}	else {
										alert("Sorry but you cannot delete this node!");
									}
								}
							}
						}
					}
				}
			}
	});

//--Determine what was deleted--------------------------------------------//

	$("#comp_folders").on('delete_node.jstree', function(e, data) {

		var obj_selected = data;
   	var obj_parent_icon = jstree_get_parent_name_and_icon(obj_selected);
   	var parent_icon = 'component';
   	var parent_name = obj_parent_icon[0];
   	if (obj_parent_icon[1].indexOf('fa-folder-open-o') != -1) {
   		parent_icon = 'folder';
   	} 

   	alert(parent_icon);

		$.ajax( {
			url: "/components/" + data.node.id,
			type: "DELETE",
			data: { parent_folder: parent_name, component_name: data.node.text },
		});

	});
	
//--Determines whether we are sending new/renamed folder or component----//

	$("#comp_folders").on('rename_node.jstree', function(e, data) {

		var obj_selected = data;
   	var obj_parent_icon = jstree_get_parent_name_and_icon(obj_selected);
   	var parent_icon = 'component';
   	var parent_name = obj_parent_icon[0];
   	if (obj_parent_icon[1].indexOf('fa-folder-open-o') != -1) {
   		parent_icon = 'folder';
   	} 

   	alert("The Parent is " + parent_name);
   	alert("The Parent Icon is " + parent_icon);
   	alert(data.node.icon);

		var inst = $("#comp_folders").jstree(data.reference);

		if (data.node.icon == 'fa fa-puzzle-piece') {
			if (parent_name == "Root") {
				alert("Sorry but you cannot add Components to the Root node!");
				inst.delete_node(data.node);
			} else if (parent_name == "Projects") {
				alert("Sorry but you cannot add Components to the Projects node!");
				inst.delete_node(data.node);
			} else if (parent_name == "Misc") {
				alert("Sorry but you cannot add Components to the Misc node!");
				inst.delete_node(data.node);
			} else if (parent_icon == 'component') {
				alert("Sorry but you cannot add children to component nodes!");
				inst.delete_node(data.node);
			} else {
				$.ajax( {
					url: "/components",
					type: "post",
					data: { parent_folder: parent_name, component_name: data.text, old_name: data.old.replace(/\n/g,'').replace(/\t/g,'').trim() },
				});
			}
		} else {
			if (inst.get_parent(data.node) == '#') {
				alert("Sorry but you cannot rename the Root node!");
			} else if (parent_name == "Root") {
				alert("Sorry but you cannot add new Folders to Root!");
				inst.delete_node(data.node);
			} else if(parent_icon == 'component') {
				alert("Sorry but you cannot add children to component nodes!");
				inst.delete_node(data.node);
			} else {
				$.ajax( {
					url: "/components",
					type: "post",
					data: { parent_folder: parent_name, folder_name: data.text, old_name: data.old.replace(/\n/g,'').replace(/\t/g,'').trim() },
				});
			}
		}
	})

	function uiGetParents(loSelectedNode) {
    try {
        var lnLevel = loSelectedNode.node.parents.length;
        var lsSelectedID = loSelectedNode.node.id;
        var loParent = $("#" + lsSelectedID);
        var lsParents =  loSelectedNode.node.text + ' >';
        for (var ln = 0; ln <= lnLevel -1 ; ln++) {
            var loParent = loParent.parent().parent();
            if (loParent.children()[1] != undefined) {
                lsParents += loParent.children()[1].text + " > ";
            }
        }
        if (lsParents.length > 0) {
            lsParents = lsParents.substring(0, lsParents.length - 1);
        }
        alert(lsParents);
    }
    catch (err) {
        alert('Error in uiGetParents');
    }
  }

  function jstree_get_parent_name_and_icon(objSelectedNode) {
  	var rtn = [];
    try {
        var lsSelectedID = objSelectedNode.node.id;
        var loParent = $("#" + lsSelectedID);
        var loParent = loParent.parent().parent();
        rtn.push(loParent.children()[1].text.replace(/\n/g,'').replace(/\t/g,'').trim());
        rtn.push(loParent.children()[1].innerHTML);
        return rtn;
    }
    catch (err) {
        alert('Error in jstree_get_parent_name_and_icon');
    }
  }
	
});