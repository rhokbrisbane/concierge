class Kid < ActiveRecord::Base
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  has_attached_file :photo, styles: { thumb: '100x100>' }
end
