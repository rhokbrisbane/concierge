class SearchResults
  attr_reader :tags, :ability, :location, :location_range

  def self.for(args = {})
    new(args)
  end

  def initialize(args = {})
    @tags           = Array(args[:tags])
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
    taggable_type(type).group_by(&:taggable).reject do |taggable,tags|
      missing_required_tags(taggable) || ability.cannot?(:read, taggable)
    end.keys
  end

  def missing_required_tags(taggable)
    Tagging.where(taggable: taggable, required: true)
           .where.not(tag_id: tags).any?
  end
end
