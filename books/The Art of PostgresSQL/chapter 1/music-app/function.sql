CREATE OR REPLACE FUNCTION get_all_albums(p_artistid INT)
RETURNS TABLE (
    albumid INT,
    album VARCHAR(255),
    duration INTERVAL,
    release_date DATE,
    track_count INT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        a.albumid,
        a.title AS album,
        a.duration,
        a.release_date,
        a.track_count
    FROM albums a
    WHERE a.artistid = p_artistid;
END;
$$ LANGUAGE plpgsql;