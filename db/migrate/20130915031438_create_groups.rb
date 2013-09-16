class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :image_path
      t.string :desc
      t.string :link
      t.string :city

      t.timestamps
    end
  end
end
