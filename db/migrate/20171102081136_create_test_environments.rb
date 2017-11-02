class CreateTestEnvironments < ActiveRecord::Migration
  def change
    create_table :test_environments do |t|

    	t.belongs_to	:test_execution, index: true
    	t.string 			:test_env_id
    	t.string 			:app_url
    	t.string 			:app_user_id_1
    	t.string 			:app_pwd_1
    	t.string 			:app_user_id_2
    	t.string 			:app_pwd_2
    	t.string 			:db_server
    	t.string 			:db_port
    	t.string 			:db_service_name
    	t.string 			:db_user_id
    	t.string 			:db_pwd
    	t.string 			:mq_server
    	t.string 			:mq_channel_name
    	t.string 			:mq_port
    	t.string 			:mq_q_manager
    	t.string 			:mq_in_q_name
    	t.string 			:mq_user_id
    	t.string 			:mq_pwd

      t.timestamps null: false
    end
  end
end
