class StaticPagesController < ApplicationController
  def home
  	@user = current_user
  	@city = request.location.city   	
  	@interests = Interest.all
  	RMeetup::Client.api_key = "2e2c342c1e7b93a141362e4427b7"
    if signed_in?
	    @groups = RMeetup::Client.fetch(:groups, :lat => @user.latitude, :lon => @user.longitude, :topic => "parents")
      @firstgroups = @groups.first(20)
      @group = Group.new
    else
      @groups = RMeetup::Client.fetch(:groups, :city => @city, :topic => "parents")
      @firstgroups = @groups.first(20)
      @group = Group.new 
    end
  end

  def team
  end

  def help
  end
end
