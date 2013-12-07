class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :users, as: :taggable, through: :taggings
end
