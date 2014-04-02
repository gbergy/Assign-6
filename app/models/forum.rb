class Forum < ActiveRecord::Base
	has_many :replys
	has_many :users, through: :replys
end
