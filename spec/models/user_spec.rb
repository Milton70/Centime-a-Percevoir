require 'rails_helper'

RSpec.describe User, type: :model do
  context "model presence validations" do
  	it "validates presence of user id" do
  		user 						= User.new
  		user.user_id 		= ""
  		user.user_name 	= ""
  		user.user_email = ""
  		user.save
  		expect(user.errors.messages[:user_id][0]).to eq("can't be blank")
  	end
  	it "validates presence of user name" do
			user 						= User.new
  		user.user_id 		= ""
  		user.user_name 	= ""
  		user.user_email = ""
  		user.save	
  		expect(user.errors.messages[:user_name][0]).to eq("can't be blank")
  	end
  	it "validates presence of user email" do
			user 						= User.new
  		user.user_id 		= ""
  		user.user_name 	= ""
  		user.user_email = ""
  		user.save	
  		expect(user.errors.messages[:user_email][0]).to eq("can't be blank")
  	end
  end

  context "model uniqueness validation" do  	
  	it "validates uniqueness of user id" do
  		user_1 									= User.new
  		user_1.user_id 					= "Mik.Bartram"
  		user_1.user_name 				= "Michael Bartram"
  		user_1.user_email 			= "michael.bartram@redcompass.com"
  		user_1.password_digest 	= "blahdeblah"
  		user_1.save

			user_2 = User.new
  		user_2.user_id 					= "Mik.Bartram"
  		user_2.user_name 				= "Michael Bartram"
  		user_2.user_email 			= "michael.bartram@redcompass.com"
  		user_2.password_digest 	= "blahdeblah"
  		user_2.save
  		expect(user_2.errors.messages[:user_id][0]).to eq("has already been taken")
  	end
  	it "validates uniqueness of user email" do
  		user_1 									= User.new
  		user_1.user_id 					= "Mik.Bartram"
  		user_1.user_name 				= "Michael Bartram"
  		user_1.user_email 			= "michael.bartram@redcompass.com"
  		user_1.password_digest 	= "blahdeblah"
  		user_1.save

			user_2 									= User.new
  		user_2.user_id 					= "Mik.Bartram"
  		user_2.user_name 				= "Michael Bartram"
  		user_2.user_email 			= "michael.bartram@redcompass.com"
  		user_2.password_digest 	= "blahdeblah"
  		user_2.save
  		expect(user_2.errors.messages[:user_email][0]).to eq("has already been taken")
  	end
  end

  context "model email format validation" do
  	it "validates format of user email" do
  		user_1 						= User.new
  		user_1.user_id 		= "Mik.Bartram"
  		user_1.user_name 	= "Michael Bartram"
  		user_1.user_email = "bartram#redcompass.com"
  		user_1.save
  		expect(user_1.errors.messages[:user_email][0]).to eq("is invalid")
  	end
  end
end
