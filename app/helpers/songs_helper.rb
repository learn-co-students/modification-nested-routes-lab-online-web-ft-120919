module SongsHelper

#  def artist_id_field(song)
#     if song.artist.nil? 
#         select_tag  "song[artist_id]", options_from_collection_for_select(Artist.all, :id, :name) 
#     else
#         hidden_field_tag "song[artist_id]", song.artist_id
#     end 
# end 

def artist_id_field(song)
    if song.artist
        song.artist.name 
    else 
        select_tag "song_artist_id", options_from_collection_for_select(Artist.all, :id, :name) 
    end 
end 

end 