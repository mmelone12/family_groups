module ApplicationHelper
	def random_image
  		image_files = %w( .jpg .gif .png )
  		files = Dir.entries(
    	"app/assets/images/rotate/" 
  		).delete_if { |x| !image_files.index(x[-4,4]) }
  		files[rand(files.length)]
	end

	def title(page_title)
  		content_for :title, page_title.to_s
	end
end
