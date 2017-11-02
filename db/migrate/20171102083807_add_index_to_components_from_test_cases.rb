class AddIndexToComponentsFromTestCases < ActiveRecord::Migration
  def change
  	add_reference :component_details, :test_cases, index: true
  end
end
