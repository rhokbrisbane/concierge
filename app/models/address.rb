class Address < ActiveRecord::Base
  belongs_to :user
  belongs_to :addressable, polymorphic: true

  validates :street1, :suburb, :state, :country, :addressable, presence: true

  after_create :find_coordinates

  def to_s
    [street1, street2, suburb, state, country].compact.join(', ')
  end

  private

  def find_coordinates
    longitude, latitude = Geocoder.coordinates(self.to_s).reverse
    update_attributes(longitude: longitude, latitude: latitude)
  end
end
