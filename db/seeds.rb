require "open-uri"

# Clear existing data
User.destroy_all
Item.destroy_all

# Create users
users = User.create!([
  {
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
  }
])

# Define the hash with categories, items, and image URLs
items_hash = {
  "lighting" => [
    { name: "LED Pixel Tube Lights", image_url: "https://images.unsplash.com/photo-1523376460408-aeb5f5d051b8?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" },
    { name: "String Lights", image_url: "https://images.unsplash.com/photo-1523376460408-aeb5f5d051b8?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" },
    { name: "Spotlights", image_url: "https://images.unsplash.com/photo-1523376460408-aeb5f5d051b8?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" },
    { name: "Flood Lights", image_url: "https://images.unsplash.com/photo-1523376460408-aeb5f5d051b8?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" }
  ],
  "entertainment" => [
    { name: "Portable Projector", image_url: "https://images.unsplash.com/photo-1499364615650-ec38552f4f34?q=80&w=1544&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" },
    { name: "Dance Floor", image_url: "https://images.unsplash.com/photo-1499364615650-ec38552f4f34?q=80&w=1544&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" },
    { name: "Photo Booth", image_url: "https://images.unsplash.com/photo-1499364615650-ec38552f4f34?q=80&w=1544&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" },
    { name: "Live Music Setup", image_url: "https://images.unsplash.com/photo-1499364615650-ec38552f4f34?q=80&w=1544&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" }
  ],
  "tents and canopies" => [
    { name: "Pop-up Canopy", image_url: "https://example.com/pop_up_canopy.jpg" },
    { name: "Wedding Tent", image_url: "https://example.com/wedding_tent.jpg" },
    { name: "Sidewalls for Tents", image_url: "https://example.com/sidewalls_for_tents.jpg" },
    { name: "Portable Shade", image_url: "https://example.com/portable_shade.jpg" }
  ],
  "furniture" => [
    { name: "Folding Chairs", image_url: "https://example.com/folding_chairs.jpg" },
    { name: "Cocktail Tables", image_url: "https://example.com/cocktail_tables.jpg" },
    { name: "Lounge Sofas", image_url: "https://example.com/lounge_sofas.jpg" },
    { name: "Bar Stools", image_url: "https://example.com/bar_stools.jpg" }
  ],
  "sound equipment" => [
    { name: "Wireless Microphone", image_url: "https://example.com/wireless_microphone.jpg" },
    { name: "Bluetooth Speakers", image_url: "https://example.com/bluetooth_speakers.jpg" },
    { name: "PA System", image_url: "https://example.com/pa_system.jpg" },
    { name: "Subwoofers", image_url: "https://example.com/subwoofers.jpg" }
  ],
  "signs and banners" => [
    { name: "Directional Signs", image_url: "https://example.com/directional_signs.jpg" },
    { name: "Custom Banners", image_url: "https://example.com/custom_banners.jpg" },
    { name: "Table Signs", image_url: "https://example.com/table_signs.jpg" },
    { name: "Welcome Signs", image_url: "https://example.com/welcome_signs.jpg" }
  ],
  "power and cables" => [
    { name: "Extension Cords", image_url: "https://example.com/extension_cords.jpg" },
    { name: "Power Strips", image_url: "https://example.com/power_strips.jpg" },
    { name: "Generators", image_url: "https://example.com/generators.jpg" },
    { name: "Cable Organizers", image_url: "https://example.com/cable_organizers.jpg" }
  ]
}

# Loop through each user and create items with images
users.each do |user|
  5.times do
    category = items_hash.keys.sample
    item = items_hash[category].sample
    item_name = item[:name]
    item_image_url = item[:image_url]
    description = "#{item_name} - A great item for #{category} needs."

    # Download and attach the image
    file = URI.open(item_image_url)

    user.items.create(
      name: item_name,
      description: description,
      category: category,
      price: rand(50..5_000),
      photo: { io: file, filename: "#{item_name.parameterize}.jpg", content_type: "image/jpeg" }
    )
    puts "Created #{item_name} in category #{category}"
  end
  puts "Finished!"
end
