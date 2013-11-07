class Activity < ActiveRecord::Base
	belongs_to :user
  validates :title, uniqueness: { case_sensitive: false }
  validates :address, presence: true
  validates :desc, presence: true
  #validate :has_image
  #validate :has_date
  validates :uploader_image, presence: true

  #def has_image
  #  unless image_path.present or uploader_image
  #    errors.add_to_base "Must have an image"
  #  end
  #end

  def has_date
    unless start_date or :when 
      errors.add_to_base "Must have a date"
    end
  end
	
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
