class Api::V1::SearchController < Api::V1::BaseController
  def people
    @_authorized = true if results.people.empty?
    results.people.each { |person| authorize! :read, person }

    render json: results.people
  end

  def resources
    @_authorized = true if results.resources.empty?
    results.resources.each { |resource| authorize! :read, resource }

    render json: results.resources
  end

  private
  def results
    SearchResults.for(tags: search_params[:tag_ids], ability: current_ability)
  end

  def search_params
    params.permit(:tag_ids => [])
  end
end
