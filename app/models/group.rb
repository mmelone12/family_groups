class Group < ActiveRecord::Base
	belongs_to :user
	validates :user_id, presence: true
	validates :name, presence: true, length: { maximum: 40}
	validates :desc, presence: true, length: { maximum: 230}
	mount_uploader :image_path, ImageUploader

	geocoded_by :address do |user,results|
    	if geo = results.first
      		user.city = geo.city
    	end
  	end
  	after_validation :geocode, :if => :address_changed?

  	RMeetup::Client.api_key = "2e2c342c1e7b93a141362e4427b7"
end
