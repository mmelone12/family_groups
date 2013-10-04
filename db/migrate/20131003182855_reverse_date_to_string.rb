class ReverseDateToString < ActiveRecord::Migration
  def change
  	remove_column :activities, :start_date, :string
    remove_column :activities, :end_date, :string
  end
end