class Resource < ActiveRecord::Base
  include Taggable

  def to_s
    name
  end
end

