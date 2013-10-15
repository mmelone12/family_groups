class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :group_following]
  before_action :correct_user,   only: [:edit, :update]

  def show
  	@user = User.find(params[:id])
  end

  def following
    @user = current_user
    @title = "Interest Following"
    @interests = @user.following
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
    render 'place_following'
  end    
  
  def place_followers
    @title = "Place Followers"
    @places = @user.place_followers
    render 'show_place_follow'
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	  if @user.save
        sign_in @user
  		  redirect_to(root_url)
  	  else 
  		  render 'new'
      end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  	def user_params
  		params.require(:user).permit(:name, :email, :address, :latitude, :longitude, :city, :state, :password, :password_confirmation, :gender)
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
