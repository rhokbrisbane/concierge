class GroupShare < ActiveRecord::Base
  belongs_to :shared_group, class_name: "Group"
  belongs_to :sharable, polymorphic: true
end
