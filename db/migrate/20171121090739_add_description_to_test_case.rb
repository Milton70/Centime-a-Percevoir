class AddDescriptionToTestCase < ActiveRecord::Migration
  def change
  	add_column :test_cases, :description, :string
  end
end
