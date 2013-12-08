class SavedSearchesController < ApplicationController 
  before_action :set_saved_search, only: [:show, :edit, :update, :destroy]

  def show
    authorize! :read, @saved_search
  end

  def new
    authorize! :create, SavedSearch
  end

  def edit
    authorize! :manage, @saved_search
  end

  def create
    authorize! :create, SavedSearch

    @saved_search = current_user.saved_searches.new(saved_searches_params)

    respond_to do |format|
      format.html do
        if @saved_search.save
          redirect_to @saved_search, notice: "Your search has been saved."
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

  def set_saved_search
    @saved_search = SavedSearch.find(params[:id])
  end
end
