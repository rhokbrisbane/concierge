class ResourceSerializer < ApplicationSerializer
  attributes :id, :name, :category, :url, :phone, :facebook, :twitter, :address

  has_one :address, serializer: AddressSerializer
end
