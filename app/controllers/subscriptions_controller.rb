class SubscriptionsController < ApplicationController
  def new
    plan = Plan.find(params[:plan_id])
    @subscription = plan.subscriptions.build
    @user = current_user
    @places = Place.near(@user)
    @other_places = Place.where(['user_id <> ? AND city = ?', current_user.id, @user.city])
    @invite = Invite.new
    @message = current_user.sent_messages.build
    @messages = current_user.received_messages.paginate :per_page => 10, :page => params[:page], :include => :message, :order => "messages.created_at DESC"
    @sent_messages = current_user.sent_messages.paginate :per_page => 10, :page => params[:page], :order => "created_at DESC"
  end

  def create
  	@user = current_user
    @subscription = Subscription.new(subscription_params)
    if @subscription.save_with_payment 
    	if @subscription.plan_id == 1
      		@user.update_attribute(:subscriber, "Subscriber")
      	end
      	if @subscription.plan_id == 2
      		@user.update_attribute(:subscriber, "PLUS")
      	end
      redirect_to root_url, :notice => "Thank you for subscribing!"
    else
      redirect_to new_subscription_path
    end
  end

  def show
    @subscription = Subscription.find(params[:id])
  end

    private

  	def subscription_params
  		params.require(:subscription).permit(:user_id, :plan_id, :stripe_card_token, :card_number, :card_code,
  			:card_month, :email)
  	end
end
