
document.addEventListener("turbolinks:load", function() {

	//-------------------------------------------Test Case Choose Components--------------------------------------------//

	$("#tc_comp_folders").jstree( {
		"plugins": ["checkbox"]
	});

	//-------------------------------------------Test Case Edit Params--------------------------------------------//
	
	$("#new_edit_params").DataTable({
		"paging": 		false,
		"searching": 	false,
		"info": 			false,
		"scrollX": 		true,
		"scrollY": 		true,
		"fixedColumns": {
			leftColumns: 2
		}
	});

});

	//---------------------------------- Place what was selected into hidden field ------------------------------------//

	function chooseComponents(tc_id) {
		var selected_comps = [];
		var checked_comps = []
		var selected_comps = $("#tc_comp_folders").jstree("get_selected", true);
		$.each(selected_comps, function() {
			if(this.icon != 'fa fa-folder-open-o') {
				checked_comps.push(this.text);
			}
		});
		
		window.location = '/test_cases/choose_components/' + tc_id + "?chosen=" + checked_comps.join(",");
	}
	
	//-------------------------------------------Test Case Folder and Cases--------------------------------------------//
document.addEventListener("turbolinks:load", function() {

	$("#tc_folders").jstree( {	
			"core": {"check_callback": true },
			"plugins": ["themes","html_data","contextmenu","types"],
			"contextmenu": {
				"items": function($node) {
					var tree = $("#tc_folders").jstree(true);
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
						"new test": {
							"separator_before" 	: false,
							"separator_after"		: false,
							"label"							: "Add Test",
							"action"						: function (obj) {
								$node = tree.create_node($node, {"icon":"fa fa-tasks"});
								tree.edit($node);
							}
						},
						"edit": {
							"separator_before" 	: false,
							"separator_after"		: false,
							"label"							: "Edit Test",
							"action"						: function (data) {
								var inst 	= $.jstree.reference(data.reference),
										obj 	= inst.get_node(data.reference);
								
								if (obj.icon == 'fa fa-folder-open-o') {
									alert("Sorry but you can only edit tests!");
								}	else {
									window.location = '/test_cases/' + obj.text
								}
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
								var x = confirm("Are you sure you want to delete this node?");
								if (x) {
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
								} else {
									return false;
								}
							}
						}
					}
				}
			}
	});

//--Determine what was deleted--------------------------------------------//

	$("#tc_folders").on('delete_node.jstree', function(e, data) {

		var obj_selected = data;
   	var obj_parent_icon = jstree_get_parent_name_and_icon(obj_selected);
   	var parent_icon = 'test';
   	var parent_name = obj_parent_icon[0];
   	if (obj_parent_icon[1].indexOf('fa-folder-open-o') != -1) {
   		parent_icon = 'folder';
   	} 

		$.ajax( {
			url: "/test_cases/" + data.node.id,
			type: "DELETE",
			data: { parent_folder: parent_name, test_name: data.node.text },
		});

	});
	
//--Determines whether we are sending new/renamed folder or component----//

	$("#tc_folders").on('rename_node.jstree', function(e, data) {

		var obj_selected = data;
   	var obj_parent_icon = jstree_get_parent_name_and_icon(obj_selected);
   	var parent_icon = 'test';
   	var parent_name = obj_parent_icon[0];
   	if (obj_parent_icon[1].indexOf('fa-folder-open-o') != -1) {
   		parent_icon = 'folder';
   	} 
		var inst = $("#tc_folders").jstree(data.reference);

		if (data.node.icon == 'fa fa-tasks') {
			if (parent_name == "Root") {
				alert("Sorry but you cannot add Tests to the Root node!");
				inst.delete_node(data.node);
			} else if (parent_name == "Projects") {
				alert("Sorry but you cannot add Tests to the Projects node!");
				inst.delete_node(data.node);
			} else if (parent_name == "Misc") {
				alert("Sorry but you cannot add Tests to the Misc node!");
				inst.delete_node(data.node);
			} else if (parent_icon == 'test') {
				alert("Sorry but you cannot add children to Test Case nodes!");
				inst.delete_node(data.node);
			} else {
				$.ajax( {
					url: "/test_cases",
					type: "post",
					data: { parent_folder: parent_name, test_name: data.text, old_name: data.old.replace(/\n/g,'').replace(/\t/g,'').trim() },
				});
			}
		} else {
			if (inst.get_parent(data.node) == '#') {
				alert("Sorry but you cannot rename the Root node!");
			} else if (parent_name == "Root") {
				alert("Sorry but you cannot add new Folders to Root!");
				inst.delete_node(data.node);
			} else if(parent_icon == 'test') {
				alert("Sorry but you cannot add children to Test Case nodes!");
				inst.delete_node(data.node);
			} else {
				$.ajax( {
					url: "/test_cases",
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
//----------------------------------------------------------------------------------------------------------------------------------------------//

	function add_parameter_to_component_from_test(component) {
		window.location.href = "/test_cases/component";
		return false;
	}

	function delete_component_from_test(test_case_id, component) {
		alert("You chose to Delete Test Case [" + test_case_id + "] & Component [" + component + "]");
		return false;
	}

	function edit_component_params_in_test(test_case_id, component) {
		alert("You chose to Edit Test Case [" + test_case_id + "] & Component [" + component + "]");	
		return false;
	}

//----------------------------------------------------------------------------------------------------------------------------------------------//
document.addEventListener("turbolinks:load", function() {
	$("[id*='param_key']").editable({
		validate: function(newValue) {
			if (newValue === null || newValue === '') {
				return false;
			}
		},
		success: function(response, newValue) {
        if(response.status == 'error') return response.msg; //msg will be shown in editable form
    }
	});
	$("[id*='param_value']").editable({
		success: function(response, newValue) {
        if(response.status == 'error') return response.msg; //msg will be shown in editable form
    }
	});
});
//----------------------------------------------------------------------------------------------------------------------------------------------//