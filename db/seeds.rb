# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
User.destroy_all
Item.destroy_all

# User.new
users = User.create!([{
    email: 'jessnew@gmail.com',
    password: 'password',
    first_name: 'Jess',
    last_name: 'New',
    username: 'jessdesigns1'
  },
  {
    email: 'rachelgreen1@gmail.com',
    password: 'password',
    first_name: 'Rachel',
    last_name: 'Green',
    username: 'rachelgreen211'
  },
  {
    email: 'rachelgreen@gmail.com',
    password: 'password',
    first_name: 'Rachel',
    last_name: 'Green',
    username: 'rachelgreen21'
  },
  {
    email: 'eddydesigns@gmail.com',
    password: 'password',
    first_name: 'Eddy',
    last_name: 'Smith',
    username: 'eddysmithphoto'
  }])

# Define the hash with categories and items
items_hash = {
  "lighting" => [
    "LED Pixel Tube Lights",
    "String Lights",
    "Spotlights",
    "Flood Lights"
  ],
  "entertainment" => [
    "Portable Projector",
    "Dance Floor",
    "Photo Booth",
    "Live Music Setup"
  ],
  "tents and canopies" => [
    "Pop-up Canopy",
    "Wedding Tent",
    "Sidewalls for Tents",
    "Portable Shade"
  ],
  "furniture" => [
    "Folding Chairs",
    "Cocktail Tables",
    "Lounge Sofas",
    "Bar Stools"
  ],
  "sound equipment" => [
    "Wireless Microphone",
    "Bluetooth Speakers",
    "PA System",
    "Subwoofers"
  ],
  "signs and banners" => [
    "Directional Signs",
    "Custom Banners",
    "Table Signs",
    "Welcome Signs"
  ],
  "power and cables" => [
    "Extension Cords",
    "Power Strips",
    "Generators",
    "Cable Organizers"
  ]
}

# Loop through each user
users.each do |user|
  5.times do
    category = items_hash.keys.sample
    item_name = items_hash[category].sample
    description = "#{item_name} - A great item for #{category} needs."

    user.items.create(
      name: item_name,
      description: description,
      category: category,
      price: rand(50..50_000)
    )
    puts "Created #{item_name} in category #{category}"
  end
  puts "Finished!"
end
