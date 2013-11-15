class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :following, :activity_following, :matches, :followers,
    :group_following, :group_followers, :activity_followers, :place_following, :place_followers]
  before_action :correct_user,   only: [:edit, :update]

  def show
  	@user = User.find(params[:id])
  end

  def matches
    @user = current_user
    other_user = User.near(@user).where.not(id: current_user.id).where(['gender = ? AND single_parent = ? OR new_parent = ? OR special_needs = ?
        OR children_under_5 = ? OR children_5_10 = ? OR tweens = ? OR teens = ? OR non_parent = ?',
        current_user.gender, current_user.single_parent, current_user.new_parent, current_user.special_needs,
        current_user.children_under_5, current_user.children_5_10, current_user.tweens, current_user.teens,
        current_user.non_parent])
    if other_user.empty? && User.near(@user).present?
      if current_user.subscriber == "Subscriber"
        @matched_users = User.near(@user).order("RANDOM()").first(5)
      end
      if current_user.subscriber == "PLUS"
        @matched_users = User.near(@user).order("RANDOM()").first(15)
      end
    else
      if current_user.subscriber == "Subscriber"
        @matched_users = other_user.order("RANDOM()").first(5)
      end
      if current_user.subscriber == "PLUS"
        @matched_users = other_user.order("RANDOM()").first(15)
      end
    end
  end

  def following
    @user = current_user
    @title = "Interest Following"
    @interests = @user.following
    @invite = Invite.new
    @message = current_user.sent_messages.build
    @messages = current_user.received_messages.paginate :per_page => 10, :page => params[:page], :include => :message, :order => "messages.created_at DESC"
    @sent_messages = current_user.sent_messages.paginate :per_page => 10, :page => params[:page], :order => "created_at DESC"
    render 'interest_following'
  end    
  
  def followers
    @title = "Interest Followers"
    @interest = Interest.find(params[:id])
    @interests = @interest.followers
    render 'show_follow'
  end

def group_following
    @user =  current_user
    @title = "Group Following"
    @groups = @user.group_following
    @invite = Invite.new
    @message = current_user.sent_messages.build
    @messages = current_user.received_messages.paginate :per_page => 10, :page => params[:page], :include => :message, :order => "messages.created_at DESC"
    @sent_messages = current_user.sent_messages.paginate :per_page => 10, :page => params[:page], :order => "created_at DESC"
    render 'group_following'
end    
  
  def group_followers
    @title = "Group Followers"
    @group = Group.find(params[:id])
    @groups = @groups.group_followers
    render 'show_group_follow'
  end

  def activity_following
    @user = current_user
    @title = "Activity Following"
    @activities = @user.activity_following
    @invite = Invite.new
    @message = current_user.sent_messages.build
    @messages = current_user.received_messages.paginate :per_page => 10, :page => params[:page], :include => :message, :order => "messages.created_at DESC"
    @sent_messages = current_user.sent_messages.paginate :per_page => 10, :page => params[:page], :order => "created_at DESC"
    render 'activity_following'
  end    
  
  def activity_followers
    @title = "Activity Followers"
    @activities = @user.activity_followers
    render 'show_activity_follow'
  end

  def place_following
    @user = current_user
    @title = "Place Following"
    @places = @user.place_following
    @invite = Invite.new
    @message = current_user.sent_messages.build
    @messages = current_user.received_messages.paginate :per_page => 10, :page => params[:page], :include => :message, :order => "messages.created_at DESC"
    @sent_messages = current_user.sent_messages.paginate :per_page => 10, :page => params[:page], :order => "created_at DESC"
    render 'place_following'
  end    
  
  def place_followers
    @title = "Place Followers"
    @places = @user.place_followers
    render 'show_place_follow'
  end

  def new
    @male_avatars = Avatar.all.where('gender IS ?', nil)
    @female_avatars = Avatar.all.where('gender IS NOT NULL')
  	@user = User.new
  end

  def create
    @male_avatars = Avatar.all.where('gender IS ?', nil)
    @female_avatars = Avatar.all.where('gender IS NOT NULL')
  	@user = User.new(user_params)
  	  if @user.save
        sign_in @user
        UserMailer.registration_confirmation(@user).deliver
  		  redirect_to(root_url)
  	  else 
  		  render 'new'
      end
  end

  def index
    @invite = Invite.new
    @user = current_user
    @users = User.search(params[:search])
    @message = current_user.sent_messages.build
    @messages = current_user.received_messages.paginate :per_page => 10, :page => params[:page], :include => :message, :order => "messages.created_at DESC"
    @sent_messages = current_user.sent_messages.paginate :per_page => 10, :page => params[:page], :order => "created_at DESC"
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      sign_in @user
      redirect_to(root_url)
    else
      render 'edit'
    end
  end

  private

  	def user_params
  		params.require(:user).permit(:name, :email, :address, :latitude, :longitude, :city, :state, 
        :password, :password_confirmation, :gender, :single_parent, :special_needs, :new_parent, :children_under_5,
        :children_5_10, :tweens, :teens, :non_parent, :uploader_image, :image_path, :subscriber, :last_name)
  	end

    # Before filters

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
