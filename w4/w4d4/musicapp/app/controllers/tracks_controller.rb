class TracksController < ApplicationController
  before_action :require_logged_in
  helper_method :all_albums


  def new
    @album = Album.find(params[:album_id])
    render :new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to track_url(@track)
    else
      flash[:errors] = @track.errors.full_messages
      redirect_to new_album_track_url
    end
  end

  def edit
    @track = Track.find(params[:id])
    render :edit
  end

  def update
    @track = Track.find(params[:id])
    if @track.update_attributes(track_params)
      redirect_to track_url(@track)
    else
      flash[:errors] = ["Invalid parameters"]
      redirect_to edit_track_url
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @album = @track.album
    if @track.destroy
      redirect_to album_url(@album)
    end
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def all_albums
    Album.all
  end

  private

  def track_params
    params.require(:track).permit(:album_id, :name, :category, :lyrics)
  end

end
