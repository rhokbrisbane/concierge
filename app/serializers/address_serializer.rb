class AddressSerializer < ApplicationSerializer
  attributes :suburb,
             :postcode,
             :street1,
             :street2,
             :state,
             :country,
             :latitude,
             :longitude,
             :coordinates,
             :coordinates?,
             :to_s
end
