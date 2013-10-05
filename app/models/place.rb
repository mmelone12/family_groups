class Place < ActiveRecord::Base

	mount_uploader :uploader_image, ImageUploader
	geocoded_by :address do |place,results|
      if geo = results.first
        place.city = geo.city
      end
    end
    after_validation :geocode, :if => :address_changed?
end
