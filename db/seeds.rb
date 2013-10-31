# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

avatars = Avatar.create!([{ image_path: 'avatars/female_avatar1.png'}, {image_path: 'avatars/female_avatar2.png'},
	{image_path: 'avatars/female_avatar3.png'}, {image_path: 'avatars/female_avatar4.png'}, {image_path: 'avatars/female_avatar5.png'},
	{image_path: 'avatars/female_avatar6.png'}, {image_path: 'avatars/female_avatar7.png'}, {image_path: 'avatars/female_avatar8.png'},
	{image_path: 'avatars/male_avatar1.png'}, {image_path: 'avatars/male_avatar2.png'}, {image_path: 'avatars/male_avatar3.png'},
	{image_path: 'avatars/male_avatar4.png'}, {image_path: 'avatars/male_avatar5.png'}, {image_path: 'avatars/male_avatar6.png'},
	{image_path: 'avatars/male_avatar7.png'}, {image_path: 'avatars/male_avatar8.png'}])

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

file_name = "users.csv"
path_to_file = directory + file_name
puts 'Loading User Records'
# Pre-load all User records
n=0
CSV.foreach(path_to_file, { :skip_blanks => true }) do |row|
  User.create! :name => row[0],
  :last_name => row[1],
  :address => row[2], 
  :email => row[3],
  :password => row[4],
  :password_confirmation => row[5],
  :gender => row[6],
  :new_parent => row[7],
  :single_parent => row[8],
  :children_under_5 => row[9], 
  :children_5_10 => row[10],
  :tweens => row[11],
  :teens => row[12],
  :special_needs => row[13],
  :image_path => row[14], 
  :non_parent => row[15],
  :premium => row[16]
n=n+1
end      