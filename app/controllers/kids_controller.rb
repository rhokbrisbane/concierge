class KidsController < ApplicationController
  before_action :set_kid, only: [:show, :edit, :update, :destroy]

  def show
    authorize! :read, @kid
    @results = SearchResults.for(tag_ids: @kid.tag_ids, ability: current_ability)
  end

  def new
    @kid = Kid.new
    authorize! :create, Kid
  end

  def create
    authorize! :create, Kid
    @kid = Kid.new(kid_params)

    respond_to do |format|
      format.html do
        if @kid.save
          @kid.guardians << current_user
          redirect_to @kid, notice: "#{@kid.name}'s details have been saved."
        else
          render action: 'new'
        end
      end

      format.json do
        @kid.save
        render json: @kid.to_json
      end
    end
  end

  def edit
    authorize! :manage, @kid
  end

  def update
    authorize! :manage, @kid
    respond_to do |format|
      format.html do
        if @kid.update(kid_params)
          redirect_to @kid, notice: "#{@kid.name}'s details have been saved."
        else
          render action: 'new'
        end
      end

      format.json do
        @kid.update(kid_params)
        render json: @kid.to_json
      end
    end
  end

  private

  def kid_params
    params.require(:kid).permit(:name, :guardian_ids, tag_ids: [])
  end

  def set_kid
    @kid = Kid.find(params[:id])
  end
end
