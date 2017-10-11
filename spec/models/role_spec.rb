require 'rails_helper'

RSpec.describe Role, type: :model do
  describe 'check validation' do
  	it 'validate presence' do
  		invalid_role = Role.new
  		invalid_role.role_name = ""
  		invalid_role.save
  		expect(invalid_role.errors.messages[:role_name][0]).to eq("can't be blank")
  	end
  	it 'validate uniqueness' do
  		role_1 = create(:role)
  		role_2 = Role.new
  		role_2.role_name = "admin"
  		role_2.save
  		expect(role_2.errors.messages[:role_name][0]).to eq("has already been taken")
  	end
  end
end
