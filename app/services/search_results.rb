class SearchResults
  attr_reader :tags

  def self.for(args = {})
    new(args)
  end

  def initialize(args = {})
    @tags = Array(args[:tags])
  end

  def resources
    results.where(taggable_type: 'Resource').map(&:taggable)
  end

  def people
    results.where(taggable_type: 'User').map(&:taggable)
  end

  private
  def results
    Tagging.where(tag_id: tags)
  end
end


# SearchResults.for(tags: [1,2,3]).people
#   => [user1, user2]

# SearchResults.for(tags: [1,2,3]).resources
#   => [resource1, resource2]
