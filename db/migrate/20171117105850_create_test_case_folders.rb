class CreateTestCaseFolders < ActiveRecord::Migration
  def change
    create_table :test_case_folders do |t|

    	t.string :folder_name
    	t.string :folder_description
    	t.string :ancestry

      t.timestamps null: false
    end
    add_index :test_case_folders, :ancestry
  end
end
