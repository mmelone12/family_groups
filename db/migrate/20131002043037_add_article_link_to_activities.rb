class AddArticleLinkToActivities < ActiveRecord::Migration
  def change
  	add_column :activities, :article_link, :string
  	add_column :activities, :website_link, :string
  end
end
