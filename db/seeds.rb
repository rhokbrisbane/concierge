##### Users #####

FactoryGirl.create(:admin, email: 'admin@example.com', password: 'rhok2013')
FactoryGirl.create(:user,  email: 'user@example.com',  password: 'rhok2013')

##### Tags #####

# Tag.delete_all

tag_attributes = File.open("#{Rails.root}/db/seeds/symtoms.txt").each_line.map do |tag_name|
  { name: tag_name, category: 'symtoms' }
end

puts "Importing #{tag_attributes.count} tags, it could take a while..."

Tag.create(tag_attributes)

##### Resources #####

# Resource.delete_all

resource_attributes = []
CSV.foreach("#{Rails.root}/db/seeds/organisations.csv") do |category, name, url, phone, facebook, twitter|
  resource_attributes << { category: category, name: name, url: url, phone: phone, facebook: facebook, twitter: twitter }
end

puts "Importing #{resource_attributes.count} resources..."

Resource.create(resource_attributes)
