class RelationshipsController < ApplicationController

  def create
    @interest = Interest.find(params[:relationship][:followed_id])
    @group = Group.find(params[:relationship][:followed_id])
    current_user.follow!(@interest)
    respond_to do |format|
      	format.html { redirect_to(root_url) }
     	  format.js 
    end
  end

   def destroy
    @interest = Relationship.find(params[:id]).followed
    current_user.unfollow!(@interest)
    respond_to do |format|
      format.html { redirect_to(root_url) }
      format.js 
    end
  end
end