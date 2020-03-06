module ArtistsHelper
  def display_artist(song)
    song.artist.nil? ? link_to("Add Artist", edit_song_path(song)) : link_to(song.artist_name, artist_path(song.artist))
  end

  def artist_select(song)
    if song.artist
      # hidden field with artist_id
      hidden_field_tag :artist_id, song.artist.id
    else
      # enter artist name with field
      #text_field_tag 'artist[name]'
      select_tag 'song[artist_id]', options_from_collection_for_select(Artist.all, :id, :name, include_blank: true)
    end
  end
end
