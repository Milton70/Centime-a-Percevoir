# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171102112334) do

  create_table "assignments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "assignments", ["role_id"], name: "index_assignments_on_role_id"
  add_index "assignments", ["user_id"], name: "index_assignments_on_user_id"

  create_table "component_details", force: :cascade do |t|
    t.integer  "component_folder_id"
    t.string   "component_name"
    t.string   "component_id"
    t.string   "component_param_1"
    t.string   "component_param_2"
    t.string   "component_param_3"
    t.string   "component_param_4"
    t.string   "component_param_5"
    t.string   "component_param_6"
    t.string   "component_param_7"
    t.string   "component_param_8"
    t.string   "component_param_9"
    t.string   "component_param_10"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "test_case_id"
  end

  add_index "component_details", ["component_folder_id"], name: "index_component_details_on_component_folder_id"
  add_index "component_details", ["test_case_id"], name: "index_component_details_on_test_case_id"

  create_table "component_folders", force: :cascade do |t|
    t.string   "folder_name"
    t.string   "folder_description"
    t.string   "ancestry"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "component_folders", ["ancestry"], name: "index_component_folders_on_ancestry"

  create_table "roles", force: :cascade do |t|
    t.string   "role_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "test_cases", force: :cascade do |t|
    t.integer  "test_execution_id"
    t.string   "test_case_id"
    t.string   "test_behaviour_id"
    t.string   "test_component_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "test_cases", ["test_execution_id"], name: "index_test_cases_on_test_execution_id"

  create_table "test_data", force: :cascade do |t|
    t.integer  "test_execution_id"
    t.string   "model_id"
    t.string   "model_desc"
    t.string   "party_id_type"
    t.string   "party_id"
    t.string   "bei"
    t.string   "account"
    t.string   "associated_bank"
    t.string   "name"
    t.string   "address_lines"
    t.string   "country_code"
    t.string   "city"
    t.string   "postal_code"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "test_data", ["test_execution_id"], name: "index_test_data_on_test_execution_id"

  create_table "test_environments", force: :cascade do |t|
    t.integer  "test_execution_id"
    t.string   "test_env_id"
    t.string   "app_url"
    t.string   "app_user_id_1"
    t.string   "app_pwd_1"
    t.string   "app_user_id_2"
    t.string   "app_pwd_2"
    t.string   "db_server"
    t.string   "db_port"
    t.string   "db_service_name"
    t.string   "db_user_id"
    t.string   "db_pwd"
    t.string   "mq_server"
    t.string   "mq_channel_name"
    t.string   "mq_port"
    t.string   "mq_q_manager"
    t.string   "mq_in_q_name"
    t.string   "mq_user_id"
    t.string   "mq_pwd"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "test_environments", ["test_execution_id"], name: "index_test_environments_on_test_execution_id"

  create_table "test_executions", force: :cascade do |t|
    t.string   "test_case_id"
    t.string   "test_data_id"
    t.string   "test_env_id"
    t.string   "test_case_desc"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "test_file_mqmds", force: :cascade do |t|
    t.string   "file_type"
    t.string   "bankGroupId"
    t.string   "bankName"
    t.string   "fileName"
    t.string   "exchangeConditionExternalId"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "test_file_types", force: :cascade do |t|
    t.string   "test_file_type"
    t.string   "mq_in_q_name"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "test_files", force: :cascade do |t|
    t.string   "test_file_id"
    t.string   "test_file_type"
    t.string   "schema_name"
    t.string   "required_execution_date"
    t.string   "payment_information_id"
    t.string   "number_of_instructions"
    t.string   "batch_booking"
    t.string   "number_of_transactions"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "test_file_id"
    t.string   "transaction_end_to_end_id"
    t.string   "transaction_amount"
    t.string   "transaction_currency"
    t.string   "other_counterparty"
    t.string   "other_counterparty_iban"
    t.string   "other_counterparty_name"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "transactions", ["test_file_id"], name: "index_transactions_on_test_file_id"

  create_table "users", force: :cascade do |t|
    t.string   "user_id"
    t.string   "user_name"
    t.string   "user_email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

end
