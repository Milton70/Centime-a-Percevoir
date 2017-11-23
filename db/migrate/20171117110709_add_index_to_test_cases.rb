class AddIndexToTestCases < ActiveRecord::Migration
  def change
  	add_reference :test_cases, :test_case_folder, index: true
  end
end
