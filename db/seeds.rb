##### Users #####

admin = FactoryGirl.create(:admin, email: 'admin@example.com', password: 'rhok2013')
user = FactoryGirl.create(:user, email: 'user@example.com', password: 'rhok2013')

##### Groups ####

public = FactoryGirl.create(:group, name: 'Public')
public.users << admin
public.users << user

##### Tags ######

tag_attributes = File.open("#{Rails.root}/db/seeds/symtoms.txt").each_line.map do |tag_name|
  { name: tag_name, category: 'symtoms' }
end

puts "Importing #{tag_attributes.count} tags, it could take a while..."

Tag.create(tag_attributes)

### Resources ###

resource = FactoryGirl.create(:resource, name: "I'm a public resource, with all tags")
resource.shared_groups << public
resource.tags << Tag.first
