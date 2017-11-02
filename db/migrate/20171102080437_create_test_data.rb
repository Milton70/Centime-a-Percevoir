class CreateTestData < ActiveRecord::Migration
  def change
    create_table :test_data do |t|

    	t.belongs_to	:test_execution, index: true
    	t.string 			:model_id
    	t.string 			:model_desc
    	t.string 			:party_id_type
    	t.string 			:party_id
    	t.string 			:bei
    	t.string 			:account
    	t.string 			:associated_bank
    	t.string 			:name
    	t.string 			:address_lines
    	t.string  		:country_code
    	t.string 			:city
    	t.string 			:postal_code

      t.timestamps null: false
    end
  end
end
