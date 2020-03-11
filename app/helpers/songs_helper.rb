module SongsHelper
    def artist_select(song)
        if song.artist.nil? || Song.exists?(song)
            select_tag "song[artist_id]", options_from_collection_for_select(Artist.all, :id, :name)
        else
            hidden_field "song[artist_id]", song.artist_id
        end
    end
end
