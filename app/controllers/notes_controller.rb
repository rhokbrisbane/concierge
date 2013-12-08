class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  def index
    @notes = Note.all
  end

  def show
  end

  def new
    @note = Note.new
  end

  def edit
  end

  def create
    @note = current_user.notes.new(note_params)

    if @note.save
      redirect_to @note, notice: 'Note was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @note.update(note_params)
      redirect_to @note, notice: 'Note was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @note.destroy
    redirect_to notes_url, notice: 'Note was successfully destroyed.'
  end

  private

  def set_note
    @note = current_user.notes.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:title, :content)
  end
end
