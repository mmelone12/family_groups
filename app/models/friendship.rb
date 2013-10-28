class Friendship1 < ActiveRecord::Base
	belongs_to :user
	belongs_to :friend1, :class_name => "User"
end
