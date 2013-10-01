class AddUploaderImageToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :uploader_image, :string
  end
end
