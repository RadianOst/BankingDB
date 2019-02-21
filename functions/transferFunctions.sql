CREATE OR REPLACE FUNCTION isClient(account_number VARCHAR) RETURNS BOOLEAN AS
$$
DECLARE
  output BOOLEAN;
BEGIN
  SELECT CASE
           WHEN EXISTS(SELECT number
                       FROM accounts
                       WHERE number LIKE account_number
             )
             THEN output = TRUE
           ELSE output = FALSE
           END;
  RETURN (output);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE setIsSenderToTrue(account_number VARCHAR) AS
$$
BEGIN
  IF (isClient(account_number))
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
$transfer_client_checker$
BEGIN
  EXECUTE setIsSenderToTrue(NEW.sender_number);
  EXECUTE setIsReceiverToTrue(NEW.receiver_number);
end;
$transfer_client_checker$ LANGUAGE plpgsql;


CREATE TRIGGER transfer_client_checker
  AFTER INSERT OR UPDATE
  ON banking.public.transfers
  FOR EACH ROW
EXECUTE PROCEDURE run_both_methods();

-- CREATE TRIGGER isSenderSetTrue
-- AFTER INSERT
-- ON transfers
-- FOR EACH ROW
--   WHEN(isClient(NEW.sender_number))
--   EXECUTE PROCEDURE setIsSenderToTrue(new.sender_number);
--
-- CREATE TRIGGER isReceiverSetTrue
-- AFTER INSERT
-- ON transfers
-- FOR EACH ROW
--   WHEN(isClient(new.receiver_number))
--   EXECUTE PROCEDURE setIsReceiverToTrue(new.sender_number);

select