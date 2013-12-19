class UserSerializer < ApplicationSerializer
  attributes :name, :email, :address
  has_one :address, serializer: AddressSerializer
end
