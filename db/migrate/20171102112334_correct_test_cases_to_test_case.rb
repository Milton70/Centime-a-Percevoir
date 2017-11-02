class CorrectTestCasesToTestCase < ActiveRecord::Migration
  def change
  	add_reference :component_details, :test_case, index: true
  	remove_reference :component_details, :test_cases
  end
end
