class UsersController < ApplicationController

	def index
		@users = User.all
	end

	def new
		@user 	= User.new
		@roles	= Role.all
	end

	def create
binding.pry
	end

	private

		def user_params
			params.require(:user).permit(:user_id, :user_name, :user_email, :password_digest)
		end

end
