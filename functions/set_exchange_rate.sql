CREATE OR REPLACE FUNCTION set_exchange_rate() RETURNS TRIGGER AS
$$
DECLARE
  c_value NUMERIC(12, 8);
BEGIN
  SELECT main_currency_value INTO STRICT c_value FROM currencies WHERE currencies.currency_id = new.currency_id;
  UPDATE transfers
  SET exchange_rate = c_value
  WHERE transfers.transfer_id = new.transfer_id;
  RETURN new;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_exchange_rate
  AFTER INSERT
  ON banking.public.transfers
  FOR EACH ROW
EXECUTE PROCEDURE set_exchange_rate();