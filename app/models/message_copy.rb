class MessageCopy < ActiveRecord::Base
  belongs_to :message
  belongs_to :recipient, :class_name => "User"
  delegate   :author, :created_at, :subject, :body, :recipients, :read_at, :to => :message

  def reading_message
    self.read_at ||= Time.now
    save
  end
end
