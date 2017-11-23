class TestCasesController < ApplicationController

	def index
		@root_folder = TestCaseFolder.first
	end

	def create
		tcf = TestCaseFolder.find_by(folder_name: params[:parent_folder].gsub(/\t/,'').gsub(/\n/,''))		
		# See if we're creating a test or a folder or renaming it
		if params[:test_name] != nil
			if params[:old_name] == nil || params[:old_name] == "New node"
				# Make sure this is not a duplicate component name
				this_dup = tcf.test_cases.find_by(test_case_name: params[:test_name])
				if this_dup == nil
					tcf.test_cases.create(test_case_name: params[:test_name], test_case_folder_id: tcf.ancestry)
					redirect_to edit_test_case_path(tcf.test_cases.last.id) and return					
				else
					flash[:error] = "Sorry but you cannot have duplicate test case names. New test_case not created."
					redirect_to controller: :test_cases, action: :index and return
				end
			else
				test_case = tcf.test_cases.find_by(test_case_name: params[:old_name])
				test_case.update(test_case_name: params[:test_name])
			end
		else
			if params[:old_name] == nil || params[:old_name] == "New node"
				# Make sure this is not a duplicate folder name
				this_dup = tcf.children.find_by(folder_name: params[:folder_name])
				if this_dup == nil
					tcf.children.create(folder_name: params[:folder_name], folder_description: "Child of [ #{params[:parent_folder]} ]")
				else
					flash[:error] = "Sorry but you cannot have duplicate folder names. New folder not created."
					redirect_to controller: :test_cases, action: :index and return
				end
			else
				folder = tcf.children.find_by(folder_name: params[:old_name])
				folder.update(folder_name: params[:folder_name])
			end
		end
		render json: tcf and return
	end

	def show		
		@test_case = TestCase.find_by(test_case_name: params[:id])
		if @test_case == nil
			@test_case = TestCase.find(params[:id])
		end
		@components, @tot_num_params = TestAssignment.return_component_details(@test_case)
	end

	def edit		
		@test_case = TestCase.find(params[:id])
	end

	def update
		@test_case = TestCase.find(params[:id])
		if params[:description] == nil || params[:description] == ""
			flash[:error] = "Please enter a description for the test case."
			redirect_to controller: :test_cases, action: :edit and return
		end

		@test_case.update(description: params[:description], status: TestCaseStatus.where(id: params[:status]).pluck(:status)[0])
	end

	def choose_components
binding.pry		
		@test_case = TestCase.find(params[:id])
		comp_ids = ComponentDetail.return_component_ids(params[:chosen])
		TestCase.link_components_to_test_case(@test_case, comp_ids)
		redirect_to test_cases_edit_params_path(@test_case,)
	end

	def edit_params		
		@test_case = TestCase.find(params[:id])
		@components, @tot_num_params = TestAssignment.return_component_details(@test_case)
binding.pry	
	end

	def edit_params_1
binding.pry
		TestCase.update_component_params(params)
binding.pry
		render json: :ok
	end

	def destroy
		flash.clear
		# See if we can find the test case first
		obj = TestCase.find_by(test_case_name: params[:test_name])
		if obj != nil
binding.pry			
			if TestCase.does_test_have_linked_test_scenarios(obj) == true
				flash[:error] = "Sorry but you cannot delete a test that is linked to one or more test scenarios."
				redirect_to controller: :test_cases, action: :index and return
			else
				obj.destroy
			end
		else
binding.pry			
			# See if we can find it as a folder
			obj = TestCaseFolder.find_by(folder_name: params[:test_name])
			if obj == nil
				render json: obj and return
			end
			# Make sure it's not got any sub-folders or components
			if obj.test_cases == [] && obj.children == []
binding.pry				
				obj.destroy
			else
binding.pry				
				obj.children.each do |child|	
					# Work around the children and component details, if any have a test_case_id not nil, then can't delete
					rc = TestCaseFolder.if_folder_has_sub_folder_check_linked_scenarios(child, "")		
					if rc != ""
						flash[:error] = "Sorry but test(s) [#{rc}] are linked to test scenarios. You cannot delete tests that are linked to test scenarios. All non-linked tests (and folders) have been deleted."
						redirect_to controller: :test_cases, action: :index and return
					end
				end
binding.pry						
				# If we get here then process the chosen folder
				rc = TestCaseFolder.if_folder_has_sub_folder_check_linked_scenarios(obj, "")		
				if rc != ""
					flash[:error] = "Sorry but test(s) [#{rc}] are linked to test scenarios. You cannot delete tests that are linked to test scenarios. All non-linked tests (and folders) have been deleted."
					redirect_to controller: :test_cases, action: :index and return
				end
				# If we get here we need to refresh the page
				redirect_to controller: :test_cases, action: :index and return
			end
		end
		render json: obj and return	
	end

end
