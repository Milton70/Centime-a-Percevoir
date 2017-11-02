class CreateTestCases < ActiveRecord::Migration
  def change
    create_table :test_cases do |t|

    	t.belongs_to	:test_execution, index: true
    	t.string 			:test_case_id
    	t.string 			:test_behaviour_id
    	t.string 			:test_component_id

      t.timestamps null: false
    end
  end
end
