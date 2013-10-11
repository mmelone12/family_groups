class GroupRelationshipsController < ApplicationController

 def create
    @group = Group.find(params[:group_relationship][:group_followed_id])
    current_user.group_follow!(@group)
    respond_to do |format|
      	format.html { redirect_to(root_url) }
     	  format.js 
    end
  end

   def destroy
    @group = GroupRelationship.find(params[:id]).group_followed
    current_user.group_unfollow!(@group)
    respond_to do |format|
      format.html { redirect_to(root_url) }
      format.js 
    end
  end
end