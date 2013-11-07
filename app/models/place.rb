class Place < ActiveRecord::Base
	belongs_to :user
  before_save :image_if_blank
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 40}
  validates :desc, presence: true, length: { maximum: 230}
  validates :address, presence: true

  has_many :reverse_place_relationships, foreign_key: "place_followed_id",
                                            class_name: "PlaceRelationship",
                                            dependent: :destroy
  has_many :followers, through: :reverse_place_relationships, source: :place_follower
  
	mount_uploader :uploader_image, ImageUploader
	geocoded_by :address do |place,results|
      if geo = results.first
        place.city = geo.city
        place.latitude = geo.latitude.to_f
      	place.longitude = geo.longitude.to_f
      end
    end
    after_validation :geocode, :if => :address_changed?

  def image_if_blank
    if uploader_image.blank and image_path.blank?
      self.image_path = "rotate/shutterstock_138159347.jpg"
    end
  end
end
