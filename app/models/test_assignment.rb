class TestAssignment < ActiveRecord::Base
	belongs_to :test_cases
	belongs_to :component_details

	def self.return_component_details(test_case)		
		rtnHash = {}
		z = 0
		test_case.test_assignments.each do |ele|
binding.pry			
			component_name = ComponentDetail.where(id: ele.component_detail_id).pluck(:component_name)[0]
			selfArr = []
			x = 1
			y = 0
			while x < 10
				case x
					when 1
						if ele.param_1 != nil && ele.param_1 != ""
							selfArr.push(ele.param_1)
							y += 1
						end
					when 2
						if ele.param_2 != nil && ele.param_2 != ""
							selfArr.push(ele.param_2)
							y += 1
						end
					when 3
						if ele.param_3 != nil && ele.param_3 != ""
							selfArr.push(ele.param_3)
							y += 1
						end
					when 4
						if ele.param_4 != nil && ele.param_4 != ""
							selfArr.push(ele.param_4)
							y += 1
						end
					when 5
						if ele.param_5 != nil && ele.param_5 != ""
							selfArr.push(ele.param_5)
							y += 1
						end
					when 6
						if ele.param_6 != nil && ele.param_6 != ""
							selfArr.push(ele.param_6)
							y += 1
						end
					when 7
						if ele.param_7 != nil && ele.param_7 != ""
							selfArr.push(ele.param_7)
							y += 1
						end 
					when 8
						if ele.param_8 != nil && ele.param_8 != ""
							selfArr.push(ele.param_8)
							y += 1
						end
					when 9
						if ele.param_9 != nil && ele.param_9 != ""
							selfArr.push(ele.param_9)
							y += 1
						end
					when 10
						if ele.param_10 != nil && ele.param_10 != ""
							selfArr.push(ele.param_10)
							y += 1
						end
				end
				x += 1
			end
			rtnHash.store(component_name, selfArr)
			if z < y
				z = y
			end
		end

		return rtnHash, z
	end

end
