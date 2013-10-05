desc "Fetch places"
task :fetch_places => :environment do
  require 'mechanize'
  require 'uri'
  require 'net/http'

      User.all.uniq_by(&:city).each do |user|
            city_name = user.city
            city_format = city_name.downcase.split.join('-')
            state_name = user.state.downcase
            agent = Mechanize.new
            page = agent.get("http://www.scout.me/parks--near--#{city_format}-#{state_name}")
            agent.page.search(".content").each do |place|
                  image_path = place.search("img").to_s[/(http[^"]+\w)/]
                  place_link = place.search("a").first.to_s[/(http[^"]+\w)/]
                  url = URI.parse(place_link)
                  req = Net::HTTP.new(url.host, url.port)
                  res = req.request_head(url.path)
                  if res.code == "200"
                  page = agent.get("#{place_link}")
                  name = agent.page.search(".facet-title").text.strip
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
                  website = agent.page.search(".url span").text.strip
                  if agent.page.link_with(:class => "facet_url url").present?
                  link = agent.page.link_with(:class => "facet_url url").uri.to_s
                  end
                  if name.present?

                  url = URI.parse(URI.encode(image_path))

                  Net::HTTP.start(url.host, url.port) do |http|
                        response = http.head(url.path)
                        case response
                        when Net::HTTPSuccess, Net::HTTPRedirection
                              case response.content_type
                              when "image/png", "image/gif", "image/jpeg"
                                    image_confirmed = place.search("img").to_s[/(http[^"]+\w)/]
                              else
                                    image_confirmed = "imgs/events/carnivalresized.png"
                              end
                        else
                              image_confirmed = "imgs/events/carnivalresized.png"
                        end
                        
                  Place.where(:name => name, :desc => desc, :address => address, :phone => phone,
                  :link => link, :website => website, :image_path => image_confirmed).first_or_create
                  puts name, desc, address, phone, link, website
                  end
                  end
               end   
            end

            page = agent.get("http://www.scout.me/childrens-museums--near--#{city_format}-#{state_name}")
            agent.page.search(".content").each do |place|
                  image_path = place.search("img").to_s[/(http[^"]+\w)/]
                  place_link = place.search("a").first.to_s[/(http[^"]+\w)/]
                  url = URI.parse(place_link)
                  req = Net::HTTP.new(url.host, url.port)
                  res = req.request_head(url.path)
                  if res.code == "200"
                  page = agent.get("#{place_link}")
                  name = agent.page.search(".facet-title").text.strip
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
                  website = agent.page.search(".url span").text.strip
                  if agent.page.link_with(:class => "facet_url url").present?
                  link = agent.page.link_with(:class => "facet_url url").uri.to_s
                  end
                  if name.present?

                  url = URI.parse(URI.encode(image_path))

                  Net::HTTP.start(url.host, url.port) do |http|
                        response = http.head(url.path)
                        case response
                        when Net::HTTPSuccess, Net::HTTPRedirection
                              case response.content_type
                              when "image/png", "image/gif", "image/jpeg"
                                    image_confirmed = place.search("img").to_s[/(http[^"]+\w)/]
                              else
                                    image_confirmed = "imgs/events/carnivalresized.png"
                              end
                        else
                              image_confirmed = "imgs/events/carnivalresized.png"
                        end
                        
                  Place.where(:name => name, :desc => desc, :address => address, :phone => phone,
                  :link => link, :website => website, :image_path => image_confirmed).first_or_create
                  puts name, desc, address, phone, link, website
                  end
                  end
               end   
            end

            page = agent.get("http://www.scout.me/zoos-and-aquariums--near--#{city_format}-#{state_name}")
            agent.page.search(".content").each do |place|
                  image_path = place.search("img").to_s[/(http[^"]+\w)/]
                  place_link = place.search("a").first.to_s[/(http[^"]+\w)/]
                  url = URI.parse(place_link)
                  req = Net::HTTP.new(url.host, url.port)
                  res = req.request_head(url.path)
                  if res.code == "200"
                  page = agent.get("#{place_link}")
                  name = agent.page.search(".facet-title").text.strip
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
                  website = agent.page.search(".url span").text.strip
                  if agent.page.link_with(:class => "facet_url url").present?
                  link = agent.page.link_with(:class => "facet_url url").uri.to_s
                  end
                  if name.present?

                  url = URI.parse(URI.encode(image_path))

                  Net::HTTP.start(url.host, url.port) do |http|
                        response = http.head(url.path)
                        case response
                        when Net::HTTPSuccess, Net::HTTPRedirection
                              case response.content_type
                              when "image/png", "image/gif", "image/jpeg"
                                    image_confirmed = place.search("img").to_s[/(http[^"]+\w)/]
                              else
                                    image_confirmed = "imgs/events/carnivalresized.png"
                              end
                        else
                              image_confirmed = "imgs/events/carnivalresized.png"
                        end
                        
                  Place.where(:name => name, :desc => desc, :address => address, :phone => phone,
                  :link => link, :website => website, :image_path => image_confirmed).first_or_create
                  puts name, desc, address, phone, link, website
                  end
                  end
               end   
            end
      end
end