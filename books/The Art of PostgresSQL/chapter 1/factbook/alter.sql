ALTER TABLE factbook
    ALTER shares TYPE bigint USING replace(shares, ',', '')::numeric,
    ALTER trades TYPE bigint USING replace(trades, ',', '')::numeric,
    ALTER dollars TYPE bigint USING substring(replace(dollars, ',', '') from 2)::numeric;



