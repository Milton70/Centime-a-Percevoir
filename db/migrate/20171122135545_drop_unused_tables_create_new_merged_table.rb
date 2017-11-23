class DropUnusedTablesCreateNewMergedTable < ActiveRecord::Migration
  def up
  	drop_table :test_file_mqmds
  	drop_table :test_file_types

  	create_table :test_file_extras do |t|
    	t.string :test_file_type
    	t.string :mq_in_q_name
    	t.string :bankGroupId
    	t.string :bankName
    	t.string :fileName
    	t.string :exchangeConditionExternalId
    	t.string :file_location
      t.timestamps null: false
    end
  end
  def down
  	create_table :test_file_mqmds do |t|

    	t.string 	:file_type
    	t.string 	:bankGroupId
    	t.string 	:bankName
    	t.string 	:fileName
    	t.string 	:exchangeConditionExternalId

      t.timestamps null: false
    end
    create_table :test_file_types do |t|

    	t.string 	:test_file_type
    	t.string 	:mq_in_q_name

      t.timestamps null: false
    end
  end
end
