class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.string :name
      t.string :image_path
      t.string :desc

      t.timestamps
    end
  end
end
