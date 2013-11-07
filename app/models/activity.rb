class Activity < ActiveRecord::Base
	belongs_to :user
  before_save :image_if_blank
  validates :title, uniqueness: { case_sensitive: false }
  validates :address, presence: true
  validates :desc, presence: true
  #validate :has_image
  #validate :has_date

  #has_many :activity_relationships, :class_name => "ActivityRelationship", :foreign_key => "activity_follower_id"
  #has_many :followers, :through => :activity_relationships, :source => :activity_follower

  has_many :reverse_activity_relationships, foreign_key: "activity_followed_id",
                                            class_name: "ActivityRelationship",
                                            dependent: :destroy
  has_many :followers, through: :reverse_activity_relationships, source: :activity_follower
	
	mount_uploader :uploader_image, ImageUploader
	geocoded_by :address do |activity,results|
      if geo = results.first
        activity.city = geo.city
        activity.latitude = geo.latitude.to_f
      	activity.longitude = geo.longitude.to_f
      end
    end
    after_validation :geocode, :if => :address_changed?

  protected

  def image_if_blank
    if uploader_image.blank?
      self.image_path = "rotate/shutterstock_138159941.jpg"
    end
  end
end
