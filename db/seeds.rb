require 'csv' 

directory = "db/init_data/"

file_name = "cities.csv"
path_to_file = directory + file_name
puts 'Loading City Records'
n=0
CSV.foreach(path_to_file, { :skip_blanks => true }) do |row|
  City.create! :name => row[0],
  :state => row[1]
n=n+1
end 