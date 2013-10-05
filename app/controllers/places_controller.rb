class PlacesController < ApplicationController

def show
  	@place = Place.find(params[:id])
  end

  def new
  	@place = Place.new
  end

  def create
  	@place = Place.new(place_params)
    @place.save
    current_user.place_follow!(@place)
  	respond_to do |format|
      format.html { redirect_to(root_url) }
      format.js 
    end
  end

  def edit
  end

  private

  	def place_params
  		params.require(:place).permit(:name, :image_path, :address, :city, 
  			 :desc, :link, :uploader_image, :website, :website_link)
  	end
end
