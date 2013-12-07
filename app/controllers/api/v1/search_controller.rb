class Api::V1::SearchController < Api::V1::BaseController
  def people
    render json: results.people
  end

  def resources
    render json: results.resources
  end

  private
  def results
    SearchResults.for(tags: search_params[:tag_ids])
  end

  def search_params
    params.permit(:tag_ids => [])
  end
end
