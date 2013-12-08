class Kid < ActiveRecord::Base
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings
  has_many :guardianships, dependent: :destroy
  has_many :guardians, through: :guardianships, class_name: 'User'

  has_attached_file :photo, styles: { thumb: '100x100>' }
end
