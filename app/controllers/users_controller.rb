class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def show
  	@user = User.find(params[:id])
  end

  def following
    @title = "Following"
    @interest = Interest.find(params[:id])
    @interests = @interest.following
    render 'show_follow'
  end    
  
  def followers
    @title = "Followers"
    @interest = Interest.find(params[:id])
    @interests = @interest.followers
    render 'show_follow'
  end

def group_following
    @title = "Group Following"
    @group = Group.find(params[:id])
    @groups = @group.group_following
    render 'show_group_follow'
  end    
  
  def group_followers
    @title = "Group Followers"
    @group = Group.find(params[:id])
    @groups = @groups.group_followers
    render 'show_group_follow'
  end

  def activity_following
    @title = "Activity Following"
    @activity = Activity.find(params[:id])
    @activities = @activity.activity_following
    render 'show_activity_follow'
  end    
  
  def activity_followers
    @title = "Activity Followers"
    @activity = Activity.find(params[:id])
    @groups = @activities.activity_followers
    render 'show_activity_follow'
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
  		params.require(:user).permit(:name, :email, :address, :latitude, :longitude, :city, :state, :password, :password_confirmation)
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
