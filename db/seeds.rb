# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

10.times do
  user = User.create!(name: Faker::Name.name, email: Faker::Internet.email, password: Faker::Lorem.characters(8))
end

5.times do
  users = User.all
  users.each do |user|
    name = Faker::App.name
    url = Faker::Internet.url
    user.registered_applications.create!(name: name, url: url)
  end

10.times do
  registered_applications = RegisteredApplication.random
  registered_applications.each do |regapp|
    name = Faker::Commerce.department(1)
    regapp.events.create!(name: name)
  end
end
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{RegisteredApplication.count} registered apps created"
puts "#{Event.count} events created"
