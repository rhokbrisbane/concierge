class UserSerializer < ApplicationSerializer
  attributes :id, :name, :email, :address
  has_one :address, serializer: AddressSerializer
end
