class AddDetailsToActivities < ActiveRecord::Migration
  def change
  	add_column :activities, :where, :string
  	add_column :activities, :address, :string
  	add_column :activities, :start_time, :time
  	add_column :activities, :end_time, :time
  	add_column :activities, :link, :string
  	add_column :activities, :phone, :string
  	add_column :activities, :email, :string
  	add_column :activities, :website, :string
  end
end
