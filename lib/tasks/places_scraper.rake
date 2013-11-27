desc "Fetch places"
task :fetch_places => :environment do
  require 'mechanize'
  require 'uri'
  require 'net/http'

      City.where(:id => 123 .. 185).all.each do |city|
            city_name = city.name
            city_format = city_name.downcase.split.join('-')
            state_name = city.state.downcase
            agent = Mechanize.new
            pages = ["http://www.scout.me/parks--near--#{city_format}-#{state_name}", "http://www.scout.me/zoos-and-aquariums--near--#{city_format}-#{state_name}" ]
            pages.each do |enter|
            page = agent.get(enter)
            agent.page.search(".content").each do |place|
                  image_test = place.search("img").to_s[/(http[^"]+\w)/]
                  place_link = place.search("a").first.to_s[/(http[^"]+\w)/]
                  url = URI.parse(place_link)
                  req = Net::HTTP.new(url.host, url.port)
                  res = req.request_head(url.path)
                  if res.code == "200"
                  page = agent.get("#{place_link}")
                  name = agent.page.search(".facet-title").text.strip.truncate(50)
                  desc = agent.page.search(".facet_description").text.strip.truncate(100)
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
                  url = URI.parse(URI.encode(image_test))
                  Net::HTTP.start(url.host, url.port) do |http|
                        response = http.head(url.path)
                        case response
                        when Net::HTTPSuccess, Net::HTTPRedirection
                              case response.content_type
                              when "image/png", "image/gif", "image/jpeg"
                                    image_path = place.search("img").to_s[/(http[^"]+\w)/]
                              else
                if name.include? "child" or name.include? "Child" or name.include? "kid" or name.include? "Kid"
                  image_path = "activities/child.jpg"
                end
                if name.include? "beach" or name.include? "Beach" or name.include? "beach" or address.include? "Beach"
                  image_path = "activities/beach.jpg"
                end
                if name.include? "YMCA"
                  image_path = "activities/pool.jpg"
                end
                if address.include? "pool" or address.include? "Pool" or address.include? "lake" or address.include? "Lake"
                  image_path = "places/water.jpg"
                end
                if address.include? "playground" or name.include? "Playground"
                  image_path = "activities/swings.jpg"
                end
                if address.include? "museum" or name.include? "Museum"
                  image_path = "interests/museum.jpg"
                end
                if name.include? "party" or name.include? "Party" or name.include? "celebration" or name.include? "Celebration" or name.include? "parade" or name.include? "Parade"
                  image_path = "activities/confetti.jpg"
                end
                if name.include? "show" or name.include? "Show" or name.include? "performance" or name.include? "Performance" or address.include? "show" or address.include? "Show" or address.include? "performance" or address.include? "Performance" or address.include? "movie" or address.include? "Movie" or address.include? "cinema" or address.include? "Cinema" or name.include? "Shakespeare"
                  image_path = "activities/playhouse.jpg"
                end
                if name.include? "theater" or name.include? "Theater" or name.include? "theatre" or name.include? "Theatre" or 
                  address.include? "theater" or address.include? "Theater" or address.include? "theatre" or address.include? "Theatre"
                  image_path = "activities/theater_seats.jpg"
                end
                if name.include? "school" or name.include? "School" or name.include? "book" or name.include? "Book" or name.include? "education" or name.include? "Education" or name.include? "teacher" or name.include? "Teacher"
                  image_path = "activities/school_books.jpg"
                end
                if name.include? "space" or name.include? "Space" or name.include? "stars" or name.include? "Stars"
                  image_path = "activities/space.jpg"
                end
                if address.include? "library" or address.include? "Library"
                  image_path = "activities/book_shelf.jpg"
                end
                if address.include? "art" or address.include? "Art" or name.include? "art" or name.include? "Art"
                  image_path = "activities/art.jpg"
                end
                if name.include? "swim" or name.include? "Swim"
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
                if address.include? "park" or address.include? "Park" or name.include? "park" or name.include? "Park"
                  image_path = "places/park.jpg"
                end
                if address.include? "natural history" or address.include? "Natural History" or name.include? "science" or name.include? "Science" or address.include? "science" or address.include? "Science"
                  image_path = "places/prehistoric.jpg"
                end
                if address.include? "sports" or address.include? "Sports" or address.include? "baseball" or address.include? "Baseball" or address.include? "stadium" or address.include? "Stadium"
                  image_path = "places/stadium_seats.jpg"
                end
                if address.include? "observatory" or address.include? "Observatory" or address.include? "planetarium" or address.include? "Planetarium"
                  image_path = "places/stars.jpg"
                end
                if name.include? "pumpkin" or name.include? "Pumpkin" or name.include? "haunt" or name.include? "Haunt" or name.include? "trick-or-treat" or name.include? "Trick-or-Treat" or name.include? "pumpkins" or name.include? "Pumpkins" or name.include? "scary" or name.include? "Scary" or name.include? "Spooky" or name.include? "spooky" or name.include? "trick or treat" or name.include? "Halloween" or name.include? "haunted" or name.include? "Haunt" or name.include? "harvest" or name.include? "Harvest" or name.include? "October"
                  image_path = "activities/pumpkin.jpg"
                end
                if name.include? "asian" or name.include? "Asian" or name.include? "chinese" or name.include? "Chinese" or name.include? "japanese" or name.include? "Japanese"
                  image_path = "activities/asian.jpg"
                end
                if name.include? "balloon" or name.include? "Balloon"
                  image_path = "activities/balloons.jpg"
                end
                if name.include? "baseball" or name.include? "Baseball"
                  image_path = "activities/baseball.jpg"
                end
                if name.include? "bike" or name.include? "Bike"
                  image_path = "activities/bike.jpg"
                end
                if name.include? "board game" or name.include? "Board Game"
                  image_path = "activities/board_game.jpg"
                end
                if name.include? "book" or name.include? "books" or name.include? "Book" or address.include? "Book" or address.include? "book"
                  image_path = "activities/book_shelf.jpg"
                end
                if name.include? "bowling" or name.include? "Bowling"
                  image_path = "activities/bowling.jpg"
                end
                if name.include? "camp" or name.include? "Camp"
                  image_path = "activities/campfire.jpg"
                end
                if name.include? "christmas" or name.include? "xmas" or name.include? "Christmas" or name.include? "Xmas"
                  image_path = "activities/christmas_tree.jpg"
                end
                if name.include? "concert" or name.include? "Concert" or name.include? "orchestra" or name.include? "Orchestra" or name.include? "symphony" or name.include? "Symphony" or address.include? "Symphony"
                  image_path = "activities/concert.jpg"
                end
                if name.include? "dance" or name.include? "ballet" or name.include? "Dance" or name.include? "Ballet"
                  image_path = "activities/dance.jpg"
                end
                if name.include? "animal" or name.include? "Animal" or name.include? "pets" or name.include? "Pets" or name.include? "dog" or name.include? "Dog" or name.include? "cat" or name.include? "Cat"
                  image_path = "activities/dog_cat.jpg"
                end
                if name.include? "food truck" or address.include? "food truck" or name.include? "Food Truck" or address.include? "Food Truck"
                  image_path = "activities/food_truck.jpg"
                end
                if name.include? "hot air" or name.include? "Hot Air"
                  image_path = "activities/hot_air_balloon.jpg"
                end
                if name.include? "magic" or name.include? "Magic"
                  image_path = "activities/magic.jpg"
                end
                if name.include? "magician" or name.include? "Magician"
                  image_path = "activities/magician.jpg"
                end
                if name.include? "music" or address.include? "music" or name.include? "Music" or address.include? "Music"
                  image_path = "activities/music.jpg"
                end
                if name.include? "air show" or name.include? "Air Show" or name.include? "plane" or name.include? "Plane" or name.include? "fighter jet" or name.include? "Blue Angels"
                  image_path = "activities/plane.jpg"
                end
                if address.include? "conservatory" or address.include? "Conservatory" or address.include? "arboretum" or address.include? "Arboretum" or address.include? "botanical" or address.include? "Botanical" or address.include? "garden" or address.include? "Garden"
                  image_path = "activities/plant.jpg"
                end
                if address.include? "playhouse" or address.include? "Playhouse" or name.include? "puppet" or name.include? "Puppet"
                  image_path = "activities/playhouse.jpg"
                end
                if address.include? "pumpkin patch" or address.include? "Pumpkin patch" or address.include? "Pumpkin Patch"
                  image_path = "activities/pumpkin_patch.jpg"
                end
                if name.include? "roses" or name.include? "Rose"
                  image_path = "activities/roses.jpg"
                end
                if name.include? "exercise" or name.include? "Exercise" or name.include? "jog" or name.include? "Jog" or name.include? "workout" or name.include? "Workout" or name.include? "marathon" or name.include? "Marathon"
                  image_path = "activities/running_shoes.jpg"
                end
                if name.include? "Santa"
                  image_path = "activities/santa_magic.jpg"
                end
                if name.include? "snow" or name.include? "Snow" or name.include? "winter" or name.include? "Winter" or name.include? "December"
                  image_path = "activities/snowman.jpg"
                end
                if name.include? "story" or name.include? "Story" or name.include? "once upon a time" or name.include? "Once upon a time" or name.include? "Once Upon A Time" or name.include? "reading" or name.include? "Reading" or name.include? "tale" or name.include? "Tale"
                  image_path = "activities/story.jpg"
                end
                if name.include? "movie" or name.include? "Movie" or name.include? "cinema" or name.include? "Cinema" or name.include? "screening" or name.include? "Screening"
                  image_path = "activities/theater_seats.jpg"
                end
                if address.include? "zoo" or address.include? "Zoo"
                  image_path = "activities/zoo.jpg"
                end
          end
    else
                      if name.include? "child" or name.include? "Child" or name.include? "kid" or name.include? "Kid"
                  image_path = "activities/child.jpg"
                end
                if name.include? "beach" or name.include? "Beach" or name.include? "beach" or address.include? "Beach"
                  image_path = "activities/beach.jpg"
                end
                if name.include? "YMCA"
                  image_path = "activities/pool.jpg"
                end
                if address.include? "pool" or address.include? "Pool" or address.include? "lake" or address.include? "Lake"
                  image_path = "places/water.jpg"
                end
                if address.include? "playground" or name.include? "Playground"
                  image_path = "activities/swings.jpg"
                end
                if address.include? "museum" or name.include? "Museum"
                  image_path = "interests/museum.jpg"
                end
                if name.include? "party" or name.include? "Party" or name.include? "celebration" or name.include? "Celebration" or name.include? "parade" or name.include? "Parade"
                  image_path = "activities/confetti.jpg"
                end
                if name.include? "show" or name.include? "Show" or name.include? "performance" or name.include? "Performance" or address.include? "show" or address.include? "Show" or address.include? "performance" or address.include? "Performance" or address.include? "movie" or address.include? "Movie" or address.include? "cinema" or address.include? "Cinema" or name.include? "Shakespeare"
                  image_path = "activities/playhouse.jpg"
                end
                if name.include? "theater" or name.include? "Theater" or name.include? "theatre" or name.include? "Theatre" or 
                  address.include? "theater" or address.include? "Theater" or address.include? "theatre" or address.include? "Theatre"
                  image_path = "activities/theater_seats.jpg"
                end
                if name.include? "school" or name.include? "School" or name.include? "book" or name.include? "Book" or name.include? "education" or name.include? "Education" or name.include? "teacher" or name.include? "Teacher"
                  image_path = "activities/school_books.jpg"
                end
                if name.include? "space" or name.include? "Space" or name.include? "stars" or name.include? "Stars"
                  image_path = "activities/space.jpg"
                end
                if address.include? "library" or address.include? "Library"
                  image_path = "activities/book_shelf.jpg"
                end
                if address.include? "art" or address.include? "Art" or name.include? "art" or name.include? "Art"
                  image_path = "activities/art.jpg"
                end
                if name.include? "swim" or name.include? "Swim"
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
                if address.include? "park" or address.include? "Park" or name.include? "park" or name.include? "Park"
                  image_path = "places/park.jpg"
                end
                if address.include? "natural history" or address.include? "Natural History" or name.include? "science" or name.include? "Science" or address.include? "science" or address.include? "Science"
                  image_path = "places/prehistoric.jpg"
                end
                if address.include? "sports" or address.include? "Sports" or address.include? "baseball" or address.include? "Baseball" or address.include? "stadium" or address.include? "Stadium"
                  image_path = "places/stadium_seats.jpg"
                end
                if address.include? "observatory" or address.include? "Observatory" or address.include? "planetarium" or address.include? "Planetarium"
                  image_path = "places/stars.jpg"
                end
                if name.include? "pumpkin" or name.include? "Pumpkin" or name.include? "haunt" or name.include? "Haunt" or name.include? "trick-or-treat" or name.include? "Trick-or-Treat" or name.include? "pumpkins" or name.include? "Pumpkins" or name.include? "scary" or name.include? "Scary" or name.include? "Spooky" or name.include? "spooky" or name.include? "trick or treat" or name.include? "Halloween" or name.include? "haunted" or name.include? "Haunt" or name.include? "harvest" or name.include? "Harvest" or name.include? "October"
                  image_path = "activities/pumpkin.jpg"
                end
                if name.include? "asian" or name.include? "Asian" or name.include? "chinese" or name.include? "Chinese" or name.include? "japanese" or name.include? "Japanese"
                  image_path = "activities/asian.jpg"
                end
                if name.include? "balloon" or name.include? "Balloon"
                  image_path = "activities/balloons.jpg"
                end
                if name.include? "baseball" or name.include? "Baseball"
                  image_path = "activities/baseball.jpg"
                end
                if name.include? "bike" or name.include? "Bike"
                  image_path = "activities/bike.jpg"
                end
                if name.include? "board game" or name.include? "Board Game"
                  image_path = "activities/board_game.jpg"
                end
                if name.include? "book" or name.include? "books" or name.include? "Book" or address.include? "Book" or address.include? "book"
                  image_path = "activities/book_shelf.jpg"
                end
                if name.include? "bowling" or name.include? "Bowling"
                  image_path = "activities/bowling.jpg"
                end
                if name.include? "camp" or name.include? "Camp"
                  image_path = "activities/campfire.jpg"
                end
                if name.include? "christmas" or name.include? "xmas" or name.include? "Christmas" or name.include? "Xmas"
                  image_path = "activities/christmas_tree.jpg"
                end
                if name.include? "concert" or name.include? "Concert" or name.include? "orchestra" or name.include? "Orchestra" or name.include? "symphony" or name.include? "Symphony" or address.include? "Symphony"
                  image_path = "activities/concert.jpg"
                end
                if name.include? "dance" or name.include? "ballet" or name.include? "Dance" or name.include? "Ballet"
                  image_path = "activities/dance.jpg"
                end
                if name.include? "animal" or name.include? "Animal" or name.include? "pets" or name.include? "Pets" or name.include? "dog" or name.include? "Dog" or name.include? "cat" or name.include? "Cat"
                  image_path = "activities/dog_cat.jpg"
                end
                if name.include? "food truck" or address.include? "food truck" or name.include? "Food Truck" or address.include? "Food Truck"
                  image_path = "activities/food_truck.jpg"
                end
                if name.include? "hot air" or name.include? "Hot Air"
                  image_path = "activities/hot_air_balloon.jpg"
                end
                if name.include? "magic" or name.include? "Magic"
                  image_path = "activities/magic.jpg"
                end
                if name.include? "magician" or name.include? "Magician"
                  image_path = "activities/magician.jpg"
                end
                if name.include? "music" or address.include? "music" or name.include? "Music" or address.include? "Music"
                  image_path = "activities/music.jpg"
                end
                if name.include? "air show" or name.include? "Air Show" or name.include? "plane" or name.include? "Plane" or name.include? "fighter jet" or name.include? "Blue Angels"
                  image_path = "activities/plane.jpg"
                end
                if address.include? "conservatory" or address.include? "Conservatory" or address.include? "arboretum" or address.include? "Arboretum" or address.include? "botanical" or address.include? "Botanical" or address.include? "garden" or address.include? "Garden"
                  image_path = "activities/plant.jpg"
                end
                if address.include? "playhouse" or address.include? "Playhouse" or name.include? "puppet" or name.include? "Puppet"
                  image_path = "activities/playhouse.jpg"
                end
                if address.include? "pumpkin patch" or address.include? "Pumpkin patch" or address.include? "Pumpkin Patch"
                  image_path = "activities/pumpkin_patch.jpg"
                end
                if name.include? "roses" or name.include? "Rose"
                  image_path = "activities/roses.jpg"
                end
                if name.include? "exercise" or name.include? "Exercise" or name.include? "jog" or name.include? "Jog" or name.include? "workout" or name.include? "Workout" or name.include? "marathon" or name.include? "Marathon"
                  image_path = "activities/running_shoes.jpg"
                end
                if name.include? "Santa"
                  image_path = "activities/santa_magic.jpg"
                end
                if name.include? "snow" or name.include? "Snow" or name.include? "winter" or name.include? "Winter" or name.include? "December"
                  image_path = "activities/snowman.jpg"
                end
                if name.include? "story" or name.include? "Story" or name.include? "once upon a time" or name.include? "Once upon a time" or name.include? "Once Upon A Time" or name.include? "reading" or name.include? "Reading" or name.include? "tale" or name.include? "Tale"
                  image_path = "activities/story.jpg"
                end
                if name.include? "movie" or name.include? "Movie" or name.include? "cinema" or name.include? "Cinema" or name.include? "screening" or name.include? "Screening"
                  image_path = "activities/theater_seats.jpg"
                end
                if address.include? "zoo" or address.include? "Zoo"
                  image_path = "activities/zoo.jpg"
                end
            end
            if image_path == nil
                  image_path = "activities/general.jpg"
            end
                        
                  Place.where(:name => name, :desc => desc, :address => address, :phone => phone,
                  :link => link, :website => website, :image_path => image_path).first_or_create
                  puts name, desc, address, phone, link, website
                  end
                  end
               end   
            end
          end
      end
end