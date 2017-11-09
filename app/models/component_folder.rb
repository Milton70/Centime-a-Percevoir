class ComponentFolder < ActiveRecord::Base
	has_ancestry
	has_many :component_details

	def self.if_folder_has_sub_folder_check_linked_components(folder, msg)
		# Get the last descendant
		last_desc = folder.descendants.last
		if last_desc == nil
			last_desc = folder
			next_from_last = last_desc
		else
			next_from_last = last_desc.parent
		end
		if last_desc.component_details == []
			# No components to delete so this one can be deleted
			last_desc.destroy
		else
			# Loop round components and see if they've got linked test cases
			last_desc.component_details.each do |comp|		
				if comp.test_case_id == nil || comp.test_case_id == 0
					comp.destroy
				else
					msg << comp.component_name + ", "
				end
			end
			if last_desc.component_details.count == 0
				last_desc.destroy
			end
		end
		# See if we loop up the parent/child chain
		if folder != next_from_last		
			if_folder_has_sub_folder_check_linked_components next_from_last, msg
		else
			if folder.descendants.last != nil
				if folder.component_details == [] && msg == ""
					folder.destroy
				else
					folder.component_details.each do |comp|						
						if comp.test_case_id == nil || comp.test_case_id == 0
							comp.destroy
						else
							msg << comp.component_name + ", "
						end
					end
				end
				if folder.component_details.count == 0 && msg == ""
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
