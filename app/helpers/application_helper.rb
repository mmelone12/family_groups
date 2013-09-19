module ApplicationHelper
	def random_image
  		image_files = %w( .jpg .gif .png )
  		files = Dir.entries(
    	"app/assets/images/rotate/" 
  		).delete_if { |x| !image_files.index(x[-4,4]) }
  		files[rand(files.length)]
	end

	def random_image1
  blacklist = [".", ".."]
  file_names = Dir.glob("app/assets/images/rotate/*")
  blacklist.each do |blacklsited|
    file_names.delete(blacklisted)
  end
  "app/assets/images/rotate/{files.shuffle.first}"
end
end
