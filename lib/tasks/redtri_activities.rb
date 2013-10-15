desc "Fetch prices"
task :fetch_redtri => :environment do
	require 'mechanize'
	
            agent = Mechanize.new
            page = agent.get("http://redtri.com/events/san-francisco/")
            agent.page.search(".event").each do |activity|
                link = activity.search("a").first.to_s[/(http[^"]+\w)/]
                title = activity.search("h2 a").text.strip
                cost = activity.search("span")[5].text.strip
                if cost = "Free" || "FREE"
                  formatted_cost = "This is a free event."
                else
                  formatted_cost = "See the link for full details on costs" + cost
                end
                ages = activity.search("span")[7].text.strip
                formatted_ages = "This event is open to" + ages.downcase
                address = activity.search("span")[3].text.strip
                total_date = activity.search("span")[1].text.strip
                if total_date.include?("every" || "Every")
                  recurring = "yes"
                  start_date = ""
                else
                  recurring = "no"
                  start_date = Date.parse(total_date)
                article_link = "More Info"
                desc = formatted_cost + formatted_ages
                if title.include?("pumpkin" || "Pumpkin" || "pumkins" || "Pumpkins")
                  image_path = "imgs/events/carnivalresized.png"
                else 
                  image_path = "imgs/events/kites.png"
                end
                if title.present?                       
                  Activity.where(:title => title, :start_date => start_date, :when => total_date, :desc => desc, :address => address,
                  :link => link, :article_link => article_link, :recurring => recurring, :image_path => image_path).first_or_create
                  puts title, total_date, desc, address, link
                end
              end
            end   
  end
end

