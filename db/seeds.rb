# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

all_tags = FactoryGirl.create_list :tag, 50

admin = FactoryGirl.create(:admin, email: 'admin@example.com', password: 'rhok2013')
user = FactoryGirl.create(:user, email: 'user@example.com', password: 'rhok2013')

public = FactoryGirl.create(:group, name: 'Public')
public.users << admin
public.users << user

resource = FactoryGirl.create(:resource, name: "I'm a public resource, with all tags")
resource.shared_groups << public
resource.tags << all_tags
