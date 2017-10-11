class SessionsController < ApplicationController

	def login
		flash.clear
		# This is the login page so if we're here reset the session
		reset_session
	end

	def index
		render 'splash' and return
	end

	def create
		# Clear any previous messages
		flash.clear

		# Make sure we have a user-name or email
		if params[:username] == nil || params[:username] == ""
			flash[:error] = "No user name or email address entered. Please try again..."
			render 'index' and return
		end

		# If we get here then check if it's an email or a user name
		if params[:username].include?('@')
			user = User.find_by(user_email: params[:username])
		else
			user = User.find_by(user_id: params[:username])
		end

		# See if it's valid or not
		if user == nil || user == ""
			flash[:error] = "Sorry but the user name or email does not exist. Please try again or contact your administrator."
			render 'index' and return
		end

		# If it's valid, check it's the correct password
		if user && user.authenticate(params[:password])	
			session[:user_name] = user.user_name
			# See if Admin or not
			if user.roles[0].role_name == "Admin"
				session[:permission] = [1, 1]
			else
				session[:permission] = [1, 0]
			end
			render 'splash' and return
		else
			flash[:error] = "Sorry but your password doesn't appear to be correct. Please try again or contact administration."
			render 'index' and return
		end

	end

	def new
		reset_session
		render 'login' and return
	end

end
