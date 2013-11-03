class FriendshipsController < ApplicationController
	def create
      @user = current_user
  		@friendship = current_user.friendships.build(:friend_id => params[:friend_id])
      @friendship.save
      Message.create!({author_id: current_user.id, body: "I just friended you.", subject: "You've just been friended",
      to: User.find(@friendship.friend) })
      UserMailer.friended(@friendship).deliver
      respond_to do |format|
          format.html { redirect_to(root_url) }
          format.js 
  		end
	end

	def destroy
  		@friendship = current_user.friendships.find(params[:id])
  		@friendship.destroy
  		flash[:notice] = "Removed friendship."
  	redirect_to current_user
	end
end
