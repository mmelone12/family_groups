class StaticPagesController < ApplicationController
  def home
  	@user = current_user
  	@city = request.location.city    	
  	@interests = Interest.all
  end

  def team
  end

  def help
  end
end
