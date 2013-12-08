class Kid < ActiveRecord::Base
  include Taggable

  has_many :guardianships, dependent: :destroy
  has_many :guardians, through: :guardianships, class_name: 'User'

  has_attached_file :photo, styles: { thumb: '100x100>' }
end
