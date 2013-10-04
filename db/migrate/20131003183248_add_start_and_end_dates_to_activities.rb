class AddStartAndEndDatesToActivities < ActiveRecord::Migration
  def change
  	add_column :activities, :start_date, :date
    add_column :activities, :end_date, :date
  end
end
