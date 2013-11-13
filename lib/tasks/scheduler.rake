desc "Fetch prices"
task :fetch_redtri => :environment do
  require 'mechanize'
  
            agent = Mechanize.new
            pages = [ "http://redtri.com/events/san-francisco/", "http://redtri.com/events/los-angeles/", "http://redtri.com/events/atlanta/", "http://redtri.com/events/chicago/", "http://redtri.com/events/new-york/", "http://redtri.com/events/portland/", "http://redtri.com/events/seattle/", "http://redtri.com/events/socal/", "http://redtri.com/events/dc/" ]
            pages.each do |enter|
              page = agent.get(enter)
              agent.page.search(".event").each do |activity|
                article_link = activity.search("a").first.to_s[/(http[^"]+\w)/]
                title = activity.search("h2 a").text.strip
                cost_test = activity.search("span")[5]
                if cost_test != nil
                  cost = cost_test.text.strip
                end
                if cost = "Free" || "FREE"
                  formatted_cost = "This is a free event."
                else
                  formatted_cost = "See the link for full details on costs" + cost
                end
                ages_test = activity.search("span")[7]
                if ages_test != nil
                  ages = ages_test.text.strip
                else
                  ages = "all ages"
                end
                formatted_ages = "This event is open to" + " " + ages.downcase
                address = activity.search("span")[3].text.strip
                user_id = "1"
                total_date = activity.search("span")[1].text.strip
                if total_date.include? "every" or total_date.include? "Every"
                  recurring = "yes"
                  start_date = "1/1/2010"
                else
                  recurring = "no"
                  start_date = Date.parse(total_date)
                end
                desc = "Where:" + " " + address + ". " + formatted_cost + " " + formatted_ages + "."
                go_deeper = agent.get(article_link)
                article_link = go_deeper.search(".more-info a").first.to_s[/(http[^"]+\w)/]
                image_path = "activities/general.jpg"
                if title.include? "child" or title.include? "Child" or title.include? "kid" or title.include? "Kid"
                  image_path = "activities/child.jpg"
                end
                if title.include? "beach" or title.include? "Beach" or address.include? "beach" or address.include? "Beach"
                  image_path = "activities/beach.jpg"
                end
                if title.include? "YMCA"
                  image_path = "activities/pool.jpg"
                end
                if address.include? "pool" or address.include? "Pool" or address.include? "lake" or address.include? "Lake"
                  image_path = "places/water.jpg"
                end
                if address.include? "playground" or title.include? "Playground"
                  image_path = "activities/swings.jpg"
                end
                if address.include? "museum" or title.include? "Museum"
                  image_path = "interests/museum.jpg"
                end
                if title.include? "party" or title.include? "Party" or title.include? "celebration" or title.include? "Celebration" or title.include? "parade" or title.include? "Parade"
                  image_path = "activities/confetti.jpg"
                end
                if title.include? "show" or title.include? "Show" or title.include? "performance" or title.include? "Performance" or address.include? "show" or address.include? "Show" or address.include? "performance" or address.include? "Performance" or address.include? "movie" or address.include? "Movie" or address.include? "cinema" or address.include? "Cinema" or title.include? "Shakespeare"
                  image_path = "activities/playhouse.jpg"
                end
                if title.include? "theater" or title.include? "Theater" or title.include? "theatre" or title.include? "Theatre" or 
                  address.include? "theater" or address.include? "Theater" or address.include? "theatre" or address.include? "Theatre"
                  image_path = "activities/theater_seats.jpg"
                end
                if title.include? "school" or title.include? "School" or title.include? "book" or title.include? "Book" or title.include? "education" or title.include? "Education" or title.include? "teacher" or title.include? "Teacher"
                  image_path = "activities/school_books.jpg"
                end
                if title.include? "space" or title.include? "Space" or title.include? "stars" or title.include? "Stars"
                  image_path = "activities/space.jpg"
                end
                if address.include? "library" or address.include? "Library"
                  image_path = "activities/book_shelf.jpg"
                end
                if address.include? "art" or address.include? "Art" or title.include? "art" or title.include? "Art"
                  image_path = "activities/art.jpg"
                end
                if title.include? "swim" or title.include? "Swim"
                  iamge_path = "activities/swim.jpg"
                end
                if address.include? "aquarium" or address.include? "Aquarium"
                  image_path = "places/aquarium.jpg"
                end
                if address.include? "cafe" or address.include? "Cafe"
                  image_path = "places/cafe_general.jpg"
                end
                if address.include? "farm" or address.include? "Farm"
                  image_path = "places/chickens.jpg"
                end
                if address.include? "farmer" or address.include? "Farmer"
                  image_path = "places/fruit_berries.jpg"
                end
                if address.include? "petting" or address.include? "Petting"
                  image_path = "places/kid_goats.jpg"
                end
                if address.include? "park" or address.include? "Park"
                  image_path = "places/park.jpg"
                end
                if address.include? "natural history" or address.include? "Natural History" or title.include? "science" or title.include? "Science" or address.include? "science" or address.include? "Science"
                  image_path = "places/prehistoric.jpg"
                end
                if address.include? "sports" or address.include? "Sports" or address.include? "baseball" or address.include? "Baseball" or address.include? "stadium" or address.include? "Stadium"
                  image_path = "places/stadium_seats.jpg"
                end
                if address.include? "observatory" or address.include? "Observatory" or address.include? "planetarium" or address.include? "Planetarium"
                  image_path = "places/stars.jpg"
                end
                if title.include? "pumpkin" or title.include? "Pumpkin" or title.include? "haunt" or title.include? "Haunt" or title.include? "trick-or-treat" or title.include? "Trick-or-Treat" or title.include? "pumpkins" or title.include? "Pumpkins" or title.include? "scary" or title.include? "Scary" or title.include? "Spooky" or title.include? "spooky" or title.include? "trick or treat" or title.include? "Halloween" or title.include? "haunted" or title.include? "Haunt" or title.include? "harvest" or title.include? "Harvest" or title.include? "October"
                  image_path = "activities/pumpkin.jpg"
                end
                if title.include? "asian" or title.include? "Asian" or title.include? "chinese" or title.include? "Chinese" or title.include? "japanese" or title.include? "Japanese"
                  image_path = "activities/asian.jpg"
                end
                if title.include? "balloon" or title.include? "Balloon"
                  image_path = "activities/balloons.jpg"
                end
                if title.include? "baseball" or title.include? "Baseball"
                  image_path = "activities/baseball.jpg"
                end
                if title.include? "bike" or title.include? "Bike"
                  image_path = "activities/bike.jpg"
                end
                if title.include? "board game" or title.include? "Board Game"
                  image_path = "activities/board_game.jpg"
                end
                if title.include? "book" or title.include? "books" or title.include? "Book" or address.include? "Book" or address.include? "book"
                  image_path = "activities/book_shelf.jpg"
                end
                if title.include? "bowling" or title.include? "Bowling"
                  image_path = "activities/bowling.jpg"
                end
                if title.include? "camp" or title.include? "Camp"
                  image_path = "activities/campfire.jpg"
                end
                if title.include? "christmas" or title.include? "xmas" or title.include? "Christmas" or title.include? "Xmas"
                  image_path = "activities/christmas_tree.jpg"
                end
                if title.include? "concert" or title.include? "Concert" or title.include? "orchestra" or title.include? "Orchestra" or title.include? "symphony" or title.include? "Symphony" or address.include? "Symphony"
                  image_path = "activities/concert.jpg"
                end
                if title.include? "dance" or title.include? "ballet" or title.include? "Dance" or title.include? "Ballet"
                  image_path = "activities/dance.jpg"
                end
                if title.include? "animal" or title.include? "Animal" or title.include? "pets" or title.include? "Pets" or title.include? "dog" or title.include? "Dog" or title.include? "cat" or title.include? "Cat"
                  image_path = "activities/dog_cat.jpg"
                end
                if title.include? "food truck" or address.include? "food truck" or title.include? "Food Truck" or address.include? "Food Truck"
                  image_path = "activities/food_truck.jpg"
                end
                if title.include? "hot air" or title.include? "Hot Air"
                  image_path = "activities/hot_air_balloon.jpg"
                end
                if title.include? "magic" or title.include? "Magic"
                  image_path = "activities/magic.jpg"
                end
                if title.include? "magician" or title.include? "Magician"
                  image_path = "activities/magician.jpg"
                end
                if title.include? "music" or address.include? "music" or title.include? "Music" or address.include? "Music"
                  image_path = "activities/music.jpg"
                end
                if title.include? "air show" or title.include? "Air Show" or title.include? "plane" or title.include? "Plane" or title.include? "fighter jet" or title.include? "Blue Angels"
                  image_path = "activities/plane.jpg"
                end
                if address.include? "conservatory" or address.include? "Conservatory" or address.include? "arboretum" or address.include? "Arboretum" or address.include? "botanical" or address.include? "Botanical" or address.include? "garden" or address.include? "Garden"
                  image_path = "activities/plant.jpg"
                end
                if address.include? "playhouse" or address.include? "Playhouse" or title.include? "puppet" or title.include? "Puppet"
                  image_path = "activities/playhouse.jpg"
                end
                if address.include? "pumpkin patch" or address.include? "Pumpkin patch" or address.include? "Pumpkin Patch"
                  image_path = "activities/pumpkin_patch.jpg"
                end
                if title.include? "roses" or title.include? "Rose"
                  image_path = "activities/roses.jpg"
                end
                if title.include? "exercise" or title.include? "Exercise" or title.include? "jog" or title.include? "Jog" or title.include? "workout" or title.include? "Workout" or title.include? "marathon" or title.include? "Marathon"
                  image_path = "activities/running_shoes.jpg"
                end
                if title.include? "Santa"
                  image_path = "activities/santa_magic.jpg"
                end
                if title.include? "snow" or title.include? "Snow" or title.include? "winter" or title.include? "Winter" or title.include? "December"
                  image_path = "activities/snowman.jpg"
                end
                if title.include? "story" or title.include? "Story" or title.include? "once upon a time" or title.include? "Once upon a time" or title.include? "Once Upon A Time" or title.include? "reading" or title.include? "Reading" or title.include? "tale" or title.include? "Tale"
                  image_path = "activities/story.jpg"
                end
                if title.include? "movie" or title.include? "Movie" or title.include? "cinema" or title.include? "Cinema" or title.include? "screening" or title.include? "Screening"
                  image_path = "activities/theater_seats.jpg"
                end
                if address.include? "zoo" or address.include? "Zoo"
                  image_path = "activities/zoo.jpg"
                end

                if title.present?                       
                  Activity.where(:title => title, :start_date => start_date, :when => total_date, :desc => desc, :address => address, 
                    :article_link => article_link, :recurring => recurring, :image_path => image_path,
                  :user_id => user_id).first_or_create
                  puts title, total_date, desc, address
                end
             end  
       end
end

desc "Fetch prices"
task :fetch_redtri2 => :environment do
  require 'mechanize'
  
            agent = Mechanize.new
            pages = [ "http://redtri.com/events/san-francisco/page/2/", "http://redtri.com/events/los-angeles/page/2/", "http://redtri.com/events/atlanta/page/2/", "http://redtri.com/events/chicago/page/2/", "http://redtri.com/events/new-york/page/2", "http://redtri.com/events/portland/page/2", "http://redtri.com/events/seattle/page/2", "http://redtri.com/events/socal/page/2", "http://redtri.com/events/dc/page/2" ]
            pages.each do |enter|
              page = agent.get(enter)
              agent.page.search(".event").each do |activity|
                article_link = activity.search("a").first.to_s[/(http[^"]+\w)/]
                title = activity.search("h2 a").text.strip
                cost_test = activity.search("span")[5]
                if cost_test != nil
                  cost = cost_test.text.strip
                end
                if cost = "Free" || "FREE"
                  formatted_cost = "This is a free event."
                else
                  formatted_cost = "See the link for full details on costs" + cost
                end
                ages_test = activity.search("span")[7]
                if ages_test != nil
                  ages = ages_test.text.strip
                else
                  ages = "all ages"
                end
                formatted_ages = "This event is open to" + " " + ages.downcase
                address = activity.search("span")[3].text.strip
                user_id = "1"
                total_date = activity.search("span")[1].text.strip
                if total_date.include? "every" or total_date.include? "Every"
                  recurring = "yes"
                  start_date = "1/1/2010"
                else
                  recurring = "no"
                  start_date = Date.parse(total_date)
                end
                desc = "Where:" + " " + address + ". " + formatted_cost + " " + formatted_ages + "."
                go_deeper = agent.get(article_link)
                article_link = go_deeper.search(".more-info a").first.to_s[/(http[^"]+\w)/]
                image_path = "activities/general.jpg"
                if title.include? "child" or title.include? "Child" or title.include? "kid" or title.include? "Kid"
                  image_path = "activities/child.jpg"
                end
                if title.include? "beach" or title.include? "Beach" or address.include? "beach" or address.include? "Beach"
                  image_path = "activities/beach.jpg"
                end
                if title.include? "YMCA"
                  image_path = "activities/pool.jpg"
                end
                if address.include? "pool" or address.include? "Pool" or address.include? "lake" or address.include? "Lake"
                  image_path = "places/water.jpg"
                end
                if address.include? "playground" or title.include? "Playground"
                  image_path = "activities/swings.jpg"
                end
                if address.include? "museum" or title.include? "Museum"
                  image_path = "interests/museum.jpg"
                end
                if title.include? "party" or title.include? "Party" or title.include? "celebration" or title.include? "Celebration" or title.include? "parade" or title.include? "Parade"
                  image_path = "activities/confetti.jpg"
                end
                if title.include? "show" or title.include? "Show" or title.include? "performance" or title.include? "Performance" or address.include? "show" or address.include? "Show" or address.include? "performance" or address.include? "Performance" or address.include? "movie" or address.include? "Movie" or address.include? "cinema" or address.include? "Cinema" or title.include? "Shakespeare"
                  image_path = "activities/playhouse.jpg"
                end
                if title.include? "theater" or title.include? "Theater" or title.include? "theatre" or title.include? "Theatre" or 
                  address.include? "theater" or address.include? "Theater" or address.include? "theatre" or address.include? "Theatre"
                  image_path = "activities/theater_seats.jpg"
                end
                if title.include? "school" or title.include? "School" or title.include? "book" or title.include? "Book" or title.include? "education" or title.include? "Education" or title.include? "teacher" or title.include? "Teacher"
                  image_path = "activities/school_books.jpg"
                end
                if title.include? "space" or title.include? "Space" or title.include? "stars" or title.include? "Stars"
                  image_path = "activities/space.jpg"
                end
                if address.include? "library" or address.include? "Library"
                  image_path = "activities/book_shelf.jpg"
                end
                if address.include? "art" or address.include? "Art" or title.include? "art" or title.include? "Art"
                  image_path = "activities/art.jpg"
                end
                if title.include? "swim" or title.include? "Swim"
                  iamge_path = "activities/swim.jpg"
                end
                if address.include? "aquarium" or address.include? "Aquarium"
                  image_path = "places/aquarium.jpg"
                end
                if address.include? "cafe" or address.include? "Cafe"
                  image_path = "places/cafe_general.jpg"
                end
                if address.include? "farm" or address.include? "Farm"
                  image_path = "places/chickens.jpg"
                end
                if address.include? "farmer" or address.include? "Farmer"
                  image_path = "places/fruit_berries.jpg"
                end
                if address.include? "petting" or address.include? "Petting"
                  image_path = "places/kid_goats.jpg"
                end
                if address.include? "park" or address.include? "Park"
                  image_path = "places/park.jpg"
                end
                if address.include? "natural history" or address.include? "Natural History" or title.include? "science" or title.include? "Science" or address.include? "science" or address.include? "Science"
                  image_path = "places/prehistoric.jpg"
                end
                if address.include? "sports" or address.include? "Sports" or address.include? "baseball" or address.include? "Baseball" or address.include? "stadium" or address.include? "Stadium"
                  image_path = "places/stadium_seats.jpg"
                end
                if address.include? "observatory" or address.include? "Observatory" or address.include? "planetarium" or address.include? "Planetarium"
                  image_path = "places/stars.jpg"
                end
                if title.include? "pumpkin" or title.include? "Pumpkin" or title.include? "haunt" or title.include? "Haunt" or title.include? "trick-or-treat" or title.include? "Trick-or-Treat" or title.include? "pumpkins" or title.include? "Pumpkins" or title.include? "scary" or title.include? "Scary" or title.include? "Spooky" or title.include? "spooky" or title.include? "trick or treat" or title.include? "Halloween" or title.include? "haunted" or title.include? "Haunt" or title.include? "harvest" or title.include? "Harvest" or title.include? "October"
                  image_path = "activities/pumpkin.jpg"
                end
                if title.include? "asian" or title.include? "Asian" or title.include? "chinese" or title.include? "Chinese" or title.include? "japanese" or title.include? "Japanese"
                  image_path = "activities/asian.jpg"
                end
                if title.include? "balloon" or title.include? "Balloon"
                  image_path = "activities/balloons.jpg"
                end
                if title.include? "baseball" or title.include? "Baseball"
                  image_path = "activities/baseball.jpg"
                end
                if title.include? "bike" or title.include? "Bike"
                  image_path = "activities/bike.jpg"
                end
                if title.include? "board game" or title.include? "Board Game"
                  image_path = "activities/board_game.jpg"
                end
                if title.include? "book" or title.include? "books" or title.include? "Book" or address.include? "Book" or address.include? "book"
                  image_path = "activities/book_shelf.jpg"
                end
                if title.include? "bowling" or title.include? "Bowling"
                  image_path = "activities/bowling.jpg"
                end
                if title.include? "camp" or title.include? "Camp"
                  image_path = "activities/campfire.jpg"
                end
                if title.include? "christmas" or title.include? "xmas" or title.include? "Christmas" or title.include? "Xmas"
                  image_path = "activities/christmas_tree.jpg"
                end
                if title.include? "concert" or title.include? "Concert" or title.include? "orchestra" or title.include? "Orchestra" or title.include? "symphony" or title.include? "Symphony" or address.include? "Symphony"
                  image_path = "activities/concert.jpg"
                end
                if title.include? "dance" or title.include? "ballet" or title.include? "Dance" or title.include? "Ballet"
                  image_path = "activities/dance.jpg"
                end
                if title.include? "animal" or title.include? "Animal" or title.include? "pets" or title.include? "Pets" or title.include? "dog" or title.include? "Dog" or title.include? "cat" or title.include? "Cat"
                  image_path = "activities/dog_cat.jpg"
                end
                if title.include? "food truck" or address.include? "food truck" or title.include? "Food Truck" or address.include? "Food Truck"
                  image_path = "activities/food_truck.jpg"
                end
                if title.include? "hot air" or title.include? "Hot Air"
                  image_path = "activities/hot_air_balloon.jpg"
                end
                if title.include? "magic" or title.include? "Magic"
                  image_path = "activities/magic.jpg"
                end
                if title.include? "magician" or title.include? "Magician"
                  image_path = "activities/magician.jpg"
                end
                if title.include? "music" or address.include? "music" or title.include? "Music" or address.include? "Music"
                  image_path = "activities/music.jpg"
                end
                if title.include? "air show" or title.include? "Air Show" or title.include? "plane" or title.include? "Plane" or title.include? "fighter jet" or title.include? "Blue Angels"
                  image_path = "activities/plane.jpg"
                end
                if address.include? "conservatory" or address.include? "Conservatory" or address.include? "arboretum" or address.include? "Arboretum" or address.include? "botanical" or address.include? "Botanical" or address.include? "garden" or address.include? "Garden"
                  image_path = "activities/plant.jpg"
                end
                if address.include? "playhouse" or address.include? "Playhouse" or title.include? "puppet" or title.include? "Puppet"
                  image_path = "activities/playhouse.jpg"
                end
                if address.include? "pumpkin patch" or address.include? "Pumpkin patch" or address.include? "Pumpkin Patch"
                  image_path = "activities/pumpkin_patch.jpg"
                end
                if title.include? "roses" or title.include? "Rose"
                  image_path = "activities/roses.jpg"
                end
                if title.include? "exercise" or title.include? "Exercise" or title.include? "jog" or title.include? "Jog" or title.include? "workout" or title.include? "Workout" or title.include? "marathon" or title.include? "Marathon"
                  image_path = "activities/running_shoes.jpg"
                end
                if title.include? "Santa"
                  image_path = "activities/santa_magic.jpg"
                end
                if title.include? "snow" or title.include? "Snow" or title.include? "winter" or title.include? "Winter" or title.include? "December"
                  image_path = "activities/snowman.jpg"
                end
                if title.include? "story" or title.include? "Story" or title.include? "once upon a time" or title.include? "Once upon a time" or title.include? "Once Upon A Time" or title.include? "reading" or title.include? "Reading" or title.include? "tale" or title.include? "Tale"
                  image_path = "activities/story.jpg"
                end
                if title.include? "movie" or title.include? "Movie" or title.include? "cinema" or title.include? "Cinema" or title.include? "screening" or title.include? "Screening"
                  image_path = "activities/theater_seats.jpg"
                end
                if address.include? "zoo" or address.include? "Zoo"
                  image_path = "activities/zoo.jpg"
                end

                if title.present?                       
                  Activity.where(:title => title, :start_date => start_date, :when => total_date, :desc => desc, :address => address, 
                    :article_link => article_link, :recurring => recurring, :image_path => image_path,
                  :user_id => user_id).first_or_create
                  puts title, total_date, desc, address
                end
             end  
       end
end

desc "Fetch activities"
task :fetch_activities => :environment do
  require 'mechanize'
  require 'uri'
  require 'net/http'

      City.all.each do |city|
            city_name = city.name
            city_format = city_name.downcase.split.join('-')
            state_name = city.state.downcase
            agent = Mechanize.new
            pages = ["http://www.scout.me/family-and-kids-events--near--#{city_format}-#{state_name}", "http://www.scout.me/family--near--#{city_format}-#{state_name}" ]
            pages.each do |enter|
            page = agent.get(enter)
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
                  user_id = "1"
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
                                    image_path = group.search("img").to_s[/(http[^"]+\w)/]
                              else
                                    if title.include? "child" or title.include? "Child" or title.include? "kid" or title.include? "Kid"
                  image_path = "activities/child.jpg"
                end
                if title.include? "beach" or title.include? "Beach" or address.include? "beach" or address.include? "Beach"
                  image_path = "activities/beach.jpg"
                end
                if title.include? "YMCA"
                  image_path = "activities/pool.jpg"
                end
                if address.include? "pool" or address.include? "Pool" or address.include? "lake" or address.include? "Lake"
                  image_path = "places/water.jpg"
                end
                if address.include? "playground" or title.include? "Playground"
                  image_path = "activities/swings.jpg"
                end
                if address.include? "museum" or title.include? "Museum"
                  image_path = "interests/museum.jpg"
                end
                if title.include? "party" or title.include? "Party" or title.include? "celebration" or title.include? "Celebration" or title.include? "parade" or title.include? "Parade"
                  image_path = "activities/confetti.jpg"
                end
                if title.include? "show" or title.include? "Show" or title.include? "performance" or title.include? "Performance" or address.include? "show" or address.include? "Show" or address.include? "performance" or address.include? "Performance" or address.include? "movie" or address.include? "Movie" or address.include? "cinema" or address.include? "Cinema" or title.include? "Shakespeare"
                  image_path = "activities/playhouse.jpg"
                end
                if title.include? "theater" or title.include? "Theater" or title.include? "theatre" or title.include? "Theatre" or 
                  address.include? "theater" or address.include? "Theater" or address.include? "theatre" or address.include? "Theatre"
                  image_path = "activities/theater_seats.jpg"
                end
                if title.include? "school" or title.include? "School" or title.include? "book" or title.include? "Book" or title.include? "education" or title.include? "Education" or title.include? "teacher" or title.include? "Teacher"
                  image_path = "activities/school_books.jpg"
                end
                if title.include? "space" or title.include? "Space" or title.include? "stars" or title.include? "Stars"
                  image_path = "activities/space.jpg"
                end
                if address.include? "library" or address.include? "Library"
                  image_path = "activities/book_shelf.jpg"
                end
                if address.include? "art" or address.include? "Art" or title.include? "art" or title.include? "Art"
                  image_path = "activities/art.jpg"
                end
                if title.include? "swim" or title.include? "Swim"
                  iamge_path = "activities/swim.jpg"
                end
                if address.include? "aquarium" or address.include? "Aquarium"
                  image_path = "places/aquarium.jpg"
                end
                if address.include? "cafe" or address.include? "Cafe"
                  image_path = "places/cafe_general.jpg"
                end
                if address.include? "farm" or address.include? "Farm"
                  image_path = "places/chickens.jpg"
                end
                if address.include? "farmer" or address.include? "Farmer"
                  image_path = "places/fruit_berries.jpg"
                end
                if address.include? "petting" or address.include? "Petting"
                  image_path = "places/kid_goats.jpg"
                end
                if address.include? "park" or address.include? "Park"
                  image_path = "places/park.jpg"
                end
                if address.include? "natural history" or address.include? "Natural History" or title.include? "science" or title.include? "Science" or address.include? "science" or address.include? "Science"
                  image_path = "places/prehistoric.jpg"
                end
                if address.include? "sports" or address.include? "Sports" or address.include? "baseball" or address.include? "Baseball" or address.include? "stadium" or address.include? "Stadium"
                  image_path = "places/stadium_seats.jpg"
                end
                if address.include? "observatory" or address.include? "Observatory" or address.include? "planetarium" or address.include? "Planetarium"
                  image_path = "places/stars.jpg"
                end
                if title.include? "pumpkin" or title.include? "Pumpkin" or title.include? "haunt" or title.include? "Haunt" or title.include? "trick-or-treat" or title.include? "Trick-or-Treat" or title.include? "pumpkins" or title.include? "Pumpkins" or title.include? "scary" or title.include? "Scary" or title.include? "Spooky" or title.include? "spooky" or title.include? "trick or treat" or title.include? "Halloween" or title.include? "haunted" or title.include? "Haunt" or title.include? "harvest" or title.include? "Harvest" or title.include? "October"
                  image_path = "activities/pumpkin.jpg"
                end
                if title.include? "asian" or title.include? "Asian" or title.include? "chinese" or title.include? "Chinese" or title.include? "japanese" or title.include? "Japanese"
                  image_path = "activities/asian.jpg"
                end
                if title.include? "balloon" or title.include? "Balloon"
                  image_path = "activities/balloons.jpg"
                end
                if title.include? "baseball" or title.include? "Baseball"
                  image_path = "activities/baseball.jpg"
                end
                if title.include? "bike" or title.include? "Bike"
                  image_path = "activities/bike.jpg"
                end
                if title.include? "board game" or title.include? "Board Game"
                  image_path = "activities/board_game.jpg"
                end
                if title.include? "book" or title.include? "books" or title.include? "Book" or address.include? "Book" or address.include? "book"
                  image_path = "activities/book_shelf.jpg"
                end
                if title.include? "bowling" or title.include? "Bowling"
                  image_path = "activities/bowling.jpg"
                end
                if title.include? "camp" or title.include? "Camp"
                  image_path = "activities/campfire.jpg"
                end
                if title.include? "christmas" or title.include? "xmas" or title.include? "Christmas" or title.include? "Xmas"
                  image_path = "activities/christmas_tree.jpg"
                end
                if title.include? "concert" or title.include? "Concert" or title.include? "orchestra" or title.include? "Orchestra" or title.include? "symphony" or title.include? "Symphony" or address.include? "Symphony"
                  image_path = "activities/concert.jpg"
                end
                if title.include? "dance" or title.include? "ballet" or title.include? "Dance" or title.include? "Ballet"
                  image_path = "activities/dance.jpg"
                end
                if title.include? "animal" or title.include? "Animal" or title.include? "pets" or title.include? "Pets" or title.include? "dog" or title.include? "Dog" or title.include? "cat" or title.include? "Cat"
                  image_path = "activities/dog_cat.jpg"
                end
                if title.include? "food truck" or address.include? "food truck" or title.include? "Food Truck" or address.include? "Food Truck"
                  image_path = "activities/food_truck.jpg"
                end
                if title.include? "hot air" or title.include? "Hot Air"
                  image_path = "activities/hot_air_balloon.jpg"
                end
                if title.include? "magic" or title.include? "Magic"
                  image_path = "activities/magic.jpg"
                end
                if title.include? "magician" or title.include? "Magician"
                  image_path = "activities/magician.jpg"
                end
                if title.include? "music" or address.include? "music" or title.include? "Music" or address.include? "Music"
                  image_path = "activities/music.jpg"
                end
                if title.include? "air show" or title.include? "Air Show" or title.include? "plane" or title.include? "Plane" or title.include? "fighter jet" or title.include? "Blue Angels"
                  image_path = "activities/plane.jpg"
                end
                if address.include? "conservatory" or address.include? "Conservatory" or address.include? "arboretum" or address.include? "Arboretum" or address.include? "botanical" or address.include? "Botanical" or address.include? "garden" or address.include? "Garden"
                  image_path = "activities/plant.jpg"
                end
                if address.include? "playhouse" or address.include? "Playhouse" or title.include? "puppet" or title.include? "Puppet"
                  image_path = "activities/playhouse.jpg"
                end
                if address.include? "pumpkin patch" or address.include? "Pumpkin patch" or address.include? "Pumpkin Patch"
                  image_path = "activities/pumpkin_patch.jpg"
                end
                if title.include? "roses" or title.include? "Rose"
                  image_path = "activities/roses.jpg"
                end
                if title.include? "exercise" or title.include? "Exercise" or title.include? "jog" or title.include? "Jog" or title.include? "workout" or title.include? "Workout" or title.include? "marathon" or title.include? "Marathon"
                  image_path = "activities/running_shoes.jpg"
                end
                if title.include? "Santa"
                  image_path = "activities/santa_magic.jpg"
                end
                if title.include? "snow" or title.include? "Snow" or title.include? "winter" or title.include? "Winter" or title.include? "December"
                  image_path = "activities/snowman.jpg"
                end
                if title.include? "story" or title.include? "Story" or title.include? "once upon a time" or title.include? "Once upon a time" or title.include? "Once Upon A Time" or title.include? "reading" or title.include? "Reading" or title.include? "tale" or title.include? "Tale"
                  image_path = "activities/story.jpg"
                end
                if title.include? "movie" or title.include? "Movie" or title.include? "cinema" or title.include? "Cinema" or title.include? "screening" or title.include? "Screening"
                  image_path = "activities/theater_seats.jpg"
                end
                if address.include? "zoo" or address.include? "Zoo"
                  image_path = "activities/zoo.jpg"
                end

                              end
                        else
                              if title.include? "child" or title.include? "Child" or title.include? "kid" or title.include? "Kid"
                  image_path = "activities/child.jpg"
                end
                if title.include? "beach" or title.include? "Beach" or address.include? "beach" or address.include? "Beach"
                  image_path = "activities/beach.jpg"
                end
                if title.include? "YMCA"
                  image_path = "activities/pool.jpg"
                end
                if address.include? "pool" or address.include? "Pool" or address.include? "lake" or address.include? "Lake"
                  image_path = "places/water.jpg"
                end
                if address.include? "playground" or title.include? "Playground"
                  image_path = "activities/swings.jpg"
                end
                if address.include? "museum" or title.include? "Museum"
                  image_path = "interests/museum.jpg"
                end
                if title.include? "party" or title.include? "Party" or title.include? "celebration" or title.include? "Celebration" or title.include? "parade" or title.include? "Parade"
                  image_path = "activities/confetti.jpg"
                end
                if title.include? "show" or title.include? "Show" or title.include? "performance" or title.include? "Performance" or address.include? "show" or address.include? "Show" or address.include? "performance" or address.include? "Performance" or address.include? "movie" or address.include? "Movie" or address.include? "cinema" or address.include? "Cinema" or title.include? "Shakespeare"
                  image_path = "activities/playhouse.jpg"
                end
                if title.include? "theater" or title.include? "Theater" or title.include? "theatre" or title.include? "Theatre" or 
                  address.include? "theater" or address.include? "Theater" or address.include? "theatre" or address.include? "Theatre"
                  image_path = "activities/theater_seats.jpg"
                end
                if title.include? "school" or title.include? "School" or title.include? "book" or title.include? "Book" or title.include? "education" or title.include? "Education" or title.include? "teacher" or title.include? "Teacher"
                  image_path = "activities/school_books.jpg"
                end
                if title.include? "space" or title.include? "Space" or title.include? "stars" or title.include? "Stars"
                  image_path = "activities/space.jpg"
                end
                if address.include? "library" or address.include? "Library"
                  image_path = "activities/book_shelf.jpg"
                end
                if address.include? "art" or address.include? "Art" or title.include? "art" or title.include? "Art"
                  image_path = "activities/art.jpg"
                end
                if title.include? "swim" or title.include? "Swim"
                  iamge_path = "activities/swim.jpg"
                end
                if address.include? "aquarium" or address.include? "Aquarium"
                  image_path = "places/aquarium.jpg"
                end
                if address.include? "cafe" or address.include? "Cafe"
                  image_path = "places/cafe_general.jpg"
                end
                if address.include? "farm" or address.include? "Farm"
                  image_path = "places/chickens.jpg"
                end
                if address.include? "farmer" or address.include? "Farmer"
                  image_path = "places/fruit_berries.jpg"
                end
                if address.include? "petting" or address.include? "Petting"
                  image_path = "places/kid_goats.jpg"
                end
                if address.include? "park" or address.include? "Park"
                  image_path = "places/park.jpg"
                end
                if address.include? "natural history" or address.include? "Natural History" or title.include? "science" or title.include? "Science" or address.include? "science" or address.include? "Science"
                  image_path = "places/prehistoric.jpg"
                end
                if address.include? "sports" or address.include? "Sports" or address.include? "baseball" or address.include? "Baseball" or address.include? "stadium" or address.include? "Stadium"
                  image_path = "places/stadium_seats.jpg"
                end
                if address.include? "observatory" or address.include? "Observatory" or address.include? "planetarium" or address.include? "Planetarium"
                  image_path = "places/stars.jpg"
                end
                if title.include? "pumpkin" or title.include? "Pumpkin" or title.include? "haunt" or title.include? "Haunt" or title.include? "trick-or-treat" or title.include? "Trick-or-Treat" or title.include? "pumpkins" or title.include? "Pumpkins" or title.include? "scary" or title.include? "Scary" or title.include? "Spooky" or title.include? "spooky" or title.include? "trick or treat" or title.include? "Halloween" or title.include? "haunted" or title.include? "Haunt" or title.include? "harvest" or title.include? "Harvest" or title.include? "October"
                  image_path = "activities/pumpkin.jpg"
                end
                if title.include? "asian" or title.include? "Asian" or title.include? "chinese" or title.include? "Chinese" or title.include? "japanese" or title.include? "Japanese"
                  image_path = "activities/asian.jpg"
                end
                if title.include? "balloon" or title.include? "Balloon"
                  image_path = "activities/balloons.jpg"
                end
                if title.include? "baseball" or title.include? "Baseball"
                  image_path = "activities/baseball.jpg"
                end
                if title.include? "bike" or title.include? "Bike"
                  image_path = "activities/bike.jpg"
                end
                if title.include? "board game" or title.include? "Board Game"
                  image_path = "activities/board_game.jpg"
                end
                if title.include? "book" or title.include? "books" or title.include? "Book" or address.include? "Book" or address.include? "book"
                  image_path = "activities/book_shelf.jpg"
                end
                if title.include? "bowling" or title.include? "Bowling"
                  image_path = "activities/bowling.jpg"
                end
                if title.include? "camp" or title.include? "Camp"
                  image_path = "activities/campfire.jpg"
                end
                if title.include? "christmas" or title.include? "xmas" or title.include? "Christmas" or title.include? "Xmas"
                  image_path = "activities/christmas_tree.jpg"
                end
                if title.include? "concert" or title.include? "Concert" or title.include? "orchestra" or title.include? "Orchestra" or title.include? "symphony" or title.include? "Symphony" or address.include? "Symphony"
                  image_path = "activities/concert.jpg"
                end
                if title.include? "dance" or title.include? "ballet" or title.include? "Dance" or title.include? "Ballet"
                  image_path = "activities/dance.jpg"
                end
                if title.include? "animal" or title.include? "Animal" or title.include? "pets" or title.include? "Pets" or title.include? "dog" or title.include? "Dog" or title.include? "cat" or title.include? "Cat"
                  image_path = "activities/dog_cat.jpg"
                end
                if title.include? "food truck" or address.include? "food truck" or title.include? "Food Truck" or address.include? "Food Truck"
                  image_path = "activities/food_truck.jpg"
                end
                if title.include? "hot air" or title.include? "Hot Air"
                  image_path = "activities/hot_air_balloon.jpg"
                end
                if title.include? "magic" or title.include? "Magic"
                  image_path = "activities/magic.jpg"
                end
                if title.include? "magician" or title.include? "Magician"
                  image_path = "activities/magician.jpg"
                end
                if title.include? "music" or address.include? "music" or title.include? "Music" or address.include? "Music"
                  image_path = "activities/music.jpg"
                end
                if title.include? "air show" or title.include? "Air Show" or title.include? "plane" or title.include? "Plane" or title.include? "fighter jet" or title.include? "Blue Angels"
                  image_path = "activities/plane.jpg"
                end
                if address.include? "conservatory" or address.include? "Conservatory" or address.include? "arboretum" or address.include? "Arboretum" or address.include? "botanical" or address.include? "Botanical" or address.include? "garden" or address.include? "Garden"
                  image_path = "activities/plant.jpg"
                end
                if address.include? "playhouse" or address.include? "Playhouse" or title.include? "puppet" or title.include? "Puppet"
                  image_path = "activities/playhouse.jpg"
                end
                if address.include? "pumpkin patch" or address.include? "Pumpkin patch" or address.include? "Pumpkin Patch"
                  image_path = "activities/pumpkin_patch.jpg"
                end
                if title.include? "roses" or title.include? "Rose"
                  image_path = "activities/roses.jpg"
                end
                if title.include? "exercise" or title.include? "Exercise" or title.include? "jog" or title.include? "Jog" or title.include? "workout" or title.include? "Workout" or title.include? "marathon" or title.include? "Marathon"
                  image_path = "activities/running_shoes.jpg"
                end
                if title.include? "Santa"
                  image_path = "activities/santa_magic.jpg"
                end
                if title.include? "snow" or title.include? "Snow" or title.include? "winter" or title.include? "Winter" or title.include? "December"
                  image_path = "activities/snowman.jpg"
                end
                if title.include? "story" or title.include? "Story" or title.include? "once upon a time" or title.include? "Once upon a time" or title.include? "Once Upon A Time" or title.include? "reading" or title.include? "Reading" or title.include? "tale" or title.include? "Tale"
                  image_path = "activities/story.jpg"
                end
                if title.include? "movie" or title.include? "Movie" or title.include? "cinema" or title.include? "Cinema" or title.include? "screening" or title.include? "Screening"
                  image_path = "activities/theater_seats.jpg"
                end
                if address.include? "zoo" or address.include? "Zoo"
                  image_path = "activities/zoo.jpg"
                end

                        end
            if image_path == nil
                  image_path = "activities/general.jpg"
            end
                        
                  Activity.where(:title => title, :where => where, :start_date => start_date,
                  :start_time => start_time, :desc => desc, :address => address, :phone => phone,
                  :link => link, :website => website, :article_link => article_link, :website_link => 
                  website_link, :image_path => image_path, :user_id => user_id).first_or_create
                  puts title, where, start_date, start_time, desc, address, phone, link, website
                  end
                end
             end   
         end
        end
      end
end