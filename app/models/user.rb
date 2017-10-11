class User < ActiveRecord::Base
	has_secure_password

	EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i

	has_many :assignments
	has_many :roles, through: :assignments

	validates :user_id, presence: true, uniqueness: true
	validates :user_name, presence: true
	validates :user_email, presence: true, uniqueness: true, format: EMAIL_REGEX

end
