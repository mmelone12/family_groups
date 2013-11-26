class Post < ActiveRecord::Base
	validates :body, presence: true
	validates :title, presence: true
	has_many :comments

	def author_picture
		if author_name == "Rachel"
			image = "blog/rachel_portrait.jpg"
		end
		if author_name == "Matt"
			image = "blog/matt_portrait.jpg"
		end
		image
	end
end
