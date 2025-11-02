-- Finds tracks named after other artists (musical tributes/homages)
-- Returns tracks where the track name matches an artist's name, 
-- but the track was created by a different artist
SELECT 
    a.name AS inspiration, 
    t.name AS track_name, 
    i.name AS artist_name 
FROM artist a
INNER JOIN track t ON t.name = a.name
INNER JOIN album alb USING(albumid) 
INNER JOIN artist i ON i.artistid = alb.artistid 
WHERE i.artistid <> a.artistid;