class DropFoldersTable < ActiveRecord::Migration
  def change
  	drop_table :folders
  end
end
