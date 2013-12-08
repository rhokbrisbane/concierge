class Resource < ActiveRecord::Base
  include Sharable
  include Taggable
  include Commentable

  belongs_to :user

  def to_s
    name
  end
end

