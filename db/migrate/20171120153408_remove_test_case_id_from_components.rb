class RemoveTestCaseIdFromComponents < ActiveRecord::Migration
  def change
  	remove_column :component_details, :test_case_id
  end
end
