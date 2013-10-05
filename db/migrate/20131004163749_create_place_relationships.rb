class CreatePlaceRelationships < ActiveRecord::Migration
  def change
    create_table :place_relationships do |t|
      t.integer :place_follower_id
      t.integer :place_followed_id

      t.timestamps
    end
  end
end
