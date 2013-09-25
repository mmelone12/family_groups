class GroupRelationship < ActiveRecord::Base
  
  belongs_to :group_follower, :class_name => "User"
  belongs_to :group_followed, :class_name => "Group"
  
  validates :group_follower_id, :presence => true
  validates :group_followed_id, :presence => true
end

