class InterestsController < ApplicationController

def index
    @user = current_user
    @invite = Invite.new
    @message = current_user.sent_messages.build
    @messages = current_user.received_messages.paginate :per_page => 10, :page => params[:page], :include => :message, :order => "messages.created_at DESC"
    @sent_messages = current_user.sent_messages.paginate :per_page => 10, :page => params[:page], :order => "created_at DESC"
	if current_user.following.blank?
        @interests = Interest.all
    else
        new_interests = Interest.where("id NOT IN (?)", current_user.relationships.pluck(:followed_id))
        interest_ids = new_interests.find( :all, :select => 'id' ).map( &:id )
        @interests = Interest.find( (1..40).map { interest_ids.delete_at( interest_ids.size * rand ) } )
    end
  end

	def show
		@interest = Interest.find(params[:id])
	end
end
