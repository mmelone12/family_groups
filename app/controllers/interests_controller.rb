class InterestsController < ApplicationController

def index
	if current_user.following.blank?
        @interests = Interest.all
    else
        @newinterests = Interest.where("id NOT IN (?)", current_user.relationships.pluck(:followed_id))
        interest_ids = @newinterests.find( :all, :select => 'id' ).map( &:id )
        @interests = Interest.find( (1..40).map { interest_ids.delete_at( interest_ids.size * rand ) } )
    end
  end
end
