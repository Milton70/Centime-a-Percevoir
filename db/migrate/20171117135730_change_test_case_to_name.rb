class ChangeTestCaseToName < ActiveRecord::Migration
  def change
  	rename_column :test_cases, :test_case_id, :test_case_name
  end
end
