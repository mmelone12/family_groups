class StaticPagesController < ApplicationController
  def home
  	@user = current_user
  	@city = request.location.city    	
  	@interests = Interest.all
  	RMeetup::Client.api_key = "2e2c342c1e7b93a141362e4427b7"
	@groups = RMeetup::Client.fetch(:groups,{:zip => "94702", :topic => "parents"})
  end

  def team
  end

  def help
  end
end
