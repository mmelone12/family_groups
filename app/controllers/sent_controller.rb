class SentController < ApplicationController

  def index
    @messages = current_user.sent_messages.paginate :per_page => 10, :page => params[:page], :order => "created_at DESC"
  end

  def show
    @message = current_user.sent_messages.find(params[:id])
  end

  def new
    @messages = current_user.received_messages.paginate :per_page => 10, :page => params[:page], :include => :message, :order => "messages.created_at DESC"
    @message = current_user.sent_messages.build
  end
  
  def create
    @message = current_user.sent_messages.build(message_params) 
    recipient = @message.to.first.to_i
    @recipient = User.find(recipient)
    UserMailer.you_got_mail(@recipient).deliver 
    if @message.save
      respond_to do |format|
        format.js 
        format.html { redirect_to(root_url) }
      end
    else
      redirect_to(root_url)
    end
  end

  def message_params
  	params.require(:message).permit(:subject, :body, :to => [])
  end
end