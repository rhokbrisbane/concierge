##### Users #####

puts 'Creating users...'

users_attributes = [
  { email: 'admin@example.com', password: 'rhok2013', admin: true },
  { email: 'user@example.com',  password: 'rhok2013', admin: false },
]

users = []
users_attributes.each do |user_attributes|
  users << (User.where(email: user_attributes[:email]).first || User.create!(user_attributes))
end

##### Groups ####

puts 'Creating public group...'

public_group = Group.where(name: 'Public').first_or_create
users.each { |user| public_group.users << user }

##### Tag Category ######

puts 'Creating tag categories...'

['Needs', 'Symptoms', 'Age group', 'Weight group'].each do |name|
  TagCategory.where(name: name).first_or_create
end

##### Tags ######

tags_attributes = File.open("#{Rails.root}/db/seeds/symptoms.txt").each_line.map do |tag_name|
  { name: tag_name, tag_category_id: TagCategory.find_by_name('Symptoms').id }
end

puts "Importing #{tags_attributes.count} tags, it could take a while..."

tags_attributes.each do |tag_attributes|
  Tag.where(name: tag_attributes[:name]).first || Tag.create!(tag_attributes)
end

##### Resource Category ######

puts 'Creating resource categories...'

resource_categories = [
  'Advocacy',
  'Community Centre',
  'Counselling',
  'Info',
  'Disability & Chronic Illness',
  'Education',
  'Equipment',
  'Funding',
  'Other'
]

resource_categories.each { |name| ResourceCategory.where(name: name).first_or_create }

##### Resources #####

resources_attributes = []

CSV.foreach("#{Rails.root}/db/seeds/organisations.csv") do |category, name, url, phone, facebook, twitter|
  resources_attributes << { resource_category_id: ResourceCategory.find_by_name(category).id,
    name: name, url: url, phone: phone, facebook: facebook, twitter: twitter }
end

puts "Importing #{resources_attributes.count} resources, it could take a while..."

resources_attributes.each do |resource_attributes|
  Resource.where(name: resource_attributes[:name]).first || Resource.create!(resource_attributes)
end
