      desc "Fetch activities"
      task :fetch_activities => :environment do
      	require 'nokogiri'

      	User.all.each do |user|
      		city_name = user.city
      		city_format = city_name.downcase.split.join('-')
      		state_name = user.state.downcase
      		url = "http://www.scout.me/family-and-kids-events--near--#{city_format}-#{state_name}"
      		doc = Nokogiri::HTML(open(url))
      		doc.at_css(".summary").each do |item|
      			Activity.create!(:title => item.text.strip)
      		end
      	end
      end

