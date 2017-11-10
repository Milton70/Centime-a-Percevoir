class ComponentsController < ApplicationController

	def index
		@root_folder = ComponentFolder.first
	end

	def create
		# Find the parent folder
		cf = ComponentFolder.find_by(folder_name: params[:parent_folder].gsub(/\t/,'').gsub(/\n/,''))

		# See if we're creating a component or a folder or renaming it
		if params[:component_name] != nil
			if params[:old_name] == nil || params[:old_name] == "New node"
				# Make sure this is not a duplicate component name
				this_dup = cf.component_details.find_by(component_name: params[:component_name])
				if this_dup == nil
					cf.component_details.create(component_name: params[:component_name], component_id: cf.ancestry)
					redirect_to edit_component_path(cf.component_details.last.id) and return					
				else
					flash[:error] = "Sorry but you cannot have duplicate component names. New component not created."
					redirect_to controller: :components, action: :index and return
				end
			else
				comp = cf.component_details.find_by(component_name: params[:old_name])
				comp.update(component_name: params[:component_name])
			end
		else
			if params[:old_name] == nil || params[:old_name] == "New node"
				# Make sure this is not a duplicate folder name
				this_dup = cf.children.find_by(folder_name: params[:folder_name])
				if this_dup == nil
					cf.children.create(folder_name: params[:folder_name], folder_description: "Child of [ #{params[:parent_folder]} ]")
				else
					flash[:error] = "Sorry but you cannot have duplicate folder names. New folder not created."
					redirect_to controller: :components, action: :index and return
				end
			else
				folder = cf.children.find_by(folder_name: params[:old_name])
				folder.update(folder_name: params[:folder_name])
			end
		end
		render json: cf and return
	end

	def edit
		@component = ComponentDetail.find(params[:id])
	end

	def show		
		@component = ComponentDetail.find_by(component_name: params[:id])
	end

	def add_param
		@component = ComponentDetail.find(params[:id])
		@param = ComponentDetail.return_next_available_parameter(@component)	
	end

	def edit_param

		# See if this is a delete, an addition or an update
		if params[:component_action] == "delete_param"
			@component = ComponentDetail.find(params[:component_id])
			x = params[:id][-1]

			# Get the current value for the param
			case x
				when "1" 
					@component.update(component_param_1: nil)
				when "2"
					@component.update(component_param_2: nil)
				when "3"
					@component.update(component_param_3: nil)
				when "4"
					@component.update(component_param_4: nil)
				when "5"
					@component.update(component_param_5: nil)
				when "6"
					@component.update(component_param_6: nil)
				when "7"
					@component.update(component_param_7: nil)
				when "8"
					@component.update(component_param_8: nil)
				when "9"
					@component.update(component_param_9: nil)
				when "10"
					@component.update(component_param_10: nil)
			end
		
		else

			@component = ComponentDetail.find(params[:id])
			x = params[:name][-1]

			# Get the current value for the param
			case x
				when "1" 
					curr_param = @component.component_param_1
				when "2"
					curr_param = @component.component_param_2
				when "3"
					curr_param = @component.component_param_3
				when "4"
					curr_param = @component.component_param_4
				when "5"
					curr_param = @component.component_param_5
				when "6"
					curr_param = @component.component_param_6
				when "7"
					curr_param = @component.component_param_7
				when "8"
					curr_param = @component.component_param_8
				when "9"
					curr_param = @component.component_param_9
				when "10"
					curr_param = @component.component_param_10
			end

			if params[:name].index('key')
				if curr_param[-1] == ':'
					new_param = params[:value] + ':'
				else				
					new_param = params[:value] + ':' + curr_param.split(':')[1]
				end
			else
				new_param = curr_param.split(':')[0] + ':' + params[:value]
			end

			case x
				when "1" 
					@component.update(component_param_1: new_param)
				when "2"
					@component.update(component_param_2: new_param)
				when "3"
					@component.update(component_param_3: new_param)
				when "4"
					@component.update(component_param_4: new_param)
				when "5"
					@component.update(component_param_5: new_param)
				when "6"
					@component.update(component_param_6: new_param)
				when "7"
					@component.update(component_param_7: new_param)
				when "8"
					@component.update(component_param_8: new_param)
				when "9"
					@component.update(component_param_9: new_param)
				when "10"
					@component.update(component_param_10: new_param)
			end
		end
		render json: :ok
	end

	def update
		@component = ComponentDetail.find(params[:id])
		if params[:ind] == nil
			x = 0
			while x <= params[:param_keys].count - 1
				case x
					when 0
						@component.component_param_1 = params[:param_keys][x] + ':' + params[:param_values][x]
					when 1
						@component.component_param_2 = params[:param_keys][x] + ':' + params[:param_values][x]
					when 2
						@component.component_param_3 = params[:param_keys][x] + ':' + params[:param_values][x]
					when 3
						@component.component_param_4 = params[:param_keys][x] + ':' + params[:param_values][x]
					when 4
						@component.component_param_5 = params[:param_keys][x] + ':' + params[:param_values][x]
					when 5
						@component.component_param_6 = params[:param_keys][x] + ':' + params[:param_values][x]
					when 6
						@component.component_param_7 = params[:param_keys][x] + ':' + params[:param_values][x]
					when 7
						@component.component_param_8 = params[:param_keys][x] + ':' + params[:param_values][x]
					when 8
						@component.component_param_9 = params[:param_keys][x] + ':' + params[:param_values][x]
					when 9	
						@component.component_param_10 = params[:param_keys][x] + ':' + params[:param_values][x]
				end
				x += 1
			end
			@component.save
			flash[:success] = "Your parameters have been added to the [ #{@component.component_name} ] component."
			redirect_to controller: :components, action: :index and return
		else
			if params[:param_keys][0] != ""
				case params[:ind].to_i
					when 1
						@component.component_param_1 = params[:param_keys][0] + ':' + params[:param_values][0]
					when 2
						@component.component_param_2 = params[:param_keys][0] + ':' + params[:param_values][0]
					when 3
						@component.component_param_3 = params[:param_keys][0] + ':' + params[:param_values][0]
					when 4
						@component.component_param_4 = params[:param_keys][0] + ':' + params[:param_values][0]
					when 5
						@component.component_param_5 = params[:param_keys][0] + ':' + params[:param_values][0]
					when 6
						@component.component_param_6 = params[:param_keys][0] + ':' + params[:param_values][0]
					when 7
						@component.component_param_7 = params[:param_keys][0] + ':' + params[:param_values][0]
					when 8
						@component.component_param_8 = params[:param_keys][0] + ':' + params[:param_values][0]
					when 9
						@component.component_param_9 = params[:param_keys][0] + ':' + params[:param_values][0]
					when 10	
						@component.component_param_10 = params[:param_keys][0] + ':' + params[:param_values][0]
				end
				@component.save
				flash[:success] = "Your parameters have been added to the [ #{@component.component_name} ] component."
				redirect_to component_path(@component.component_name)
			else
				flash[:error] = "Please enter a parameter key! Parameter values can be blank but not keys."
				redirect_to add_param_path(@component.id)
			end
		end
	end

	def destroy
		flash.clear
		# See if we can find the object in components first
		obj = ComponentDetail.find_by(component_name: params[:component_name])
		if obj != nil
			if ComponentDetail.does_component_have_linked_test_case(obj) == true
				flash[:error] = "Sorry but you cannot delete a component that is linked to one or more test cases."
				redirect_to controller: :components, action: :index and return
			else
				obj.destroy
			end
		else
			# See if we can find it as a folder
			obj = ComponentFolder.find_by(folder_name: params[:component_name])
			if obj == nil
				render json: obj and return
			end
			# Make sure it's not got any sub-folders or components
			if obj.component_details == [] && obj.children == []
				obj.destroy
			else
				obj.children.each do |child|	
					# Work around the children and component details, if any have a test_case_id not nil, then can't delete
					rc = ComponentFolder.if_folder_has_sub_folder_check_linked_components(child, "")		
					if rc != ""
						flash[:error] = "Sorry but component(s) [#{rc}] are linked to test cases. You cannot delete components that are linked to test cases. All non-linked components (and folders) have been deleted."
						redirect_to controller: :components, action: :index and return
					end
				end		
				# If we get here then process the chosen folder
				rc = ComponentFolder.if_folder_has_sub_folder_check_linked_components(obj, "")		
				if rc != ""
					flash[:error] = "Sorry but component(s) [#{rc}] are linked to test cases. You cannot delete components that are linked to test cases. All non-linked components (and folders) have been deleted."
					redirect_to controller: :components, action: :index and return
				end
				# If we get here we need to refresh the page
				redirect_to controller: :components, action: :index and retur
			end
		end
		render json: obj and return
	end


end
