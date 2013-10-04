class ActivityRelationship < ActiveRecord::Base

  belongs_to :activity_follower, :class_name => "User"
  belongs_to :activity_followed, :class_name => "Activity"
  
  validates :activity_follower_id, :presence => true
  validates :activity_followed_id, :presence => true

end
