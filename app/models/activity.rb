class Activity < ActiveRecord::Base

	geocoded_by :address do |activity,results|
      if geo = results.first
        activity.city = geo.city
      end
    end
    after_validation :geocode, :if => :address_changed?
end
