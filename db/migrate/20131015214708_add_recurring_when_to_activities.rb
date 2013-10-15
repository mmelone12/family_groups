class AddRecurringWhenToActivities < ActiveRecord::Migration
  def change
  	add_column :activities, :recurring, :string
  	add_column :activities, :when, :string
  end
end
