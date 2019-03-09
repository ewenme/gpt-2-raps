source("src/00_requirements.R")

# set genius API token
genius_token()

# get song ids
song_ids <- scan(file = "data/genius_song_ids.txt", character(), quote = "")

# get song lyrics
song_lyrics <- map(song_ids, scrape_lyrics_id)

song_lyrics_list <- map(song_lyrics, function(x){
  
  list(
    artist = unique(x$artist_name),
    track = unique(x$song_name),
    lyrics = x$line
  )
  
})

# write to JSON
write_json(song_lyrics_list, "data/lyrics.json")
