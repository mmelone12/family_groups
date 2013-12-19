SitemapGenerator::Sitemap.default_host = 'http://www.familygroups.org'
SitemapGenerator::Sitemap.create do
  add '/howitworks', :changefreq => 'weekly'
  add '/blog', :changefreq => 'daily'   
  add '/posts/1', :changefreq => 'weekly'
  add '/posts/3', :changefreq => 'weekly'
  add '/posts/4', :changefreq => 'weekly'
  add '/posts/5', :changefreq => 'weekly'
  add '/posts/6', :changefreq => 'weekly'
  Activity.all.uniq.find_each do |activity|
    add activity_path(activity), :lastmod => activity.updated_at
  end   
  Place.all.uniq.find_each do |place|
    add place_path(place), :lastmod => place.updated_at
  end
  Interest.where(:id => 1 .. 47).all.each do |interest|
    add interest_path(interest), :lastmod => interest.updated_at
  end
  Group.all.uniq.first(10).each do |group|
    add group_path(group), :lastmod => group.updated_at
  end
end             

# Set the host name for URL creation
#SitemapGenerator::Sitemap.default_host = "http://www.example.com"

#SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
#end
