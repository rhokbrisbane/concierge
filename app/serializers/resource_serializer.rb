class ResourceSerializer < ApplicationSerializer
  attributes :name, :category, :url, :phone, :facebook, :twitter, :address
  has_one :address, serializer: AddressSerializer
end
