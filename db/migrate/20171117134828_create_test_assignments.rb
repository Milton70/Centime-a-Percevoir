class CreateTestAssignments < ActiveRecord::Migration
  def change
    create_table :test_assignments do |t|
    	t.references :test_case, index: true, foreign_key: true
      t.references :component_detail, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
