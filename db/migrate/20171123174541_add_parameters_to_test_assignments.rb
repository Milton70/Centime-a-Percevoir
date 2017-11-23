class AddParametersToTestAssignments < ActiveRecord::Migration
  def change
  	add_column :test_assignments, :param_1, :string
  	add_column :test_assignments, :param_2, :string
  	add_column :test_assignments, :param_3, :string
  	add_column :test_assignments, :param_4, :string
  	add_column :test_assignments, :param_5, :string
  	add_column :test_assignments, :param_6, :string
  	add_column :test_assignments, :param_7, :string
  	add_column :test_assignments, :param_8, :string
  	add_column :test_assignments, :param_9, :string
  	add_column :test_assignments, :param_10, :string
  end
end

