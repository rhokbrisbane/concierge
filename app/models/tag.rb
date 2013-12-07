class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :users, as: :taggable, through: :taggings
  has_many :resources, as: :taggable, through: :taggings
end
