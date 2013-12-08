class Resource < ActiveRecord::Base
  include Taggable
  include Commentable
end

