module ComponentsHelper

	def build_component_tree_view(root, html)
		folder 		= "data-jstree='{\"icon\":\"fa fa-folder-open-o\"}'"
		html = ''
		root = ComponentFolder.find(1)
		html << "<li #{folder}>#{root.folder_name}"		
		root.children.each do |kid|
			html << "<ul>"
			html << "<li #{folder}>#{kid.folder_name}"
			html << write_component_children(kid, folder)
			html << '</li>'
			html << '</ul>'	
		end
		html << "</li>"
		return html.html_safe
	end

	def write_component_children(kid, folder)
		html = ''
		if kid.has_children?
			kid.children.each do |child|		
				html << "<ul>"
				html << "<li #{folder}>#{child.folder_name}"			
				html << write_components(child)
				if child.has_children?
					html << write_component_children(child, folder)
					html << "</li></ul>"
				else
					html << "</li></ul>"
				end
			end
		end
		return html		
	end

	def write_components(kid)
		html = ''
		component	= "data-jstree='{\"icon\":\"fa fa-puzzle-piece\"}'"
		if kid.component_details == []
			return html
		else
			html << '<ul>'
			kid.component_details.each do |comp|
				html << "<li #{component}>"
			  html << comp.component_name
			  html << "</li>"
			end
			html << '</ul>'
		end
		return html
	end

	def show_params(component)
		html = ''
		x = 0
		while x <= 9
			case x
			 	when 0
			 		if component.component_param_1 != nil &&  component.component_param_1 != ""
			 			html << "<tr><td align='center'><em onclick='delete_parameter_fields(1, #{component.id});' class='fa fa-trash btn btn-danger'></em></td>"
			 			html << "<td><a href='#' id='param_key_1' data-type='text' data-pk='#{component.id}' data-url='/components/#{component.id}' data-title='New Key'>#{component.component_param_1.split(':')[0]}</a></td>"
			 			html << "<td><a href='#' id='param_value_1' data-type='text' data-pk='#{component.id}' data-url='/components/#{component.id}' data-title='New Value'>#{component.component_param_1.split(':')[1]}</a></td></tr>"
			 		end
			 	when 1
			 		if component.component_param_2 != nil &&  component.component_param_2 != ""
			 			html << "<tr><td align='center'><em onclick='delete_parameter_fields(2, #{component.id});' class='fa fa-trash btn btn-danger'></em></td>"
			 			html << "<td><a href='#' id='param_key_2' data-type='text' data-pk='#{component.id}' data-url='/components/#{component.id}' data-title='New Key'>#{component.component_param_2.split(':')[0]}</a></td>"
			 			html << "<td><a href='#' id='param_value_2' data-type='text' data-pk='#{component.id}' data-url='/components/#{component.id}' data-title='New Value'>#{component.component_param_2.split(':')[1]}</a></td></tr>"
			 		end
			 	when 2
			 		if component.component_param_3 != nil &&  component.component_param_3 != ""
			 			html << "<tr><td align='center'><em onclick='delete_parameter_fields(3, #{component.id});' class='fa fa-trash btn btn-danger'></em></td>"
			 			html << "<td><a href='#' id='param_key_3' data-type='text' data-pk='#{component.id}' data-url='/components/#{component.id}' data-title='New Key'>#{component.component_param_3.split(':')[0]}</a></td>"
			 			html << "<td><a href='#' id='param_value_3' data-type='text' data-pk='#{component.id}' data-url='/components/#{component.id}' data-title='New Value'>#{component.component_param_3.split(':')[1]}</a></td></tr>"
			 		end
			 	when 3
			 		if component.component_param_4 != nil &&  component.component_param_4 != ""
			 			html << "<tr><td align='center'><em onclick='delete_parameter_fields(4, #{component.id});' class='fa fa-trash btn btn-danger'></em></td>"
			 			html << "<td><a href='#' id='param_key_4' data-type='text' data-pk='#{component.id}' data-url='/components/#{component.id}' data-title='New Key'>#{component.component_param_4.split(':')[0]}</a></td>"
			 			html << "<td><a href='#' id='param_value_4' data-type='text' data-pk='#{component.id}' data-url='/components/#{component.id}' data-title='New Value'>#{component.component_param_4.split(':')[1]}</a></td></tr>"
			 		end
			 	when 4
			 		if component.component_param_5 != nil &&  component.component_param_5 != ""
			 			html << "<tr><td align='center'><em onclick='delete_parameter_fields(5, #{component.id});' class='fa fa-trash btn btn-danger'></em></td>"
			 			html << "<td><a href='#' id='param_key_5' data-type='text' data-pk='#{component.id}' data-url='/components/#{component.id}' data-title='New Key'>#{component.component_param_5.split(':')[0]}</a></td>"
			 			html << "<td><a href='#' id='param_value_5' data-type='text' data-pk='#{component.id}' data-url='/components/#{component.id}' data-title='New Value'>#{component.component_param_5.split(':')[1]}</a></td></tr>"
			 		end
				when 5
					if component.component_param_6 != nil &&  component.component_param_6 != ""
			 			html << "<tr><td align='center'><em onclick='delete_parameter_fields(6, #{component.id});' class='fa fa-trash btn btn-danger'></em></td>"
			 			html << "<td><a href='#' id='param_key_6' data-type='text' data-pk='#{component.id}' data-url='/components/#{component.id}' data-title='New Key'>#{component.component_param_6.split(':')[0]}</a></td>"
			 			html << "<td><a href='#' id='param_value_6' data-type='text' data-pk='#{component.id}' data-url='/components/#{component.id}' data-title='New Value'>#{component.component_param_6.split(':')[1]}</a></td></tr>"
			 		end
				when 6
					if component.component_param_7 != nil &&  component.component_param_7 != ""
			 			html << "<tr><td align='center'><em onclick='delete_parameter_fields(7, #{component.id});' class='fa fa-trash btn btn-danger'></em></td>"
			 			html << "<td><a href='#' id='param_key_7' data-type='text' data-pk='#{component.id}' data-url='/components/#{component.id}' data-title='New Key'>#{component.component_param_7.split(':')[0]}</a></td>"
			 			html << "<td><a href='#' id='param_value_7' data-type='text' data-pk='#{component.id}' data-url='/components/#{component.id}' data-title='New Value'>#{component.component_param_7.split(':')[1]}</a></td></tr>"
			 		end
				when 7
					if component.component_param_8 != nil &&  component.component_param_8 != ""
			 			html << "<tr><td align='center'><em onclick='delete_parameter_fields(8, #{component.id});' class='fa fa-trash btn btn-danger'></em></td>"
			 			html << "<td><a href='#' id='param_key_8' data-type='text' data-pk='#{component.id}' data-url='/components/#{component.id}' data-title='New Key'>#{component.component_param_8.split(':')[0]}</a></td>"
			 			html << "<td><a href='#' id='param_value_8' data-type='text' data-pk='#{component.id}' data-url='/components/#{component.id}' data-title='New Value'>#{component.component_param_8.split(':')[1]}</a></td></tr>"
			 		end
				when 8
					if component.component_param_9 != nil &&  component.component_param_9 != ""
			 			html << "<tr><td align='center'><em onclick='delete_parameter_fields(9, #{component.id});' class='fa fa-trash btn btn-danger'></em></td>"
			 			html << "<td><a href='#' id='param_key_9' data-type='text' data-pk='#{component.id}' data-url='/components/#{component.id}' data-title='New Key'>#{component.component_param_9.split(':')[0]}</a></td>"
			 			html << "<td><a href='#' id='param_value_9' data-type='text' data-pk='#{component.id}' data-url='/components/#{component.id}' data-title='New Value'>#{component.component_param_9.split(':')[1]}</a></td></tr>"
			 		end
				when 9
					if component.component_param_10 != nil &&  component.component_param_10 != ""
			 			html << "<tr><td align='center'><em onclick='delete_parameter_fields(10, #{component.id});' class='fa fa-trash btn btn-danger'></em></td>"
			 			html << "<td><a href='#' id='param_key_10' data-type='text' data-pk='#{component.id}' data-url='/components/#{component.id}' data-title='New Key'>#{component.component_param_10.split(':')[0]}</a></td>"
			 			html << "<td><a href='#' id='param_value_10' data-type='text' data-pk='#{component.id}' data-url='/components/#{component.id}' data-title='New Value'>#{component.component_param_10.split(':')[1]}</a></td></tr>"
			 		end
			end
			x += 1
		end
		return html.html_safe
	end

end
