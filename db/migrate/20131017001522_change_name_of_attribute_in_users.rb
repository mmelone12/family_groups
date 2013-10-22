class ChangeNameOfAttributeInUsers < ActiveRecord::Migration
  def change
  	rename_column :users, :childen_under_5, :children_under_5
  end
end
