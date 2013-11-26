class AddAuthorAndImageToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :author_name, :string
  	add_column :posts, :author_image, :string
  end
end
