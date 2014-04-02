class User < ActiveRecord::Base
	has_many :replys
	has_many :forums, through: :replys
end
