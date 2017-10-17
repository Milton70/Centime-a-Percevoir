class UsersController < ApplicationController

	def index
		if session[:permission] == [1,1]
			@users = User.all
		else
			flash[:error] = "Sorry but you do not have access to the 'Users' module. Please speak to an administrator if you need elevated priviledges." 
			redirect_to '/sessions'
		end
	end

	def new
		if session[:permission] == [1,1]
			@user 	= User.new
			@roles	= Role.all
		else
			flash[:error] = "Sorry but you do not have access to the 'Users' module. Please speak to an administrator if you need elevated priviledges." 
			redirect_to '/sessions'
		end
	end

	def create
		@user = User.new(user_params)
		@user.user_id = params['user']['user_id']
		@user.user_name = params['user']['user_name']
		@user.user_email = params['user']['user_email']
		@user.password = 'password'
		if @user.save
			@user.assignments.create(role_id: params['role'].to_i)
			flash[:success] = "User [ #{@user.user_name} ] created."
			redirect_to '/users'
		else
			render 'new'
		end
	end

	def edit
		if session[:permission] == [1,1]
			@user = User.find(params[:id])
		else
			flash[:error] = "Sorry but you do not have access to the 'Users' module. Please speak to an administrator if you need elevated priviledges." 
			redirect_to '/sessions'
		end
	end

	def update
		@user = User.find(params[:id])
		if @user.update user_id: params['user']['user_id'], user_name: params['user']['user_name'], user_email: params['user']['user_email']	
			assignment_id = @user.assignments.pluck(:id)[0].to_i		
			@user.assignments.update(assignment_id, role_id: params['role'].to_i)
			flash[:success] = "User [ #{@user.user_name} ] updated."
			redirect_to '/users'
		else
			render 'edit'
		end
	end

	def destroy
		if session[:permission] == [1,1]
			@user = User.find(params[:id])
			@user.destroy
			redirect_to action: :index
		else
			flash[:error] = "Sorry but you do not have access to the 'Users' module. Please speak to an administrator if you need elevated priviledges." 
			redirect_to '/sessions'
		end
	end

	private

		def user_params
			params.require(:user).permit(:user_id, :user_name, :user_email, :password)
		end

end
