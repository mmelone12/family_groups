desc "Fetch prices"
task :fetch_prices => :environment do
	require 'mechanize'

	Product.find_all_by_price(nil).each do |product|
    url = "http://www.walmart.com/search/search-ng.do?search_constraint=0&ic=48_0&search_query=#{CGI.escape(product.name)}&Find.x=0&Find.y=0&Find=Find"
    doc = Nokogiri::HTML(open(url))
    price = doc.at_css(".PriceCompare .BodyS, .PriceXLBold").text[/[0-9\.]+/]
    product.update_attribute(:price, price)
  end
end

desc "Import wish list"
task :import_list => :environment do
  require 'mechanize'
  agent = WWW::Mechanize.new
  
  agent.get("http://railscasts.tadalist.com/session/new")
  form = agent.page.forms.first
  form.password = "secret"
  form.submit
  
  agent.page.link_with(:text => "Wish List").click
  agent.page.search(".edit_item").each do |item|
    Product.create!(:name => item.text.strip)
  end
end

      agent = Mechanize.new
      agent.get("http://www.scout.me")
      activity_field = field_with(:text => "0x3ffb8761881c") do |f|
      	f.value => "Family Events"
      end
      location_field = field_with(:text => "0x3ffb87618498") do |f|
      	f.value => "Los Angeles, CA"
      	form.submit


      form = page.form_with(:name => 'searchbox') do |search|
      	search.field_with(:text => 0x3ffb8761881c = "Family Events"
      	search.0x3ffb87618498 = "Orlando, FL"
      form.submit

      @activity_title = agent.page.search(".summary")

      page = agent.get("http://www.scout.me")
      search_form = page.form(:name => 'searchbox')
      search_form.field_with(:text => '0x3ffb8761881c') = "Family Events"
      search_form.field_with(:text => '0x3ffb87618498') = "Los Angeles, CA"
      page = agent.submit(search_form)


      desc "Fetch activities1"
      task :fetch_activities1 => :environment do
        require 'mechanize'

        User.all.each do |user|
          city_name = user.city
          city_format = city_name.downcase.split.join('-')
          state_name = user.state.downcase
          agent = Mechanize.new
          agent.get("http://www.scout.me/family-and-kids-events--near--#{city_format}-#{state_name}")
          agent.page.search(".title").each do |item|
            item.click
            agent.page.search(".fn").text.strip = title
            agent.page.search(".venue").text.strip = where
            agent.page.search(".value-title").text.strip = start_date
            agent.page.search(".time").text.strip = start_time
            agent.page.search(".facet_description").text.strip = desc
            agent.page.search(".address").text.strip = address
            agent.page.search(".facet_phone").text.strip = phone
            agent.page.search("#descriptions-widget span") = link
            agent.page.search(".url span") = website
            Activity.create!(:title => title, :where => where, :start_date => start_date,
              :start_time => start_time, :desc => desc, :address => address, :phone => phone,
              :link = link, :website => website)
          end
        end
      end

      desc "Fetch activities1"
      task :fetch_activities1 => :environment do
        require 'nokogiri'
        require 'open-uri'

            User.all.each do |user|
          city_name = user.city
          city_format = city_name.downcase.split.join('-')
          state_name = user.state.downcase
          url = "http://www.scout.me/family-and-kids-events--near--#{city_format}-#{state_name}"
          doc = Nokogiri::HTML(open(url))
          doc.css('.title').each do |item|
                        activity_name = item.text.strip
                        Activity.create!(:title => activity_name)
          end
        end
      end


          agent = Mechanize.new
          page = agent.get("http://redtri.com/events/san-francisco/")
          agent.page.links_with(:class => "url summary").each do |item|
            item.click
            agent.page.search(".fn").text.strip = title
            agent.page.search(".venue").text.strip = where
            agent.page.search(".value-title").text.strip = start_date
            agent.page.search(".time").text.strip = start_time
            agent.page.search(".facet_description").text.strip = desc
            agent.page.search(".address").text.strip = address
            agent.page.search(".facet_phone").text.strip = phone
            agent.page.search(".facet_url").text.strip = link
            agent.page.search(".url span").text.strip = website
            Activity.create!(:title => title, :where => where, :start_date => start_date,
              :start_time => start_time, :desc => desc, :address => address, :phone => phone,
              :link => link, :website => website)
            puts title, where, start_date, start_time, desc, address, phone, link, website
          end
        end
      end

                agent.page.search(".content").each do |group|
            image_path = group.search("#entries img").text.strip
          end

          new_image = page.search(".content").first.search("img")

          my_link.first.to_s[/<a[^>]+href="([^"]+)"[^>]*>/]
          <a [^>]+*>
          good for getting second character: http[^>]+"([^"]+)">
          http[^>]+*>
          same here
          http[^>]*1\w
          http[^>]+7\w gets all of first link
          http[^"]+\w
          http[^"]+\g

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


            agent = Mechanize.new
            page = agent.get("http://redtri.com/events/san-francisco/")
            agent.page.search(".event").each do |activity|
                title = agent.page.search(".h2 a").text.strip
                cost = agent.page.search(".event-content").text.strip
                  if cost = "Free"
                    formatted_cost = "This is a free event."
                  else
                    formatted_cost = "See the link for details on costs."
                  end
                
                  activity_link = activity.search("a").first.to_s[/(http[^"]+\w)/]
                  url = URI.parse(group_link)
                  req = Net::HTTP.new(url.host, url.port)
                  res = req.request_head(url.path)
                  if res.code == "200"
                  page = agent.get("#{activity_link}")
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
