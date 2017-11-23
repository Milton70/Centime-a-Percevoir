class TestExecution < ActiveRecord::Base
	has_many :test_cases
	has_many :test_data
	has_many :test_environments

	def self.create_json_file

		trHash 			= {}
		to_jsonHash = {}

			# Get the test scenario details from the test execution
			tr = self.find(1)
			trHash.store('test_scenario_name', tr.test_scenario_name)

			# Get test case, components and parameter data
			tcHash, tfHash = add_test_cases(tr, tr.test_case_id)

			# Get associated test data
			tdHash = add_test_data(tr, tr.test_data_id)			

			# Get associated test environments
			teHash = add_test_env(tr, tr.test_env_id)

			# Build the hierarchy
			tcHash.store('test_data', tdHash)
			tcHash.store('test_environment', teHash)
			tcHash.store('test_files', tfHash)
			trHash.store('test_cases', tcHash)

			to_jsonHash.store('test_execution', trHash)
			#end_point = "https://jsonplaceholder.typicode.com/posts"

			#@payload = {
			#	title: 'foo',
			#	body: 'bar',
			#	userId: 1
			#}.to_json

			#response = HTTParty.post(end_point, body: @payload, headers: {'Content-Type' => 'application/json', 'Accept' => 'application/json'})

			return to_jsonHash.to_json
		end

		private 

			def self.add_test_data(tr, id)
				tdHash = {}
				td = tr.test_data.find(id)
				tdHash.store('model_id',td.model_id)
				tdHash.store('model_desc',td.model_desc)
				tdHash.store('party_id_type',td.party_id_type)
				tdHash.store('party_id',td.party_id)
				tdHash.store('bei',td.bei)
				tdHash.store('account',td.account)
				tdHash.store('associated_bank',td.associated_bank)
				tdHash.store('name',td.name)
				tdHash.store('address_lines',td.address_lines)
				tdHash.store('country_code',td.country_code)
				tdHash.store('city',td.city)
				tdHash.store('postal_code',td.postal_code)

				return tdHash
			end

			def self.add_test_cases(tr, id)
				tcHash = {}
				taHash = {}
				tfHash = {}
				# Get associated test cases
				tc = tr.test_cases.find(id)
				tcHash.store('test_case_name', tc.test_case_name)
				tcHash.store('test_case_status', tc.status)
				tcHash.store('test_case_desc', tc.description)
				# Get the components			
				tc.test_assignment_ids.each do |comp_id|
					tempHash = {}
					the_comp = ComponentDetail.where(id: comp_id)[0]
					tempHash.store('component_name', the_comp.component_name)
					x = 1					
					while x <= 10
						case x
							when 1
								if the_comp.component_param_1 != nil && the_comp.component_param_1 != ""
									tempHash.store('param_1', the_comp.component_param_1)
									if the_comp.component_param_1.index('test_file')						
										tfHash = add_test_file(the_comp.component_param_1.split(':')[1], tfHash)
									end
								end
							when 2
								if the_comp.component_param_2 != nil && the_comp.component_param_2 != ""
									tempHash.store('param_2', the_comp.component_param_2)
									if the_comp.component_param_2.index('test_file')
										tfHash = add_test_file(the_comp.component_param_2.split(':')[1], tfHash)							
									end
								end
							when 3
								if the_comp.component_param_3 != nil && the_comp.component_param_3 != ""
									tempHash.store('param_3', the_comp.component_param_3)
									if the_comp.component_param_3.index('test_file')
										tfHash = add_test_file(the_comp.component_param_3.split(':')[1], tfHash)
									end
								end
							when 4
								if the_comp.component_param_4 != nil && the_comp.component_param_4 != ""
									tempHash.store('param_4', the_comp.component_param_4)
									if the_comp.component_param_4.index('test_file')
										tfHash = add_test_file(the_comp.component_param_4.split(':')[1], tfHash)
									end
								end
							when 5
								if the_comp.component_param_5 != nil && the_comp.component_param_5 != ""
									tempHash.store('param_5', the_comp.component_param_5)
									if the_comp.component_param_5.index('test_file')
										tfHash = add_test_file(the_comp.component_param_5.split(':')[1], tfHash)
									end
								end
							when 6
								if the_comp.component_param_6 != nil && the_comp.component_param_6 != ""
									tempHash.store('param_6', the_comp.component_param_6)
									if the_comp.component_param_6.index('test_file')
										tfHash = add_test_file(the_comp.component_param_6.split(':')[1], tfHash)
									end
								end
							when 7
								if the_comp.component_param_7 != nil && the_comp.component_param_7 != ""
									tempHash.store('param_7', the_comp.component_param_7)
									if the_comp.component_param_7.index('test_file')
										tfHash = add_test_file(the_comp.component_param_7.split(':')[1], tfHash)
									end
								end
							when 8
								if the_comp.component_param_8 != nil && the_comp.component_param_8 != ""
									tempHash.store('param_8', the_comp.component_param_8)
									if the_comp.component_param_8.index('test_file')
										tfHash = add_test_file(the_comp.component_param_8.split(':')[1], tfHash)
									end
								end
							when 9
								if the_comp.component_param_9 != nil && the_comp.component_param_9 != ""
									tempHash.store('param_9', the_comp.component_param_9)
									if the_comp.component_param_9.index('test_file')
										tfHash = add_test_file(the_comp.component_param_9.split(':')[1], tfHash)
									end
								end					
							when 10
								if the_comp.component_param_10 != nil && the_comp.component_param_10 != ""
									tempHash.store('param_10', the_comp.component_param_10)
									if the_comp.component_param_10.index('test_file')
										tfHash = add_test_file(the_comp.component_param_10.split(':')[1], tfHash)
									end
								end
						end
						x += 1
					end

					taHash.store(comp_id, tempHash)
				end
				tcHash.store('components', taHash)

				return tcHash, tfHash
			end

			def self.add_test_env(tr, id)
				teHash = {}
				te = tr.test_environments.find(id)
				teHash.store('test_env_id',te.test_env_id)
				teHash.store('app_url',te.app_url)
				teHash.store('app_user_id_1',te.app_user_id_1)
				teHash.store('app_pwd_1',te.app_pwd_1)
				teHash.store('app_user_id_2',te.app_user_id_2)
				teHash.store('app_pwd_2',te.app_pwd_2)
				teHash.store('db_server',te.db_server)
				teHash.store('db_port',te.db_port)
				teHash.store('db_service_name',te.db_service_name)
				teHash.store('db_user_id',te.db_user_id)
				teHash.store('db_pwd',te.db_pwd)
				teHash.store('mq_server',te.mq_server)
				teHash.store('mq_channel_name',te.mq_channel_name)
				teHash.store('mq_port',te.mq_port)
				teHash.store('mq_q_manager',te.mq_q_manager)
				teHash.store('mq_in_q_name',te.mq_in_q_name)
				teHash.store('mq_user_id',te.mq_user_id)
				teHash.store('mq_pwd',te.mq_pwd)

				return teHash
			end

			def self.add_test_file(test_file_id, tfInHash)		
				# See if we already have a hash with this file
				if tfInHash == {}
					tfHash = {}
					test_file = TestFile.where(test_file_id: test_file_id)[0]
					tfHash.store('test_file_id', test_file_id)
					tfHash.store('test_file_type', test_file.test_file_type)
					tfHash.store('schema_name', test_file.schema_name)
					tfHash.store('required_execution_date', test_file.required_execution_date)
					tfHash.store('payment_information_id', test_file.payment_information_id)
					tfHash.store('number_of_instructions', test_file.number_of_instructions)
					tfHash.store('batch_booking', test_file.batch_booking)
					tfHash.store('number_of_transactions', test_file.number_of_transactions)
					tf = TestFile.find(test_file.id)
					txnHash = {}
					tf.transactions.each do |txn|							
						txnTemp = {}
						txnTemp.store('transaction_end_to_end_id', txn.transaction_end_to_end_id)
						txnTemp.store('transaction_amount', txn.transaction_amount)
						txnTemp.store('transaction_currency', txn.transaction_currency)
						txnTemp.store('other_counterparty', txn.other_counterparty)
						txnTemp.store('other_counterparty_iban', txn.other_counterparty_iban)
						txnTemp.store('other_counterparty_name', txn.other_counterparty_name)
						txnHash.store(txn.id, txnTemp)
					end
					tfHash.store('transaction_counter', txnHash)
					# See if the file type exists in the file type extras table and bring that data in if so
					tfHash = add_test_file_extras(test_file.test_file_type, tfHash)			
					tfInHash.store(1, tfHash)
				else
					tfInHash.to_a.each do |ele|
						if ele[1]['test_file_id'] != test_file_id			
							test_file = TestFile.where(test_file_id: test_file_id)[0]			
							if test_file != nil	
								tf_counter = tfInHash.to_a[0][0] + 1
								tfHash = {}
								test_file = TestFile.where(test_file_id: test_file_id)[0]
								tfHash.store('test_file_id', test_file_id)
								tfHash.store('test_file_type', test_file.test_file_type)
								tfHash.store('schema_name', test_file.schema_name)
								tfHash.store('required_execution_date', test_file.required_execution_date)
								tfHash.store('payment_information_id', test_file.payment_information_id)
								tfHash.store('number_of_instructions', test_file.number_of_instructions)
								tfHash.store('batch_booking', test_file.batch_booking)
								tfHash.store('number_of_transactions', test_file.number_of_transactions)
								tf = TestFile.find(test_file.id)
								txnHash = {}
								txn_counter = 1
								tf.transactions.each do |txn|							
									txnTemp = {}
									txnTemp.store('transaction_end_to_end_id', txn.transaction_end_to_end_id)
									txnTemp.store('transaction_amount', txn.transaction_amount)
									txnTemp.store('transaction_currency', txn.transaction_currency)
									txnTemp.store('other_counterparty', txn.other_counterparty)
									txnTemp.store('other_counterparty_iban', txn.other_counterparty_iban)
									txnTemp.store('other_counterparty_name', txn.other_counterparty_name)
									txnHash.store(txn_counter, txnTemp)
									txn_counter += 1
								end
								tfHash.store('transaction_counter', txnHash)
								# See if the file type exists in the file type extras table and bring that data in if so
								tfHash = add_test_file_extras(test_file.test_file_type, tfHash)			
								tfInHash.store(tf_counter, tfHash)
							end
						end
					end
				end

				return tfInHash
			end

			def self.add_test_file_extras(test_file_type, thisHash)
				tfe = TestFileExtra.find_by(test_file_type: test_file_type)
				if tfe != nil
					thisHash.store('mq_in_q_name', tfe.mq_in_q_name)
					thisHash.store('bankGroupId', tfe.bankGroupId)
					thisHash.store('bankName', tfe.bankName)
					thisHash.store('fileName', tfe.fileName)
					thisHash.store('exchangeConditionExternalId', tfe.exchangeConditionExternalId)
					thisHash.store('file_location', tfe.file_location)
				end
				return thisHash
			end
end
