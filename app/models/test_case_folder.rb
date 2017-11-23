class TestCaseFolder < ActiveRecord::Base
	has_ancestry
	has_many :test_cases

	def self.if_folder_has_sub_folder_check_linked_scenarios(folder, msg)
		# Get the last descendant
		last_desc = folder.descendants.last
		if last_desc == nil
			last_desc = folder
			next_from_last = last_desc
		else
			next_from_last = last_desc.parent
		end
		if last_desc.test_cases == []
			# No components to delete so this one can be deleted
			last_desc.destroy
		else
			# Loop round components and see if they've got linked test cases
			last_desc.test_cases.each do |obj|		
				if obj.test_sceario_id == nil || obj.test_scenario_id == 0
					obj.destroy
				else
					msg << test_case_name + ", "
				end
			end
			if last_desc.test_cases.count == 0
				last_desc.destroy
			end
		end
		# See if we loop up the parent/child chain
		if folder != next_from_last		
			if_folder_has_sub_folder_check_linked_scenarios next_from_last, msg
		else
			if folder.descendants.last != nil
				if folder.test_cases == [] && msg == ""
					folder.destroy
				else
					folder.test_cases.each do |obj|						
						if obj.test_scenario_id == nil || obj.test_scenario_id == 0
							obj.destroy
						else
							msg << obj.test_case_name + ", "
						end
					end
				end
				if folder.test_cases.count == 0 && msg == ""
					folder.destroy
				end
			end
		end
		if msg[-2] == ','
			msg = msg[0...-2]
		end
		return msg
	end
end
