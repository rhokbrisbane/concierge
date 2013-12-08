class Resource < ActiveRecord::Base
  has_many :addresses, as: :addressable
end
