class UserSerializer < ApplicationSerializer
  attributes :id, :name, :email, :address, :total_of_comments

  has_one :address, serializer: AddressSerializer

  private

  def total_of_comments
    object.comments.count
  end
end
