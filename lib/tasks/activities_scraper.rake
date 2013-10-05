desc "Fetch activities"
task :fetch_activities => :environment do
  require 'mechanize'
  require 'uri'
  require 'net/http'

      User.all.uniq_by(&:city).each do |user|
            city_name = user.city
            city_format = city_name.downcase.split.join('-')
            state_name = user.state.downcase
            agent = Mechanize.new
            page = agent.get("http://www.scout.me/family-and-kids-events--near--#{city_format}-#{state_name}")
            agent.page.search(".content").each do |group|
                  image_path = group.search("img").to_s[/(http[^"]+\w)/]
                  group_link = group.search("a").first.to_s[/(http[^"]+\w)/]
                  url = URI.parse(group_link)
                  req = Net::HTTP.new(url.host, url.port)
                  res = req.request_head(url.path)
                  if res.code == "200"
                  page = agent.get("#{group_link}")
                  title = agent.page.search(".facet-title").text.strip
                  where = agent.page.search(".venue").text.strip
                  start_date = agent.page.search(".value-title").to_s[/(2013[^T]+\d)/]
                  start_time = agent.page.search(".time").text.strip
                  desc = agent.page.search(".facet_description").text.strip.truncate(200)
                  street_address = agent.page.search(".address").text.strip[/([^,]+\w)/]
                  locality = agent.page.search(".locality").text.strip
                  state_address = agent.page.search(".state").text.strip
                  if state_address.present?
                  address = street_address + ", " + locality + ", " + state_address
                  else
                        if locality.present?
                              address = street_address + ", " + locality
                        else
                              address = street_address
                        end

                  end
                  phone = agent.page.search(".facet_phone").text.strip
                  link = agent.page.search(".facet_url").text.strip
                  if agent.page.link_with(:class => "facet_url").present?
                  article_link = agent.page.link_with(:class => "facet_url").uri.to_s
                  end
                  website = agent.page.search(".url span").text.strip
                  if agent.page.link_with(:class => "facet_url url").present?
                  website_link = agent.page.link_with(:class => "facet_url url").uri.to_s
                  end
                  if title.present? && start_date.present?

                  url = URI.parse(URI.encode(image_path))

                  Net::HTTP.start(url.host, url.port) do |http|
                        response = http.head(url.path)
                        case response
                        when Net::HTTPSuccess, Net::HTTPRedirection
                              case response.content_type
                              when "image/png", "image/gif", "image/jpeg"
                                    image_confirmed = group.search("img").to_s[/(http[^"]+\w)/]
                              else
                                    image_confirmed = "imgs/events/carnivalresized.png"
                              end
                        else
                              image_confirmed = "imgs/events/carnivalresized.png"
                        end
                        
                  Activity.where(:title => title, :where => where, :start_date => start_date,
                  :start_time => start_time, :desc => desc, :address => address, :phone => phone,
                  :link => link, :website => website, :article_link => article_link, :website_link => 
                  website_link, :image_path => image_confirmed).first_or_create
                  puts title, where, start_date, start_time, desc, address, phone, link, website
                  end
                end
             end   
         end
      end
end