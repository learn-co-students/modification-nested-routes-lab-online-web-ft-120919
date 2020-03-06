class SongsController < ApplicationController
  def index
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      if @artist.nil?
        redirect_to artists_path, alert: "Artist not found"
      else
        @songs = @artist.songs
      end
    else
      @songs = Song.all
    end
  end

  def show
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      redirect_to songs_path, alert: 'Artist not found.' if @artist.nil?
      @song = @artist.songs.find_by(id: params[:id])
      redirect_to artist_songs_path(@artist), alert: "Song not found" if @song.nil?
    else
      @song = Song.find(params[:id])
      redirect_to songs_path, alert: 'Song not found' if @song.nil?
    end
  end

  def new
    if params[:artist_id] && !Artist.exists?(params[:artist_id])
      redirect_to artists_path, alert: 'Artist not found.'
    end
    @song = Song.new(artist_id: params[:artist_id])
  end

  def create
    #raise params.inspect
    @song = Song.new(song_params)

    @song.artist = Artist.find_by(:id => params[:artist_id]) if params[:artist_id]

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find_by(id: params[:id])
    if params[:artist_id]
      @artist = Artist.find_by id: params[:artist_id]
      redirect_to artists_path, alert: 'Artist not found.' if @artist.nil?
      redirect_to artist_songs_path, alert: 'Song not found.' if @song.nil?
    else
      redirect_to songs_path, alert: 'Song not found.' if @song.nil?
    end
  end

  def update
    raise params.inspect
    @song = Song.find_by(id: params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name, :artist_id)
  end
end
