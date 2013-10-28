class Friendship1 < ActiveRecord::Migration
  def change
  	create_table :friendships1 do |t|
      t.integer :user_id
      t.integer :friend1_id

      t.timestamps
    end
  end
end
