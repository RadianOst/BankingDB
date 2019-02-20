CREATE OR REPLACE FUNCTION isClient(account_number VARCHAR) RETURNS BOOLEAN AS $$
DECLARE
output BOOLEAN;
BEGIN
  SELECT CASE
    WHEN EXISTS( SELECT number
                  FROM accounts
                  WHERE number LIKE account_number
                )
    THEN output = TRUE
    ELSE output = FALSE
  END;
  RETURN(output);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE setIsSenderToTrue(account_number VARCHAR) AS $$
BEGIN
  UPDATE transfers
  SET is_sender_client = TRUE
  WHERE transfers.sender_number LIKE account_number;
END ;
$$LANGUAGE plpgsql ;


CREATE TRIGGER isSenderSetTrue
AFTER INSERT
ON transfers
FOR EACH ROW
  WHEN(isClient(new.sender_number))
  EXECUTE PROCEDURE setIsSenderToTrue(new.sender_number);

CREATE OR REPLACE PROCEDURE setIsReceiverToTrue(account_number VARCHAR) AS $$
BEGIN
  UPDATE transfers
  SET is_receiver_client = TRUE
  WHERE transfers.receiver_number LIKE account_number;
END ;
$$LANGUAGE plpgsql ;


CREATE TRIGGER isReceiverSetTrue
AFTER INSERT
ON transfers
FOR EACH ROW
  WHEN(isClient(new.receiver_number))
  EXECUTE PROCEDURE setIsReceiverToTrue(new.sender_number);