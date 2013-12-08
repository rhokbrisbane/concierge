class Resource < ActiveRecord::Base
  include Sharable
  include Taggable
  include Commentable

  belongs_to :user
  has_many :addresses, as: :addressable

  def to_s
    name
  end
end
