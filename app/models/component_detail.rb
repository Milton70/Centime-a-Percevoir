class ComponentDetail < ActiveRecord::Base
	belongs_to :component_folder
	belongs_to :test_case

	def self.does_component_have_linked_test_case(component)
		if component.test_case_id != nil && component.test_case_id != ""
			return true
		else
			return false
		end
	end

	def self.return_next_available_parameter(component)
		x = 1
		while x <= 10			
			case x
				when 1
					if component.component_param_1 == nil || component.component_param_1 == ""
						return x
					end
				when 2
					if component.component_param_2 == nil || component.component_param_2 == ""
						return x
					end
				when 3
					if component.component_param_3 == nil || component.component_param_3 == ""
						return x
					end
				when 4
					if component.component_param_4 == nil || component.component_param_4 == ""
						return x
					end
				when 5
					if component.component_param_5 == nil || component.component_param_5 == ""
						return x
					end
				when 6
					if component.component_param_6 == nil || component.component_param_6 == ""
						return x
					end
				when 7
					if component.component_param_7 == nil || component.component_param_7 == ""
						return x
					end
				when 8
					if component.component_param_8 == nil || component.component_param_8 == ""
						return x
					end
				when 9
					if component.component_param_9 == nil || component.component_param_9 == ""
						return x
					end
				when 10
					if component.component_param_10 == nil || component.component_param_10 == ""
						return x
					end
			end
			x += 1
		end
		# if we get here then all params are used
		return -1
	end

end
