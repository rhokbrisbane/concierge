class SimpleSearch
  attr_accessor :query
  def initialize(query)
    @query = query
  end

  def results
    ActiveRecord::Base.transaction do
      OpenStruct.new(
        resources: resources,
        pages:     pages
      )
    end
  end

  def resources
    resource_sql = %w(name url facebook twitter description).map { |field|
      "#{field} ilike :q"
    }.join(" or ")
    Resource.where(resource_sql, q: "%#{query}%").includes(:address)
  end

  def pages
    Page.where("title ilike :q", q: "%#{query}%")
  end
end
