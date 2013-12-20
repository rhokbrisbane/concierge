class PagesController < ApplicationController
  load_and_authorize_resource

  def index
    @pages = Page.all
  end

  def show
  end

  def new
    @page = page.new
  end

  def create
    @page = Page.new page_params

    if @page.save
      redirect_to @page, notice: 'page was successfully created.'
    else
      flash.now[:alert] = @page.errors.full_messages.join(', ')
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @page.update(page_params)
      redirect_to @page, notice: 'page was successfully updated.'
    else
      flash.now[:alert] = @page.errors.full_messages.join(', ')
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
