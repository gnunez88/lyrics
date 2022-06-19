# Lyrics Downloader

This script attempts to download the lyrics of a song through an API.

### Why on Earth would anybody want to use this?

I came across an audio application, namely audacious, which has a plugin to download
the lyrics of the song currently playing.

It works quite well, however, I realised it was not able to retrieve some well-known
songs' lyrics.

This is because it tries to get them with:

```text
$URL_API/<Artists' names>/<Song name>
```

Nevertheless, the artists' names must not be in the expected order within the audio
file's metadata.
Or it might have some misspelling.

With this script you are able to retrieve the lyrics and save it in the format expected
for the application (`audacious`).

Note you may rename the directory or lyrics file, to match the expected file according
to the file's metadata.


