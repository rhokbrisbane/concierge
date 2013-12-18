class SearchResults
  attr_reader :tags, :ability, :location, :location_range

  def self.for(args = {})
    new(args)
  end

  def initialize(args = {})
    @tags           = Array(args[:tags])
    @location       = args[:location].presence
    @location_range = args[:location_range].presence
    @ability        = args[:ability] || Ability.new(User.new)
  end

  def all
    results
  end

  def resources
    results(Resource)
  end

  def people
    results(User)
  end

  private

  def taggings
    Tagging.where(tag_id: tags)
  end

  def taggable_type(type)
    type ? taggings.where(taggable_type: type) : taggings
  end

  def results(type = nil)
    tag_results = tag_results(type)
    location_results = location_results(type)
    (tag_results.to_a.concat location_results.to_a).compact.uniq
  end

  def tag_results(type)
    taggable_type(type).group_by(&:taggable).reject do |taggable,tags|
      missing_required_tags(taggable) || ability.cannot?(:read, taggable)
    end.keys
  end

  def location_results(type)
    if coordinates
      scope = Address.near(coordinates, location_range_in_km, units: :km).includes(:addressable)
      scope = scope.where(addressable_type: type) if type
      scope.map(&:addressable)
    end
  end

  def missing_required_tags(taggable)
    Tagging.where(taggable: taggable, required: true)
           .where.not(tag_id: tags).any?
  end

  def coordinates
    if location && location_range.to_i.nonzero?
      @coordinates ||= Geocoder.coordinates(location)
    end
  end

  def location_range_in_km
    location_range / 1_000.0
  end
end
