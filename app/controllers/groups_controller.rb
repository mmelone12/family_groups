class GroupsController < ApplicationController
  
  def show
  end

  def index
    RMeetup::Client.api_key = "2e2c342c1e7b93a141362e4427b7"
    @user = current_user
    new_groups = RMeetup::Client.fetch(:groups, :lat => @user.latitude, :lon => @user.longitude, :topic => "parents")
    current_group_ids = current_user.groups.pluck(:group_id)
    @groups = new_groups.reject { |group| current_group_ids.include?(group.id) }
    @other_groups = Group.where(['group_id IS ? AND user_id <> ? AND city = ?', nil, current_user.id, @user.city])
    @group = Group.create
    @invite = Invite.new
    @message = current_user.sent_messages.build
    @messages = current_user.received_messages.paginate :per_page => 10, :page => params[:page], :include => :message, :order => "messages.created_at DESC"
    @sent_messages = current_user.sent_messages.paginate :per_page => 10, :page => params[:page], :order => "created_at DESC"
  end

  def new
  	@group = Group.new
  end

  def create
  	@group = Group.new(group_params)
    @group.save
    current_user.group_follow!(@group)
  	respond_to do |format|
      format.html { redirect_to(root_url) }
      format.js 
    end
  end

  def edit
  end

  private

  	def group_params
  		params.require(:group).permit(:name, :link, :image_path, :city, :desc, :group_id, :user_id, :address, :uploader_image)
  	end

end