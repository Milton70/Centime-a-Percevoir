class CreateTestFileTypes < ActiveRecord::Migration
  def change
    create_table :test_file_types do |t|

    	t.string 	:test_file_type
    	t.string 	:mq_in_q_name

      t.timestamps null: false
    end
  end
end
