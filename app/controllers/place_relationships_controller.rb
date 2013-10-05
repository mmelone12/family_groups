class PlaceRelationshipsController < ApplicationController

 def create
    @place = Place.find(params[:place_relationship][:place_followed_id])
    current_user.place_follow!(@place)
    respond_to do |format|
      	format.html { redirect_to(root_url) }
     	  format.js 
    end
 end

   def destroy
    @place = Place_Relationship.find(params[:id]).place_followed
    current_user.place_unfollow!(@place)
    respond_to do |format|
      format.html { redirect_to(root_url) }
      format.js 
    end
  end
end