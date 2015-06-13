class SavedSearchesController < ApplicationController
  load_and_authorize_resource except: [:create, :update]

  def index
    @saved_searches = current_user.saved_searches
  end

  def show
    authorize! :read, @saved_search
    @results = SimpleSearch.new(@saved_search.name).results
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

    respond_to do |format|
      if @saved_search.save
        format.html { redirect_to @saved_search }
        format.json { render json: @saved_search.to_json }
      else
        format.html { render action: :new }
        format.json { render json: { errors: @saved_search.errors.to_a } }
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
