class CreateTestCaseStatuses < ActiveRecord::Migration
  def change
    create_table :test_case_statuses do |t|
    	t.string :status
      t.timestamps null: false
    end

    add_column :test_cases, :status, :string
  end
end
