class PagesController < ApplicationController
  load_and_authorize_resource

  skip_before_filter :authenticate_user!,  only: [:show]
  skip_before_filter :check_authorization, only: [:show]

  def index
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new
  end

  def landing
  end

  def create
    @page = Page.new page_params

    if @page.save
      redirect_to @page, notice: 'Page was successfully created.'
    else
      flash.now[:alert] = @page.errors.full_messages.to_sentence
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @page.update(page_params)
      redirect_to @page, notice: 'Page was successfully updated.'
    else
      flash.now[:alert] = @page.errors.full_messages.to_sentence
      render action: 'edit'
    end
  end

  def destroy
    @page.destroy
    redirect_to pages_url, notice: 'page was successfully destroyed.'
  end

  def add_tag
    tag = Tag.find params[:tag_id]
    @page.tags << tag
    head :no_content
  end

  def remove_tag
    @page.tags.find(params[:tag_id]).destroy
  end

  private

  def page_params
    params.require(:page).permit(:title, :content, :sort)
  end
end
