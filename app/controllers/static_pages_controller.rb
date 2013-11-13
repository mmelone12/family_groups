class StaticPagesController < ApplicationController

  def home
    RMeetup::Client.api_key = "2e2c342c1e7b93a141362e4427b7"
  	@city = request.location.city
    if signed_in?
      @user = current_user
      @male_avatars = Avatar.all.where('gender IS ?', nil)
      @female_avatars = Avatar.all.where('gender IS NOT NULL')
      @message = current_user.sent_messages.build
      @messages = current_user.received_messages.paginate :per_page => 10, :page => params[:page], :include => :message, :order => "messages.created_at DESC"
      @sent_messages = current_user.sent_messages.paginate :per_page => 10, :page => params[:page], :order => "created_at DESC"
      @invite = Invite.new
      new_groups = RMeetup::Client.fetch(:groups, :lat => @user.latitude, :lon => @user.longitude, :topic => "parents")
      current_group_ids = current_user.groups.pluck(:group_id)
      @groups = new_groups.reject { |group| current_group_ids.include?(group.id) }
      @group = Group.create
      @firstgroups = @groups.first(20)
      @other_groups = Group.where(['group_id IS ? AND user_id <> ? AND city = ?', nil, current_user.id, @user.city])
      current_activity_ids = current_user.activity_following.pluck(:activity_followed_id)
      new_activities = Activity.where('start_date >= ? AND user_id <> ?', 0.days.ago(Time.now).to_date, current_user.id )
      nearby_activities = new_activities.near(@user, 100).all( :order => "start_date", :limit => 20 )
      @activities = nearby_activities.reject { |activity| current_activity_ids.include?(activity.id) }
      recurring_activities = Activity.where(['recurring = ?', "yes"]).near(@user, 100).first(5)
      @recurring_activities = recurring_activities.reject { |activity| current_activity_ids.include?(activity.id) }
      current_place_ids = current_user.place_following.pluck(:place_followed_id)
      @places = Place.near(@user, 100).first(15).reject { |place| current_place_ids.include?(place.id) }
      other_user = User.near(@user).where.not(id: current_user.id).where(['gender = ?', current_user.gender ]).where(['single_parent = ? OR new_parent = ? OR special_needs = ?
        OR children_under_5 = ? OR children_5_10 = ? OR tweens = ? OR teens = ? OR non_parent = ?',
        current_user.single_parent, current_user.new_parent, current_user.special_needs,
        current_user.children_under_5, current_user.children_5_10, current_user.tweens, current_user.teens,
        current_user.non_parent])
      if other_user.empty? && User.near(@user, 100).where.not(id: current_user.id).present?
        @matched_user = Rails.cache.fetch(@user.cache_key + '/daily_match', expires_in: 1.day){
        User.near(@user, 100).where.not(id: current_user.id).order("RANDOM()").first}
      end
      if other_user.present?
        @matched_user = Rails.cache.fetch(@user.cache_key + '/daily_match', expires_in: 1.day){
        other_user.order("RANDOM()").first}
      end
      if other_user.empty? && User.near(@user, 100).where.not(id: current_user.id).empty?
        @matched_user = Rails.cache.fetch(@user.cache_key + '/daily_match', expires_in: 1.day){
        User.order("RANDOM()").first}
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
          @interests = Interest.first(25)
      else
          newinterests = Interest.where("id NOT IN (?)", current_user.relationships.pluck(:followed_id))
          interest_ids = newinterests.find( :all, :select => 'id' ).map( &:id )
          @interests = Interest.find( (1..20).map { interest_ids.delete_at( interest_ids.size * rand ) } )
      end
    else
      @groups = RMeetup::Client.fetch(:groups, :lat => request.location.latitude, :lon => request.location.longitude, :topic => "parents").first(12)
      @interests = Interest.order("RANDOM()").first(20)
      @places = Place.near(@city, 100).first(15)
      activities = Activity.where('start_date IS NOT NULL')
      new_activities = activities.where('start_date >= ?', 0.days.ago(Time.now).to_date)
      @activities = new_activities.near(@city, 100).all( :order => "start_date", :limit => 18)
      @recurring_activities = Activity.where(['recurring = ?', "yes"]).near(@city, 100).first(5)
    end
  end

  def howitworks
  end

  def team
  end

  def contact
  end

  def premium
  end

  def signupalready
  end
end
