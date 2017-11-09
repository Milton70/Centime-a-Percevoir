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

end
