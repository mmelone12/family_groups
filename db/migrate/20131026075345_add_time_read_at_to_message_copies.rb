class AddTimeReadAtToMessageCopies < ActiveRecord::Migration
  def change
  	add_column :message_copies, :read_at, :time
  end
end
