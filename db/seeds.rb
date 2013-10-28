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
  :gender => row[4],
  :new_parent => row[5],
  :single_parent => row[6],
  :children_under_5 => row[7], 
  :children_5_10 => row[8],
  :tweens => row[9],
  :teens => row[10],
  :special_needs => row[11],
  :image_path => row[12], 
  :new_parent => row[13],
  :premium => row[14]
n=n+1
end      