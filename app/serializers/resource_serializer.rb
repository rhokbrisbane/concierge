class ResourceSerializer < ApplicationSerializer
  attributes :id, :name, :category, :url, :phone, :facebook, :twitter, :address, :total_of_comments

  has_one :address, serializer: AddressSerializer

  has_many :comments, embed: :objects

  private

  def category
    object.resource_category.name
  end

  def total_of_comments
    object.comments.count
  end
end
