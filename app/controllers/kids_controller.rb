class KidsController < ApplicationController
  before_action :set_kid, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
  end

  def create
    @kid = Kid.new(kid_params)

    respond_to do |format|
      format.html do
        if @kid.save
          redirect_to @kid, notice: "#{ @kid.name }'s details have been saved."
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

  def create
    respond_to do |format|
      format.html do
        if @kid.update(kid_params)
          redirect_to @kid, notice: "#{ @kid.name }'s details have been saved."
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
