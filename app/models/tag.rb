class Tag < ActiveRecord::Base
  include Commentable

  CATEGORIES = [
    'needs',
    'symtoms',
    'age_group',
    'weight_group'
  ]

  has_many :taggings
  has_many :users, as: :taggable, through: :taggings
  has_many :resources, as: :taggable, through: :taggings
end
