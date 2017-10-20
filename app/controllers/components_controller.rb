class ComponentsController < ApplicationController

	def index
		@root_folder = ComponentFolder.first
	end

	def show
binding.pry
	end

	def new
binding.pry
	end

	def create
binding.pry	
		# Find the parent folder
		cf = ComponentFolder.find_by(folder_name: params[:parent_folder].gsub(/\t/,'').gsub(/\n/,'').gsub(' ',''))

		# See if we're creating a component or a folder
		if params[:component_name] != nil
			cf.component_details.create(component_name: params[:component_name], component_id: params[:int_id])
			render :new
		else
			cf.children.create(folder_name: params['folder_name'], folder_description: params[:int_id])
			render json: cf and return
		end
	end

	def edit
binding.pry
	end

	def update
binding.pry
	end

	def destroy
binding.pry
	end


end
