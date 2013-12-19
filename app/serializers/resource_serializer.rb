class ResourceSerializer < ApplicationSerializer
  attributes :name, :category, :url, :phone, :facebook, :twitter, :addresses
  has_many :addresses, serializer: AddressSerializer
end
