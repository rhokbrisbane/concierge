class SearchesController < ApplicationController
  before_action :set_search, only: [:show, :edit, :update, :destroy]

  # GET /searches
  def index
    @searches = Search.all
  end

  # GET /searches/1
  def show
  end

  # GET /searches/new
  def new
    @search = Search.new
    @tags_by_category = Tag.all.group_by { |tag| tag.category }
  end

  # GET /searches/1/edit
  def edit
  end

  # POST /searches
  def create
    @search = Search.new(search_params)

    if @search.save
      redirect_to @search, notice: 'Search was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /searches/1
  def update
    if @search.update(search_params)
      redirect_to @search, notice: 'Search was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /searches/1
  def destroy
    @search.destroy
    redirect_to searches_url, notice: 'Search was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_search
      @search = Search.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def search_params
      params[:search]
    end
end
