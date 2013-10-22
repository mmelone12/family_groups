class Place < ActiveRecord::Base
	belongs_to :user
	mount_uploader :uploader_image, ImageUploader
	geocoded_by :address do |place,results|
      if geo = results.first
        place.city = geo.city
        place.latitude = geo.latitude.to_f
      	place.longitude = geo.longitude.to_f
      end
    end
    after_validation :geocode, :if => :address_changed?
end
