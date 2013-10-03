desc "Fetch activities"
task :fetch_activities => :environment do
  require 'mechanize'

      User.all.each do |user|
            city_name = user.city
            city_format = city_name.downcase.split.join('-')
            state_name = user.state.downcase
            agent = Mechanize.new
            page = agent.get("http://www.scout.me/family-and-kids-events--near--#{city_format}-#{state_name}")
            agent.page.search(".content").each do |group|
                  image_path = group.search("img").to_s
                  group_link = group.search("a").first.to_s[/(http[^"]+\w)/]
                  page = agent.get("#{group_link}")
                  title = agent.page.search(".facet-title").text.strip
                  where = agent.page.search(".venue").text.strip
                  start_date = agent.page.search(".value-title").text.strip
                  start_time = agent.page.search(".time").text.strip
                  desc = agent.page.search(".facet_description").text.strip.truncate(200)
                  address = agent.page.search(".address").text.strip
                  phone = agent.page.search(".facet_phone").text.strip
                  link = agent.page.search(".facet_url").text.strip
                  if agent.page.link_with(:class => "facet_url").present?
                  article_link = agent.page.link_with(:class => "facet_url").uri.to_s
                  end
                  website = agent.page.search(".url span").text.strip
                  if agent.page.link_with(:class => "facet_url url").present?
                  website_link = agent.page.link_with(:class => "facet_url url").uri.to_s
                  end
                  Activity.create!(:title => title, :where => where, :start_date => start_date,
                  :start_time => start_time, :desc => desc, :address => address, :phone => phone,
                  :link => link, :website => website, :article_link => article_link, :website_link => 
                  website_link, :image_path => image_path)
                  puts title, where, start_date, start_time, desc, address, phone, link, website
            end
      end
end