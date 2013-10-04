class CreateActivityRelationships < ActiveRecord::Migration
  def change
    create_table :activity_relationships do |t|
      t.integer :activity_follower_id
      t.integer :activity_followed_id

      t.timestamps
    end
  end
end
