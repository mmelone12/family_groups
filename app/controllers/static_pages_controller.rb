class StaticPagesController < ApplicationController

  def home
    RMeetup::Client.api_key = "2e2c342c1e7b93a141362e4427b7"
  	@user = current_user
  	@city = request.location.city
    if signed_in?
      new_groups = RMeetup::Client.fetch(:groups, :lat => @user.latitude, :lon => @user.longitude, :topic => "parents")
      current_group_ids = current_user.groups.pluck(:group_id)
      @groups = new_groups.reject { |group| current_group_ids.include?(group.id) }
      @firstgroups = @groups.first(20)
      @other_groups = Group.where(['group_id IS ? AND user_id <> ? AND city = ?', nil, current_user.id, @user.city])
      @group = Group.create
      @activities = Activity.all
      @other_activities = Activity.where(['user_id <> ? AND city = ?', current_user.id, @user.city])
      @places = Place.all
      @other_places = Place.where(['user_id <> ? AND city = ?', current_user.id, @user.city])
        if current_user.following.blank?
          @interests = Interest.all
        else
          @newinterests = Interest.where("id NOT IN (?)", current_user.relationships.pluck(:followed_id))
          interest_ids = @newinterests.find( :all, :select => 'id' ).map( &:id )
          @interests = Interest.find( (1..8).map { interest_ids.delete_at( interest_ids.size * rand ) } )
        end
    else
      @group = Group.create
      @interests = Interest.all
    end
  end

  def team
  end

  def help
  end
end
