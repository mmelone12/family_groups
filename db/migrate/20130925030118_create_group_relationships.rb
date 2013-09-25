class CreateGroupRelationships < ActiveRecord::Migration
  def change
    create_table :group_relationships do |t|
      t.integer :group_follower_id
      t.integer :group_followed_id

      t.timestamps
    end
  end
end
