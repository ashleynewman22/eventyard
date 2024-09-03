# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

require 'faker'
require 'open-uri' # Ensure open-uri is required for URI.open

puts "Cleaning database..."
CartItem.destroy_all
Cart.destroy_all
Item.destroy_all
User.destroy_all

puts "Creating users..."
5.times do
  user = User.create!(
    email: Faker::Internet.unique.email,
    password: "password", # In a real app, use a secure password
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    username: Faker::Internet.unique.username
  )
  puts "Created user: #{user.email}"
end

CATEGORIES = ["Camera", "Speaker", "Display Screen", "Microphone", "Lighting"]

puts "Creating items..."
20.times do
  item = Item.new(
    name: Faker::Commerce.unique.product_name,
    price: Faker::Commerce.price(range: 50..1000.0),
    category: CATEGORIES.sample,
    description: Faker::Lorem.paragraph(sentence_count: 3),
    user: User.all.sample
  )

  begin
    # Attach a placeholder image
    file = URI.open("https://picsum.photos/400/300")
    item.photo.attach(io: file, filename: "#{item.name.parameterize}.jpg", content_type: 'image/jpg')
  rescue => e
    puts "Failed to attach image for item: #{item.name} - #{e.message}"
  end

  item.save!
  puts "Created item: #{item.name}"
end

puts "Creating carts..."
User.all.each do |user|
  cart = Cart.create!(user: user, status: 'open')
  3.times do
    CartItem.create!(cart: cart, item: Item.all.sample)
  end
  puts "Created cart for user: #{user.email}"
end

puts "Seed completed!"
