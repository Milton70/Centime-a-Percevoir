class CreateComponentFolders < ActiveRecord::Migration
  def change
    create_table :component_folders do |t|

    	t.string :folder_name
    	t.string :folder_description
    	t.string :ancestry

      t.timestamps null: false
    end

    add_index :component_folders, :ancestry
  end
end
