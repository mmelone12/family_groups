class StaticPagesController < ApplicationController

  def home
    RMeetup::Client.api_key = "2e2c342c1e7b93a141362e4427b7"
  	@user = current_user
  	@city = request.location.city
    if signed_in?
      @folder = current_user.inbox
      @message = current_user.sent_messages.build
      @messages = @folder.messages.paginate :per_page => 10, :page => params[:page], :include => :message, :order => "messages.created_at DESC"
      new_groups = RMeetup::Client.fetch(:groups, :lat => @user.latitude, :lon => @user.longitude, :topic => "parents")
      current_group_ids = current_user.groups.pluck(:group_id)
      @groups = new_groups.reject { |group| current_group_ids.include?(group.id) }
      @firstgroups = @groups.first(20)
      @other_groups = Group.where(['group_id IS ? AND user_id <> ? AND city = ?', nil, current_user.id, @user.city])
      @group = Group.create
      activities = Activity.where('start_date IS NOT NULL AND user_id <> ?', current_user.id)
      @activities = activities.near(@user).all( :order => "start_date", :limit => 15)
      @recurring_activities = Activity.where(['recurring = ?', "yes"]).first(5)
      @places = Place.near(@user).first(15)
      @other_places = Place.where(['user_id <> ? AND city = ?', current_user.id, @user.city]).first(10)
      other_user = User.near(@user).where.not(id: current_user.id).where(['gender = ? AND single_parent = ? OR new_parent = ? OR special_needs = ?
        OR children_under_5 = ? OR children_5_10 = ? OR tweens = ? OR teens = ? OR non_parent = ?',
        current_user.gender, current_user.single_parent, current_user.new_parent, current_user.special_needs,
        current_user.children_under_5, current_user.children_5_10, current_user.tweens, current_user.teens,
        current_user.non_parent])
      if other_user.empty? && User.near(@user).present?
        @matched_user = Rails.cache.fetch(@user.cache_key + '/daily_match', expires_in: 1.day){
        User.near(@user).order("RANDOM()").first}
      else
        @matched_user = Rails.cache.fetch(@user.cache_key + '/daily_match', expires_in: 1.day){
        other_user.order("RANDOM()").first}
      end
       # current_user.new_parent).near(@user).order("RANDOM()").first
      #if other_user_alpha.present?
      #  other_user = other_user_alpha
      #end
      #current_user_interest_ids = current_user.following.pluck(:id)
      #matched_interests = other_user.following.pluck(:id)
      #matched_user = other_user.where(following.pluck(:id).include?(current_user_interest_ids))
      #@other_user1 = other_user
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
      @places = Place.where('city IS ?', @city)
    end
  end

  def team
  end

  def help
  end
end
