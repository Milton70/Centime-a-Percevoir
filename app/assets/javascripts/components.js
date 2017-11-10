
document.addEventListener("turbolinks:load", function() {

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
						"edit": {
							"separator_before" 	: false,
							"separator_after"		: false,
							"label"							: "Edit Component",
							"action"						: function (data) {
								var inst 	= $.jstree.reference(data.reference),
										obj 	= inst.get_node(data.reference);
								
								if (obj.icon == 'fa fa-folder-open-o') {
									alert("Sorry but you can only edit components!");
								}	else {
									window.location = '/components/' + obj.text
								}
							}
						},
						"rename": {
							"separator_before" 	: false,
							"separator_after"		: false,
							"label"							: "Rename node",
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

	$("#comp_folders").on('delete_node.jstree', function(e, data) {

		var obj_selected = data;
   	var obj_parent_icon = jstree_get_parent_name_and_icon(obj_selected);
   	var parent_icon = 'component';
   	var parent_name = obj_parent_icon[0];
   	if (obj_parent_icon[1].indexOf('fa-folder-open-o') != -1) {
   		parent_icon = 'folder';
   	} 

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
//----------------------------------------------------------------------------------------------------------------------------------------------//
var parm = 1;
function parameter_fields() {
  parm ++;

  if (document.getElementsByTagName('button').length < 11) { 
  	var objTo = document.getElementById('parameter_fields')
  	var divtest = document.createElement("div");

		divtest.setAttribute("class", "form-group removeclass" + parm);
  	divtest.innerHTML = '<div class="col-md-5 nopadding"><div class="form-group"><input type="text" class="form-control" id="param_key" name="param_keys[]" value="" placeholder="parameter key e.g. file_name"></div></div><div class="col-md-5 nopadding"><div class="form-group"><input type="text" class="form-control" id="param_value" name="param_values[]" value="" placeholder="parameter value e.g. OPF_20171101_SCT"></div></div><div class="col-md-2 nopadding"><button class="btn btn-danger" type="button"  onclick="remove_parameter_fields('+ parm +');"><i class="fa fa-minus" aria-hidden="true"></i></button></div></div><div class="clear"></div>';
  	objTo.appendChild(divtest)
  } else {
  	alert("Sorry but you can only add 10 parameters to a component");
  	return false;
  }
}
//----------------------------------------------------------------------------------------------------------------------------------------------//
function remove_parameter_fields(rid) {
   $('.removeclass' + rid).remove();
}
//----------------------------------------------------------------------------------------------------------------------------------------------//
function delete_parameter_fields(param_ele, comp_id) {
	$("#param_key_" + param_ele).parents("tr").remove();
	$.post("/components/param_key_" + param_ele,
	{
		component_id: comp_id,
		component_action: 'delete_param'
	},
	function(response, newValue) {
        if(response.status == 'error') return response.msg; //msg will be shown in editable form
  });
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
//----------------------------------------------------------------------------------------------------------------------------------------------//