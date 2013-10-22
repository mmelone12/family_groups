class AddParentAttributesToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :single_parent, :string
  	add_column :users, :new_parent, :string
  	add_column :users, :special_needs, :string
  	add_column :users, :childen_under_5, :string
  	add_column :users, :children_5_10, :string
  	add_column :users, :tweens, :string
  	add_column :users, :teens, :string
  end
end
