##### Users #####

admin = FactoryGirl.create(:admin, email: 'admin@example.com', password: 'rhok2013')
user  = FactoryGirl.create(:user,  email: 'user@example.com',  password: 'rhok2013')

##### Groups ####

public_group = FactoryGirl.create(:group, name: 'Public')
public_group.users << admin
public_group.users << user

##### Category ######

['Needs', 'Symptoms', 'Age group', 'Weight group'].each do |category_name|
  Category.create(name: category_name)
end

##### Tags ######

tag_attributes = File.open("#{Rails.root}/db/seeds/symptoms.txt").each_line.map do |tag_name|
  { name: tag_name, category_id: Category.find_by_name('Symptoms').id }
end

puts "Importing #{tag_attributes.count} tags, it could take a while..."

Tag.create(tag_attributes)

##### Resources #####

resource_attributes = []
CSV.foreach("#{Rails.root}/db/seeds/organisations.csv") do |category, name, url, phone, facebook, twitter|
  resource_attributes << { category: category, name: name, url: url, phone: phone, facebook: facebook, twitter: twitter }
end

puts "Importing #{resource_attributes.count} resources..."

Resource.create(resource_attributes)

##### Public resource #####

resource = FactoryGirl.create(:resource, name: "I'm a public resource, with all tags")
resource.shared_groups << public_group
resource.tags << Tag.first
