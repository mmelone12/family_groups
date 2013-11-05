class AddSubscriberToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :subscriber, :string
  end
end
