class UserSerializer < ApplicationSerializer
  attributes :name, :email, :addresses
  has_many :addresses, serializer: AddressSerializer
end
