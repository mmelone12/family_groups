class InvitesController < ApplicationController
	def create
		@user = current_user
  		@invite = Invite.new(invite_params)
  		@invite.save
  		@recipient = @invite
  		#UserMailer.invite(@recipient).deliver
    	respond_to do |format|
      		format.html { redirect_to(root_url) }
     	  	format.js 
     	end
     end

    private

  	def invite_params
  		params.require(:invite).permit(:email, :user_id)
  	end
end
