desc "Fetch prices"
task :fetch_redtri => :environment do
  require 'mechanize'
  
            agent = Mechanize.new
            page = agent.get("http://redtri.com/events/san-francisco/")
            agent.page.search(".event").each do |activity|
                article_link = activity.search("a").first.to_s[/(http[^"]+\w)/]
                title = activity.search("h2 a").text.strip
                cost = activity.search("span")[5].text.strip
                if cost = "Free" || "FREE"
                  formatted_cost = "This is a free event."
                else
                  formatted_cost = "See the link for full details on costs" + cost
                end
                ages = activity.search("span")[7].text.strip
                formatted_ages = "This event is open to" + " " + ages.downcase
                address = activity.search("span")[3].text.strip
                user_id = "1"
                total_date = activity.search("span")[1].text.strip
                if total_date.include? "every" or total_date.include? "Every"
                  recurring = "yes"
                  start_date = ""
                else
                  recurring = "no"
                  start_date = Date.parse(total_date)
                end
                link = "from redtri.com"
                desc = "Where:" + " " + address + ". " + formatted_cost + " " + formatted_ages + "."
                if title.include? "pumpkin" or title.include? "Pumpkin" or title.include? "pumpkins" or title.include? "Pumpkins"
                  image_path = "imgs/events/carnivalresized.png"
                else 
                  image_path = "imgs/events/kites.png"
                end
                if title.present?                       
                  Activity.where(:title => title, :start_date => start_date, :when => total_date, :desc => desc, :address => address,
                  :link => link, :article_link => article_link, :recurring => recurring, :image_path => image_path,
                  :user_id => user_id).create
                  puts title, total_date, desc, address, link
                end
            end   
end