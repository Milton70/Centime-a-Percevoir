module ComponentsHelper

	def build_tree_view(root, html)
		folder 		= "data-jstree='{\"icon\":\"fa fa-folder-open-o\"}'"
		component	= "data-jstree='{\"icon\":\"fa fa-puzzle-piece\"}'"
		html = ''
		if !root.has_children?
			html << "<li #{folder}>#{root.folder_name}</li>
			"
			return html.html_safe
		else
			html << "<li #{folder}>#{root.folder_name}"
			for temp_child in root.children		
				temp_html = ''	
				if temp_child.component_details == []				
					html << "<ul>#{build_tree_view(temp_child, temp_html)}</ul>"
				else
					html << '<ul>'
	      	temp_child.component_details.each do |kid_comp| 
	      		html << "<li #{component}>"
	      		html << kid_comp.component_name
	      		html << "</li>"
	      	end
	      	html << '</ul>'
	      	html << "<ul>#{build_tree_view(temp_child, temp_html)}</ul>"
				end
			end
			html << '</li>'
		end
		return html.html_safe
	end

end
