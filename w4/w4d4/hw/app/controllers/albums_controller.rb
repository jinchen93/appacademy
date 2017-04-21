class AlbumsController < ApplicationController
  before_action :require_logged_in

  def new
    @band = Band.find(params[:band_id])
    @all_bands = Band.all
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album)
    else
      flash[:errors] = @album.errors.full_messages
      redirect_to new_band_album_url(@album)
    end
  end

  def edit
    @band = Band.find(params[:band_id])
    @all_bands = Band.all
    @album = Album.find(params[:id])
    render :edit
  end

  def update
    @album = Album.find(params[:id])
    if @album.update_attributes(album_params)
      redirect_to album_url(@album)
    else
      flash[:errors] = ["Invalid parameters"]
      redirect_to edit_album_url(@album)
    end
  end

  def show
    @album = Album.find(params[:id])
    @tracks = @album.tracks
    render :show
  end

  def destroy
    @album = Album.find(params[:id])
    @band = @album.band
    if @album.destroy
      redirect_to band_url(@band)
    end
  end

  private

  def album_params
    params.require(:album).permit(:name, :band_id, :category)
  end

end
