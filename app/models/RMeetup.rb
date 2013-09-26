class RMeetup < ActiveRecord::Base

  API_KEY = "2e2c342c1e7b93a141362e4427b7"

  def new_groups
	Client.api_key = "API_KEY"
	@gresults = Client.fetch(:groups, :lat => @user.latitude, :lon => @user.longitude, :topic => "parents")
  end
end