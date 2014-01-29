class SavedSearchesController < ApplicationController
  load_and_authorize_resource except: [:create, :update]

  def index
    @saved_searches = current_user.saved_searches
  end

  def show
    authorize! :read, @saved_search
    @results = SearchResults.for(tag_ids: @saved_search.tag_ids,
      ability: current_ability
    )
  end

  def new
    authorize! :create, SavedSearch
    @saved_search = SavedSearch.new
  end

  def edit
    authorize! :manage, @saved_search
  end

  def create
    authorize! :create, SavedSearch

    @saved_search = current_user.saved_searches.new(saved_searches_params)
    @saved_search.name = Time.now.to_s(:time_with_date)

    respond_to do |format|
      format.html do
        if @saved_search.save
          redirect_to @saved_search
        else
          render action: 'new'
        end
      end

      format.json do
        @saved_search.save
        render json: @saved_search.to_json
      end
    end
  end

  def update
    @saved_search = SavedSearch.find(params[:id])
    authorize! :manage, @saved_search

    respond_to do |format|
      format.html do
        if @saved_search.update(saved_searches_params)
          redirect_to @saved_search, notice: "Your search has been saved."
        else
          render action: 'new'
        end
      end

      format.json do
        @saved_search.update(saved_searches_params)
        render json: @saved_search.to_json
      end
    end
  end

  private
  def saved_searches_params
    params.require(:saved_search).permit(:name, tag_ids: [])
  end
end
