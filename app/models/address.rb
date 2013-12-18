class Address < ActiveRecord::Base
  belongs_to :user
  belongs_to :addressable, polymorphic: true

  geocoded_by :to_s
  validates :street1, :suburb, :state, :country, :addressable, presence: true
  after_validation :geocode, if: :location_changed?

  def to_s
    [street1, street2, suburb, state, country].compact.join(', ')
  end

  def coordinates
    [latitude, longitude]
  end

  def coordinates?
    latitude.present? && longitude.present?
  end

  def location_changed?
    if persisted?
      (changed & %w(street1 street2 suburb state country)).any?
    else
      latitude.blank? && longitude.blank?
    end
  end
end
