class Tag < ActiveRecord::Base
  include Commentable

  validates :name, presence: true

  def to_s
    name
  end

  belongs_to :tag_category

  has_many :taggings
  has_many :users,     as: :taggable, through: :taggings
  has_many :resources, as: :taggable, through: :taggings
end
