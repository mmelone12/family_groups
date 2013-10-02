      desc "Fetch activities1"
      task :fetch_activities1 => :environment do
        require 'mechanize'

        User.all.each do |user|
          city_name = user.city
          city_format = city_name.downcase.split.join('-')
          state_name = user.state.downcase
          agent = Mechanize.new
          page = agent.get("http://www.scout.me/family-and-kids-events--near--#{city_format}-#{state_name}")
          page.links_with(:class => "url summary").each do |item|
            item.click
            title = agent.page.search(".facet-title").text.strip
            where = agent.page.search(".venue").text.strip
            start_date = agent.page.search(".value-title").text.strip
            start_time = agent.page.search(".time").text.strip
            desc = agent.page.search(".facet_description").text.strip.truncate(200)
            address = agent.page.search(".address").text.strip
            phone = agent.page.search(".facet_phone").text.strip
            link = agent.page.search(".facet_url").text.strip
            website = agent.page.search(".url span").text.strip
            Activity.create!(:title => title, :where => where, :start_date => start_date,
              :start_time => start_time, :desc => desc, :address => address, :phone => phone,
              :link => link, :website => website)
            puts title, where, start_date, start_time, desc, address, phone, link, website
          end
        end
      end