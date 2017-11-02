class CreateTestFiles < ActiveRecord::Migration
  def change
    create_table :test_files do |t|

    	t.string 	:test_file_id
    	t.string 	:test_file_type
    	t.string 	:schema_name
    	t.string 	:required_execution_date
    	t.string 	:payment_information_id
    	t.string 	:number_of_instructions
    	t.string 	:batch_booking
    	t.string 	:number_of_transactions

      t.timestamps null: false
    end
  end
end
