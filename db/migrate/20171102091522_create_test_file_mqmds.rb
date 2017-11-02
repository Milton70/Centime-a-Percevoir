class CreateTestFileMqmds < ActiveRecord::Migration
  def change
    create_table :test_file_mqmds do |t|

    	t.string 	:file_type
    	t.string 	:bankGroupId
    	t.string 	:bankName
    	t.string 	:fileName
    	t.string 	:exchangeConditionExternalId

      t.timestamps null: false
    end
  end
end
