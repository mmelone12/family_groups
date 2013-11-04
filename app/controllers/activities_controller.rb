class ActivitiesController < ApplicationController
  
  def show
  	@activity = Activity.find(params[:id])
  end

  def index
    @user = current_user
    new_activities = Activity.where('start_date >= ? AND user_id <> ?', 1.days.ago(Time.now).to_date, current_user.id )
    @activities = new_activities.near(@user).all( :order => "start_date", :limit => 30)
    recurring_activities = Activity.where(['recurring = ?', "yes"]).near(@user).first(5)
    @recurring_activities = recurring_activities.reject { |activity| current_activity_ids.include?(activity.id) }
    @invite = Invite.new
    @message = current_user.sent_messages.build
    @messages = current_user.received_messages.paginate :per_page => 10, :page => params[:page], :include => :message, :order => "messages.created_at DESC"
    @sent_messages = current_user.sent_messages.paginate :per_page => 10, :page => params[:page], :order => "created_at DESC"
  end

  def new
  	@activity = Activity.new
  end

  def create
  	@activity = Activity.new(activity_params)
    @activity.save
    current_user.activity_follow!(@activity)
  	respond_to do |format|
      format.html { redirect_to(root_url) }
      format.js 
    end
  end

  def edit
  end

  private

  	def activity_params
  		params.require(:activity).permit(:user_id, :title, :image_path, :address, :city, :uploader_image,
  			:end_date, :start_date, :start_time, :end_time, :where, :desc, :link, :email, :article_link, :website, :website_link)
  	end
end