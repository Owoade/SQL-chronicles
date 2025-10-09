CREATE OR REPLACE PROCEDURE update_wallet (
	var_amount decimal(10,2),
	var_wallet_id int
)
LANGUAGE plpgsql
AS $$
DECLARE 
	current_balance decimal(10,2);

BEGIN 
	SELECT COALESCE(balance, 0) INTO current_balance
    FROM wallet 
    WHERE id = var_wallet_id;
	
	IF (current_balance + var_amount) < 0 THEN
		RAISE 'Insufficient balance for wallet: %', var_wallet_id;
	END IF;
	
	UPDATE wallet SET balance = var_amount + balance WHERE id = var_wallet_id;
	INSERT INTO wallet_trx (amount, wallet_id) VALUES (var_amount, var_wallet_id);
END;
$$;

CALL update_wallet(200, 1);