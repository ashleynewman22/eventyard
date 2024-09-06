require "open-uri"
# Clear existing data
Cart.destroy_all
Item.destroy_all
User.destroy_all
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
    { name: "LED Pixel Tube Lights", image_url: "https://images.unsplash.com/photo-1638302761089-3da871f9043b?q=80&w=871&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" },
    { name: "String Lights", image_url: "https://images.unsplash.com/photo-1516483156299-a0ecd4226c08?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" },
    { name: "Spotlights", image_url: "https://images.unsplash.com/photo-1585236820787-8cb3b8f97613?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" },
    { name: "Flood Lights", image_url: "https://images.unsplash.com/photo-1512066944209-fbd762175570?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" }
  ],
  "entertainment" => [
    { name: "Portable Projector", image_url: "https://images.unsplash.com/photo-1528395874238-34ebe249b3f2?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" },
    { name: "Dance Floor", image_url: "https://images.unsplash.com/photo-1664369820391-dd2cbfe9320b?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" },
    { name: "Photo Booth", image_url: "https://images.unsplash.com/photo-1556570836-1b2c15b33119?q=80&w=2069&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" },
    { name: "Live Music Setup", image_url: "https://images.unsplash.com/photo-1517260286907-f7d84f1f9ba4?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" }
  ],
  "tents and canopies" => [
    { name: "Pop-up Canopy", image_url: "https://images.unsplash.com/photo-1694311913942-28d42cccddd5?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" },
    { name: "Wedding Tent", image_url: "https://images.unsplash.com/photo-1478827536114-da961b7f86d2?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" },
    # { name: "Sidewalls for Tents", image_url: "https://americantent.com/cdn/shop/articles/Are_Tent_Sidewalls_Important-min_1024x.jpg?v=1634132888" },
    # { name: "Portable Shade", image_url: "https://m.media-amazon.com/images/I/715JDVT9DrL._AC_UF894,1000_QL80_.jpg" }
  ],
  "furniture" => [
    { name: "Folding Chairs", image_url: "https://images.unsplash.com/photo-1622699806021-bef4174d02f1?q=80&w=1931&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" },
    { name: "Cocktail Tables", image_url: "https://images.unsplash.com/photo-1485265449635-ca623a55e95c?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" },
    { name: "Lounge Sofas", image_url: "https://images.unsplash.com/photo-1512212621149-107ffe572d2f?q=80&w=1780&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" },
    { name: "Bar Stools", image_url: "https://images.unsplash.com/photo-1534603649594-2078fe2ad26c?q=80&w=2074&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" }
  ],
  "sound equipment" => [
    { name: "Wireless Microphone", image_url: "https://images.unsplash.com/photo-1683304554885-656332c636a9?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" },
    { name: "Bluetooth Speakers", image_url: "https://images.unsplash.com/photo-1531104985437-603d6490e6d4?q=80&w=2039&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" },
    # { name: "PA System", image_url: "https://oneworldrental.co.uk/blog/wp-content/uploads/2021/08/pa-system-rent.jpeg" },
    { name: "Subwoofers", image_url: "https://images.unsplash.com/photo-1529911684551-bfe3a8553f19?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" }
  ],
  "signs and banners" => [
    { name: "Directional Signs", image_url: "https://images.unsplash.com/photo-1697086317650-eda3236a4659?q=80&w=2071&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" },
    { name: "Custom Banners", image_url: "https://images.unsplash.com/photo-1622107795650-24e72a695404?q=80&w=2073&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" },
    { name: "Table Signs", image_url: "https://images.unsplash.com/photo-1692808712359-0a4980d00b3f?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" },
    { name: "Welcome Signs", image_url: "https://images.unsplash.com/photo-1533745848184-3db07256e163?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" }
  ],
  "power and cables" => [
    { name: "Extension Cords", image_url: "https://images.unsplash.com/photo-1698183168555-35305511ae52?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" },
    # { name: "Power Strips", image_url: "https://www.energy.gov/sites/default/files/styles/full_article_width/public/Powerstrip.jpeg?itok=6eTAyAc_" },
    { name: "Generators", image_url: "https://images.unsplash.com/photo-1658260867231-535a1f7c98b9?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" },
    { name: "Cable Organizers", image_url: "https://images.unsplash.com/photo-1658260867231-535a1f7c98b9?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" }
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
      price: rand(50..5000),
      photo: { io: file, filename: "#{item_name.parameterize}.jpg", content_type: "image/jpeg" }
    )
    puts "Created #{item_name} in category #{category}"
  end
  puts "Finished!"
end
