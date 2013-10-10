class ActivityRelationshipsController < ApplicationController

 def create
    @activity = Activity.find(params[:activity_relationship][:activity_followed_id])
    current_user.activity_follow!(@activity)
    respond_to do |format|
      	format.html { redirect_to(root_url) }
     	  format.js 
    end
 end

   def destroy
    @activity = ActivityRelationship.find(params[:id]).activity_followed
    current_user.activity_unfollow!(@activity)
    respond_to do |format|
      format.html { redirect_to(root_url) }
      format.js 
    end
  end
end