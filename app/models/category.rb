class Category < ActiveRecord::Base
  validates :name, presence: true

  has_many :tags

  def to_s
    name
  end
end
