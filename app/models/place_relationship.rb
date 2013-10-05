class PlaceRelationship < ActiveRecord::Base

  belongs_to :place_follower, :class_name => "User"
  belongs_to :place_followed, :class_name => "Place"
  
  validates :place_follower_id, :presence => true
  validates :place_followed_id, :presence => true

end
