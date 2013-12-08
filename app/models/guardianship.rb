class Guardianship < ActiveRecord::Base
  belongs_to :kid
  belongs_to :guardians, class_name: 'User', foreign_key: 'user_id'
end
