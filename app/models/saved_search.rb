class SavedSearch < ActiveRecord::Base
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  belongs_to :user, dependent: :destroy
end
