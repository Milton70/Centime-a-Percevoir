class TestExecutionsController < ApplicationController

	def index
	end

	def create
		@json = TestExecution.create_json_file
	end

end
