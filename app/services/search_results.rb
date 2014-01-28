class SearchResults
  attr_reader :tag_ids, :ability

  def self.for(args = {})
    new(args)
  end

  def initialize(args = {})
    @tag_ids = Array(args[:tag_ids])
    @ability = args[:ability] || Ability.new
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
    Tagging.where(tag_id: tag_ids)
  end

  def taggable_type(type)
    type ? taggings.where(taggable_type: type) : taggings
  end

  def results(type = nil)
    taggable_type(type).map(&:taggable).reject do |taggable|
      missing_required_tags(taggable) || ability.cannot?(:read, taggable) || private?(taggable)
    end
  end

  def private?(taggable)
    taggable.respond_to?(:public?) && !taggable.public?
  end

  def missing_required_tags(taggable)
    Tagging.where(taggable: taggable, required: true)
           .where.not(tag_id: tag_ids).any?
  end
end
