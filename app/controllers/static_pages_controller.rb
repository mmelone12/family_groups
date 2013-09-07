class StaticPagesController < ApplicationController
  def home
  	@user = current_user
  	@city = request.location.city
  end

  def team
  end

  def help
  end
end
