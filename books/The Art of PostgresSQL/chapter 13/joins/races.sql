-- Fetch race information along with the winning driver's surname.
-- 
-- We use a LEFT JOIN on the `result` table so that races without results
-- are still included in the output. The join condition explicitly restricts
-- the joined results to only position = 1 (the winner), preventing the need
-- to apply this filter in the WHERE clause.
--
-- This approach ensures that:
--   • Races with no results remain visible in the query output.
--   • Only the winner’s record (position = 1) is joined when available.
--   • Using the WHERE clause for this filter is avoided since it would
--     convert the LEFT JOIN into an effective INNER JOIN and exclude races
--     lacking results.
--
-- The final INNER JOIN (USING driverid) safely works because it only applies
-- when a matching winner exists, while still preserving races with no results.

select
    ra.date,
    ra.name,
    dr.surname
from race ra 
left join result re on ra.raceid = re.raceid and result.position = 1 
join driver dr using(driverid);