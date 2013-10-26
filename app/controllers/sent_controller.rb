class SentController < ApplicationController

  def index
    @messages = current_user.sent_messages.paginate :per_page => 10, :page => params[:page], :order => "created_at DESC"
  end

  def show
    @message = current_user.sent_messages.find(params[:id])
  end

  def new
    @folder = current_user.inbox
    @messages = @folder.messages.paginate :per_page => 10, :page => params[:page], :include => :message, :order => "messages.created_at DESC"
    @message = current_user.sent_messages.build
  end
  
  def create
    @message = current_user.sent_messages.build(message_params)
    
    if @message.save
      flash[:notice] = "Message sent."
      redirect_to :action => "index"
    else
      render :action => "new"
    end
  end

  def message_params
  	params.require(:message).permit(:subject, :body, :to => [])
  end
end