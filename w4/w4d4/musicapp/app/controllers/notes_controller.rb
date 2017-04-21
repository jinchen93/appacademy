class NotesController < ApplicationController

  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    @track = @note.track
    if @note.save
      redirect_to track_url(@track)
    else
      flash[:errors] = @note.errors.full_messages
      redirect_to track_url(@track)
    end
  end

  def destroy
    @note = Note.find(params[:id])
    if current_user.email == @note.user.email
      @track = @note.track
      @note.destroy
      redirect_to track_url(@track)
    else
      render text: "YOU ARE FORBIDDEN", status:403
    end
  end

  private

  def note_params
    params.require(:note).permit(:TEXT, :track_id )
  end
end
