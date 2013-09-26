module ApplicationHelper
	def random_image
  		image_files = %w( .jpg .gif .png )
  		files = Dir.entries(
    	"app/assets/images/rotate/" 
  		).delete_if { |x| !image_files.index(x[-4,4]) }
  		files[rand(files.length)]
	end

  def new_groups
    RMeetup::Client.fetch(:groups, :lat => @user.latitude, :lon => @user.longitude, :topic => "parents")
  end

  def new_user_groups
    RMeetup::Client.fetch(:groups, :city => @city, :topic => "parents")
  end

end
