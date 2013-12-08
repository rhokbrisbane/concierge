class SearchResults
  attr_reader :tags

  def self.for(args = {})
    new(args)
  end

  def initialize(args = {})
    @tags = Array(args[:tags])
    @location = args[:location].presence
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
    # @results = tag_results(type) | 
    location_results(type)
    # @results.compact!
    # @results.uniq!
  end

  def tag_results(type)
    taggable_type(type).map(&:taggable).reject(&method(:missing_required_tags))
  end

  def location_results(type)
    if coordinates
      scope = Address.near(@coordinates, 10, units: :km).includes(:addressable)
      scope = scope.where(addressabe_type: type) if type
      scope.map &:addressable
    end
  end

  def missing_required_tags(taggable)
    Tagging.where(taggable: taggable, required: true)
           .where.not(tag_id: @tags).any?
  end

  def coordinates
    @coordinates ||= Geocoder.coordinates(@location) if @location
  end
end
