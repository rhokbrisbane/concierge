class Tag < ActiveRecord::Base
  CATEGORIES = [
    'needs',
    'symtoms',
    'age_group',
    'weight_group'
  ]

  def to_s
    name
  end

  has_many :taggings
  has_many :users, as: :taggable, through: :taggings
  has_many :resources, as: :taggable, through: :taggings
end
