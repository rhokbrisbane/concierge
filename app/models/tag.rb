class Tag < ActiveRecord::Base
  include Commentable

  CATEGORIES = %w(needs symptoms age_group weight_group)
  validates :name, presence: true

  def to_s
    name
  end

  has_many :taggings
  has_many :users,     as: :taggable, through: :taggings
  has_many :resources, as: :taggable, through: :taggings
end
