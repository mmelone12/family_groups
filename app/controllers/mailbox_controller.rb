class MailboxController < ApplicationController

  def index
  	@message = current_user.sent_messages.build
    @messages = current_user.received_messages.paginate :per_page => 10, :page => params[:page], :include => :message, :order => "messages.created_at DESC"
    @sent_messages = current_user.sent_messages.paginate :per_page => 10, :page => params[:page], :order => "created_at DESC"
  end
end
