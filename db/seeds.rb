# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv' 

directory = "db/init_data/"

file_name = "familygroupinterests.csv"
path_to_file = directory + file_name
puts 'Loading Interests records'
# Pre-load all Interest records
n=0
CSV.foreach(path_to_file, { :skip_blanks => true }) do |row|
  Interest.create! :name => row[0],
  :image_path => row[1],
  :desc => row[2]
n=n+1
end   