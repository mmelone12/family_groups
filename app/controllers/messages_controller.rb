class MessagesController < ApplicationController
  def show
    respond_to do |format|
      format.html
      format.js
    @message = Message.find(params[:id])
    @message.reading_message 
    end
  end
end
