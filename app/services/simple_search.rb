class SimpleSearch
  attr_accessor :query
  def initialize(query)
    @query = query
  end

  def results
    OpenStruct.new(
      resources: resources,
      people: []
    )
  end

  def resources
    resource_sql = %w(name url facebook twitter description).map { |field|
      "#{field} like :q"
    }.join(" or ")
    Resource.where(resource_sql, q: "%#{query}%")
  end
end
