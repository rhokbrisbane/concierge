class Tagging < ActiveRecord::Base
  belongs_to :user
  belongs_to :tag
  belongs_to :taggable, polymorphic: true

  delegate :to_s, to: :tag
end
