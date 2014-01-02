class Address < ActiveRecord::Base
  validates :addressable, presence: true

  belongs_to :addressable, polymorphic: true

  after_validation :geocode, if: :location_changed?

  geocoded_by :to_s

  def to_s
    [street1, street2, suburb, state, country].compact.join(', ')
  end

  def coordinates
    [latitude, longitude]
  end

  def coordinates?
    coordinates.join.present?
  end

  def location_changed?
    if persisted?
      (changed & %w(street1 street2 suburb state country)).any?
    else
      !coordinates?
    end
  end
end
