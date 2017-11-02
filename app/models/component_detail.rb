class ComponentDetail < ActiveRecord::Base
	belongs_to :component_folder
	belongs_to :test_case
end
