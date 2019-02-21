DROP FUNCTION main_currency_change(currency_id INTEGER);
CREATE OR REPLACE FUNCTION main_currency_change(id INTEGER) RETURNS VOID AS
$$
DECLARE
  m_value NUMERIC(12, 8); -- main_currency_value
  o_value NUMERIC(12, 8); -- old_currency_value
  n_value NUMERIC(12, 8); -- new_currency_value
BEGIN
  SELECT main_currency_value INTO m_value FROM currencies WHERE currencies.currency_id = id;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE EXCEPTION 'currency id = % not found', id;
  WHEN TOO_MANY_ROWS THEN
    RAISE EXCEPTION 'currency id = % not unique', id;
    END;
BEGIN 
UPDATE currencies SET main_currency_value = main_currency_value / m_value;
END;
$$
  LANGUAGE PLPGSQL;