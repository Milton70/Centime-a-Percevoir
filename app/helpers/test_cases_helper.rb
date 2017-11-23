module TestCasesHelper

	def build_test_tree_view(root, html)
		folder 		= "data-jstree='{\"icon\":\"fa fa-folder-open-o\"}'"
		html = ''
		root = TestCaseFolder.find(1)
		html << "<li #{folder}>#{root.folder_name}"		
		root.children.each do |kid|
			html << "<ul>"
			html << "<li #{folder}>#{kid.folder_name}"
			html << write_test_children(kid, folder)
			html << '</li>'
			html << '</ul>'	
		end
		html << "</li>"
		return html.html_safe
	end

	def write_test_children(kid, folder)
		html = ''
		if kid.has_children?
			kid.children.each do |child|		
				html << "<ul>"
				html << "<li #{folder}>#{child.folder_name}"			
				html << write_tests(child)
				if child.has_children?
					html << write_test_children(child, folder)
					html << "</li></ul>"
				else
					html << "</li></ul>"
				end
			end
		end
		return html		
	end

	def write_tests(kid)
		html = ''
		test_icon	= "data-jstree='{\"icon\":\"fa fa-tasks\"}'"
		if kid.test_cases == []
			return html
		else
			html << '<ul>'
			kid.test_cases.each do |test_case|
				html << "<li #{test_icon}>"
			  html << test_case.test_case_name
			  html << "</li>"
			end
			html << '</ul>'
		end
		return html
	end

	def show_allocated_components(component)
		html = ''
		component.each do |ele|
			html << "<tr class='reduce'>"
				html << "<td class='text-center'>"
					html << "<i onclick='delete_component_from_test(#{ele[0]});' class='fa fa-trash btn btn-danger btn-xs' title='Delete Component from Test'></i>&nbsp;"
				html << "</td>"

				html << "<td>#{ele[0]}</td>"
				ele[1].each do |td|
					html << "<td>#{td}</td>"
					#html << "<td><a href='#' id='param_key_1' data-type='text' data-pk='#{ele[0]}' data-url='/components/#{component.id}' data-title='New Key'>#{component.component_param_3.split(':')[0]}</a></td>"
				end
			html << "</tr>"
		end
		
		return html.html_safe
	end

	def add_params(components, test_case_id)
binding.pry		
		html = ''
		html << "<tr class='reduce'>"
		html << "<td>#{components[0]}</td>"
		html << "<td><a href='#' id='param_value_1' data-type='text' data-pk='#{[components[0],components[1][0].split(':')[0]]}' data-url='/test_cases/edit_params/#{test_case_id}' data-title='New Value'>#{components[1][0].split(':')[1]}</a></td>"
		html << "</tr>"

		return html.html_safe
	end	

end
