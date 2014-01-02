class Tagging < ActiveRecord::Base
  belongs_to :user
  belongs_to :tag
  belongs_to :taggable, polymorphic: true

  delegate :to_s, to: :tag

  validates :tag_id, uniqueness: { scope: [:taggable_type, :taggable_id] }
end
