CREATE OR REPLACE FUNCTION isClient(account_number VARCHAR) RETURNS BOOLEAN AS
$$
BEGIN
  CASE
     WHEN EXISTS(SELECT number
                 FROM accounts
                 WHERE accounts.number LIKE account_number
       )
       THEN RETURN TRUE;
     ELSE RETURN FALSE;
     END CASE;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE setIsSenderToTrue(account_number VARCHAR) AS
$$
BEGIN
  IF (SELECT isClient(account_number))
  THEN
    UPDATE transfers
    SET is_sender_client = TRUE
    WHERE transfers.sender_number LIKE account_number;
  END IF;
END ;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE setIsReceiverToTrue(account_number VARCHAR) AS
$$
BEGIN
  IF (isClient(account_number))
  THEN
    UPDATE transfers
    SET is_receiver_client = TRUE
    WHERE transfers.receiver_number LIKE account_number;
  END IF;
END ;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION run_both_methods()
  RETURNS TRIGGER AS
$transfers$
BEGIN
  CALL setIsSenderToTrue(NEW.sender_number);
  CALL setIsReceiverToTrue(NEW.receiver_number);
  RETURN new;
end;
$transfers$ LANGUAGE plpgsql;


CREATE TRIGGER transfer_client_checker
  AFTER INSERT OR UPDATE OF sender_number, receiver_number
  ON banking.public.transfers
  FOR EACH ROW
EXECUTE PROCEDURE run_both_methods();