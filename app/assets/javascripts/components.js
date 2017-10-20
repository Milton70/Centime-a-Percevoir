
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
								$node = tree.create_node($node); 
								tree.edit($node);
							}
						},
						"new component": {
							"separator_before" 	: false,
							"separator_after"		: false,
							"label"							: "Add Component",
							"action"						: function (obj) {
								//$node = tree.create_node($node, {"icon":"jstree-file"});
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
								if ((obj.parent != '#') && (obj.text.indexOf("Projects") != 0 ) && (obj.text.indexOf("Misc") != 0 )) {
									inst.delete_node(obj);
								} else {
									alert("Sorry but you cannot delete this node!");
								}
							}
						}
					}
				}
			}
	});

	$("#comp_folders").on('delete_node.jstree', function(e, data) {

		console.log(data);

		console.log(data.node.id + ", " + data.node.text);
		console.log(data.node.parent + ", " + data.node.parent.text);

		//var parent = $("#comp_folders").jstree('get_selected', true)[0];
		//var parent_name = parent.text.replace(/\n/g,'').replace(/\t/g,'').replace(/\s/g,'');

		//var inst = $("#comp_folders").jstree(data.reference);

		//console.log(inst);

		//$.ajax( {
		//	url: "/components/" + data.node.id,
		//	type: "DELETE",
		//	data: { parent_folder: parent_name, component_name: data.text, int_id: data.node.id },
		//});

	});
	
	$("#comp_folders").on('rename_node.jstree', function(e, data) {
		var parent = $("#comp_folders").jstree('get_selected', true)[0];
		var parent_name = parent.text.replace(/\n/g,'').replace(/\t/g,'').replace(/\s/g,'');

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
			} else if (parent.icon == 'fa fa-puzzle-piece') {
				alert("Sorry but you cannot nest Components!");
				inst.delete_node(data.node);
			} else {
				$.ajax( {
					url: "/components",
					type: "post",
					data: { parent_folder: parent_name, component_name: data.text, int_id: data.node.id },
				});
			}
		} else {
			if (inst.get_parent(data.node) == '#') {
				alert("Sorry but you cannot rename the Root node!");
			} else if (parent_name == "Root") {
				alert("Sorry but you cannot add new Folders to Root!");
				inst.delete_node(data.node);
			} else if(parent.icon == 'fa fa-puzzle-piece') {
				alert("Sorry but you cannot add a Folder to a Component!");
				inst.delete_node(data.node);
			} else {
				$.ajax( {
					url: "/components",
					type: "post",
					data: { parent_folder: parent_name, folder_name: data.text, int_id: data.node.id },
				});
			}
		}
	})
	
});