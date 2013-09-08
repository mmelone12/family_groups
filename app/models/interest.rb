class Interest < ActiveRecord::Base

  has_many :relationships, :foreign_key => "followed_id",
                            :class_name => "relationship"
  has_many :followers, :through => :reverse_relationships, 
                        :source => :follower   
end
