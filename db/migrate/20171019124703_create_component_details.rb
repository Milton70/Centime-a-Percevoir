class CreateComponentDetails < ActiveRecord::Migration
  def change
    create_table :component_details do |t|

    	t.belongs_to   :component_folder, index: true
    	t.string       :component_name
    	t.string       :component_id
    	t.string       :component_param_1
    	t.string       :component_param_2
    	t.string       :component_param_3
    	t.string       :component_param_4
    	t.string       :component_param_5
    	t.string       :component_param_6
    	t.string       :component_param_7
    	t.string       :component_param_8
    	t.string       :component_param_9
    	t.string       :component_param_10

      t.timestamps null: false
    end
  end
end
