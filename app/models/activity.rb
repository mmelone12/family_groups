class Activity < ActiveRecord::Base
	belongs_to :user
	
	mount_uploader :uploader_image, ImageUploader
	geocoded_by :address do |activity,results|
      if geo = results.first
        activity.city = geo.city
      end
    end
    after_validation :geocode, :if => :address_changed?
end
