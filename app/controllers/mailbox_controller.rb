class MailboxController < ApplicationController

  def index
    @folder = current_user.inbox
    show
    render :action => "show"
  end

  def show
    @folder = current_user.inbox
    @messages = @folder.messages.paginate :per_page => 10, :page => params[:page], :include => :message, :order => "messages.created_at DESC"
  end
end
