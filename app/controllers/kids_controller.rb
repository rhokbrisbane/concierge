class KidsController < ApplicationController
  def new
    @tags_by_category = Tag.all.group_by(&:category)
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
        render json: @kid.to_json 
      end
    end
  end

  private
  def kid_params
    params.require(:kid).permit(:name, :guardian_ids, tag_ids: [])
  end
end
