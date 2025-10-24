SELECT album, duration
FROM artist,
LATERAL get_all_albums(artist.artistid) AS albums
WHERE artist.name = 'Red Hot Chili Peppers';