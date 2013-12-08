class Address < ActiveRecord::Base
  belongs_to :addressable, polymorphic: true

  geocoded_by :to_s
  validates :street1, :suburb, :state, :country, :addressable, presence: true
  after_validation :geocode

  def to_s
    [street1, street2, suburb, state, country].compact.join(', ')
  end
end
