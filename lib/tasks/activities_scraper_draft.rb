desc "Fetch activities"
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