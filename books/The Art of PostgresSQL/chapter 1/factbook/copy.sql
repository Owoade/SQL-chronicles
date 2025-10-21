-- `\COPY` runs on the client side as oppose to `COPY` which runs on the server
\copy factbook(year, date, shares, trades, dollars) 
    FROM '/Users/owoade/Desktop/growth/SQL chronicles/books/The Art of PostgresSQL/chapter 1/factbook/factbook.csv' 
    DELIMITER ',' CSV HEADER;