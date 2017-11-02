class CreateTestExecutions < ActiveRecord::Migration
  def change
    create_table :test_executions do |t|

    	t.string 		:test_case_id
    	t.string 		:test_data_id
    	t.string		:test_env_id
    	t.string		:test_case_desc

      t.timestamps null: false
    end
  end
end
