class AddTimeReadAtToMessages < ActiveRecord::Migration
  def change
  	add_column :messages, :read_at, :time
  end
end
