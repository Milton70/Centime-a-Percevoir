class TestCase < ActiveRecord::Base
	belongs_to	:test_case_folder
	belongs_to	:test_execution
	has_many		:test_assignments, dependent: :destroy
	has_many		:component_details, through: :test_assignments

	def self.does_test_have_linked_test_scenarios(obj)
binding.pry
		return false		
	end

	def self.link_components_to_test_case(test_case, chosen)		
		chosen.each do |comp_id|
			test_case.test_assignments.create(component_detail_id: comp_id)
		end
	end

	def self.update_component_params(params)
		test_case = self.find(params[:id])
		component = ComponentDetail.find_by(component_name: params[:pk][0]).id
		test_asng = test_case.test_assignments.find_by(component_detail_id: component)
		test_asng.update(params[:name].gsub('_value','').to_sym => params[:pk][1] + ':' + params[:value])
	end

end
