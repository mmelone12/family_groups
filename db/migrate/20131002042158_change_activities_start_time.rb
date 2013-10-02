class ChangeActivitiesStartTime < ActiveRecord::Migration
  def up
  	change_table :activities do |t|
  		t.change :start_time, :string
  		t.change :end_time, :string
     end
  end

  def down
  	change_table :activities do |t|
  		t.change :start_time, :time
  		t.change :end_time, :time
  	end
  end
end
