class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|

    	t.belongs_to 	:test_file, index: true
    	t.string 			:transaction_end_to_end_id
    	t.string 			:transaction_amount
    	t.string 			:transaction_currency
    	t.string 			:other_counterparty
    	t.string 			:other_counterparty_iban
    	t.string 			:other_counterparty_name

      t.timestamps null: false
    end
  end
end
