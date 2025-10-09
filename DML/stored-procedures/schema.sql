CREATE TABLE IF NOT EXISTS public.wallet
(
    id SERIAL PRIMARY KEY
    user_id integer NOT NULL,
    balance numeric(10,2) DEFAULT 0,
)

CREATE TABLE IF NOT EXISTS public.wallet_trx
(
    id SERIAL PRIMARY KEY
    wallet_id integer NOT NULL,
    amount numeric(10,2),
    "time" timestamp without time zone DEFAULT now(),
)
