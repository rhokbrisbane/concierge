class Resource < ActiveRecord::Base
  include Taggable
  include Commentable

  def to_s
    name
  end
end

