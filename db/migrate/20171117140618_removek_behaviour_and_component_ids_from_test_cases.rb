class RemovekBehaviourAndComponentIdsFromTestCases < ActiveRecord::Migration
  def change
  	remove_column :test_cases, :test_behaviour_id
  	remove_column :test_cases, :test_component_id
  end
end
