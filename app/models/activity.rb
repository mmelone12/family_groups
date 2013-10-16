class Activity < ActiveRecord::Base
	belongs_to :user
  validates :title, uniqueness: { case_sensitive: false }
	
	mount_uploader :uploader_image, ImageUploader
	geocoded_by :address do |activity,results|
      if geo = results.first
        activity.city = geo.city
        activity.latitude = geo.latitude.to_f
      	activity.longitude = geo.longitude.to_f
      end
    end
    after_validation :geocode, :if => :address_changed?
end
