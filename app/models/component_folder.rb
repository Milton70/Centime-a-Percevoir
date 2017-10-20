class ComponentFolder < ActiveRecord::Base
	has_ancestry
	has_many :component_details
end
