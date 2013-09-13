class StaticPagesController < ApplicationController
  def home
  	@user = current_user
  	@city = request.location.city
  	@interests = if current_user.following != nil then
  					Interest.where("id NOT IN (?)", current_user.relationships.pluck(:followed_id))
  				else Interest.all
  				end
  end

  def team
  end

  def help
  end
end
