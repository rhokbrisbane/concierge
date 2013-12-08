class UserShare < ActiveRecord::Base
  belongs_to :shared_user, class_name: "User"
  belongs_to :sharable, polymorphic: true
end
