SELECT 
  g.name AS genre_name,
  pt.track_name,
  a.name,                        
  pt.count                                            
FROM genre g
LEFT JOIN LATERAL (
  SELECT                  
    t.name AS track_name,  
    COUNT(*) AS count, t.albumid 
  FROM playlisttrack plt
  LEFT JOIN track t USING(trackid)
  WHERE t.genreid = g.genreid
  GROUP BY t.trackid, t.name
  ORDER BY count DESC
  LIMIT :n                
) pt ON true
JOIN album al USING(albumid)
JOIN artist a USING(artistid)
ORDER BY g.name, pt.count DESC;


-- Alternative with better formatting
SELECT 
    genre.name AS genre,
    CASE 
        WHEN length(ss.name) > 15
        THEN substring(ss.name FROM 1 FOR 15) || '...'
        ELSE ss.name
    END AS track,
    artist.name AS artist,
    ss.count count
FROM genre
LEFT JOIN LATERAL (
    SELECT 
        track.name, 
        track.albumid, 
        COUNT(playlistid)
    FROM track
    LEFT JOIN playlisttrack USING (trackid)
    WHERE track.genreid = genre.genreid
    GROUP BY track.trackid
    ORDER BY COUNT DESC
    LIMIT :n
) ss(name, albumid, count) ON true
JOIN album USING(albumid)
JOIN artist USING(artistid)
ORDER BY genre.name, ss.count DESC;