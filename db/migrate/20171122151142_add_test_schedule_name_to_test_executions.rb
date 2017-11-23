class AddTestScheduleNameToTestExecutions < ActiveRecord::Migration
  def change
  	add_column :test_executions, :test_scenario_name, :string
  end
end
