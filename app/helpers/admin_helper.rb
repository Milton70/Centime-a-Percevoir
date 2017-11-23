module AdminHelper

	def back_button(previous_page)
		data = ''
		data << "<span>"

		case previous_page
			when "Test Planning"
				our_path = test_cases_path
			when "Components"
				our_path = components_path
			else
				if previous_page[0] == '/'
					our_path = previous_page
				end
		end

		data << link_to("Back", our_path, class: 'btn btn-info')
		data << "</span>"

		return data.html_safe
	end

end
