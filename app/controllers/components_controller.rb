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

		# Find the parent folder
		cf = ComponentFolder.find_by(folder_name: params[:parent_folder].gsub(/\t/,'').gsub(/\n/,''))

		# See if we're creating a component or a folder or renaming it
		if params[:component_name] != nil
			if params[:old_name] == nil || params[:old_name] == "New node"
				cf.component_details.create(component_name: params[:component_name], component_id: cf.ancestry)
				render :new and return
			else
				comp = cf.component_details.find_by(component_name: params[:old_name])
				comp.update(component_name: params[:component_name])
			end
		else
			if params[:old_name] == nil || params[:old_name] == "New node"
				cf.children.create(folder_name: params[:folder_name], folder_description: "Child of [ #{params[:parent_folder]} ]")
			else
				folder = cf.children.find_by(folder_name: params[:old_name])
				folder.update(folder_name: params[:folder_name])
			end
		end
		render json: cf and return
	end

	def edit
binding.pry
	end

	def update
binding.pry
	end

	def destroy
binding.pry		
		# See if we can find the object in components first
		obj = ComponentDetail.find_by(component_id: params[:id])
		if obj == nil
		else
			# See if we can find it as a folder
			obj = ComponentFolder.find_by(folder_description: params[:id])
			if obj == nil
				render json: obj and return
			end

		end
		render json: obj and return
	end


end
