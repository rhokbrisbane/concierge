class Resource < ActiveRecord::Base
  include Sharable

  belongs_to :user
end
