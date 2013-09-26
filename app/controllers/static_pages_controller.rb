class StaticPagesController < ApplicationController
  def home
  	@user = current_user
  	@city = request.location.city
    if signed_in?
	    new_groups = RMeetup::Client.fetch(:groups, :lat => @user.latitude, :lon => @user.longitude, :topic => "parents")
      current_group_ids = current_user.groups.pluck(:group_id)
      @groups = new_groups.reject { |group| current_group_ids.include?(group.id) }
      @firstgroups = @groups.first(20)
      @other_groups = Group.where(['group_id IS ? AND user_id <> ? AND city = ?', nil, current_user.id, @user.city])
      @group = Group.create
        if current_user.following.blank?
          @interests = Interest.all
        else
          @newinterests = Interest.where("id NOT IN (?)", current_user.relationships.pluck(:followed_id))
          interest_ids = @newinterests.find( :all, :select => 'id' ).map( &:id )
          @interests = Interest.find( (1..8).map { interest_ids.delete_at( interest_ids.size * rand ) } )
        end
    else
      @groups = RMeetup::Client.fetch(:groups, :city => @city, :topic => "parents")
      @firstgroups = @groups.first(20)
      @group = Group.create
      @interests = Interest.all
    end
  end

  def team
  end

  def help
  end
end
