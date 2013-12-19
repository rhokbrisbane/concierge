class Resource < ActiveRecord::Base
  extend EnumerateIt

  include Sharable
  include Taggable
  include Commentable

  belongs_to :user

  has_one :address, as: :addressable

  has_enumeration_for :category, with: ResourcesCategory

  def to_s
    name
  end
end
