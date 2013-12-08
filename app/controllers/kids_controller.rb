class KidsController < ApplicationController
  def create
    @kid = Kid.new(kid_params)

    if @kid.save
      redirect_to @kid, notice: 'Note was successfully created.'
    else
      render action: 'new'
    end
  end

  private
  def kid_params
    params.require(:kid).permit(:name, :tags)
  end
end
