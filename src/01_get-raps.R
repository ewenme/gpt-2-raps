source("src/00_requirements.R")

# set genius API token
genius_token()

# get song ids
song_ids <- scan(file = "inout/genius_song_ids.txt", character(), quote = "")

# get song lyrics
song_lyrics <- map(song_ids, scrape_lyrics_id)
song_meta <- map(song_ids, get_song_meta)

song_data <- map2(song_lyrics, song_meta, 
            ~ c(
              url = unique(.y$song_lyrics_url),
              track = unique(.x$song_name),
              artist = unique(.x$artist_name),
              lyrics = .x$line
            ))

# write to txt files
map2(song_data, song_ids, ~ write_lines(.x, path = paste0("output/" , .y, ".txt")))
