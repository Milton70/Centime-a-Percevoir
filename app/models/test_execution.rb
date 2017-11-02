class TestExecution < ActiveRecord::Base
	has_many :test_cases
	has_many :test_data
	has_many :test_environments
end
