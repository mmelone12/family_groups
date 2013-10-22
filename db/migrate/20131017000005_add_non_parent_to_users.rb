class AddNonParentToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :non_parent, :string
  end
end
