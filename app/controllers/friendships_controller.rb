class Friendships1Controller < ApplicationController
 def create
    @friendship1 = current_user.friendships1.build(:friend1_id => params[:friend1_id])
    if @friendship1.save
      flash[:notice] = "Added friend."
      redirect_to root_url
    else
      flash[:error] = "Unable to add friend."
      redirect_to root_url
    end
 end

 def destroy
   @friendship1 = current_user.friendships1.find(params[:id])
   @friendship1.destroy
   flash[:notice] = "Removed friendship."
   redirect_to current_user
 end
end