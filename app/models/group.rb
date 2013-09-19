class Group < ActiveRecord::Base
	belongs_to :user
	validates :user_id, presence: true
	validates :name, presence: true, length: { maximum: 40}
	validates :desc, presence: true, length: { maximum: 230}
end
