# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "#{User.count} users exist"
puts "#{RegisteredApplication.count} registered apps exist"
puts "#{Event.count} events exist"

require 'faker'

10.times do
  User.create!(
  name: Faker::Name.name,
  email: Faker::Internet.email,
  password: Faker::Lorem.characters(8)
  )
end

5.times do
  users = User.all
  users.each do |user|
    user.registered_applications.create(
    name: Faker::App.name,
    url: Faker::Internet.url
    )
  end
end


500.times do
  registered_applications = RegisteredApplication.all
  registered_app = registered_applications.sample
  event = ['signup', 'play', 'reload', 'share', 'view', 'copy' ]
  random_event = registered_app.events.create(
    event_name: event.sample)
  random_event.update_attribute :created_at, rand(5.months).seconds.ago
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{RegisteredApplication.count} registered apps created"
puts "#{Event.count} events created"
