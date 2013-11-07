class Group < ActiveRecord::Base
	belongs_to :user
	before_save :image_if_blank
	validates :user_id, presence: true
	validates :name, presence: true, length: { maximum: 40}
	validates :desc, presence: true, length: { maximum: 230}
	validates :address, presence: true

	has_many :reverse_group_relationships, foreign_key: "group_followed_id",
                                            class_name: "GroupRelationship",
                                            dependent: :destroy
    has_many :followers, through: :reverse_group_relationships, source: :group_follower


	mount_uploader :uploader_image, ImageUploader

	geocoded_by :address do |user,results|
    	if geo = results.first
      		user.city = geo.city
    	end
  	end
  	after_validation :geocode, :if => :address_changed?

  def image_if_blank
    if uploader_image.blank?
      self.image_path = "rotate/shutterstock_16170193.jpg"
    end
  end
end
