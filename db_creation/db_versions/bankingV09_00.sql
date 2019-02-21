ALTER TABLE transfers
  ALTER COLUMN exchange_rate TYPE NUMERIC(15, 8) USING exchange_rate::NUMERIC(15, 8);

ALTER SEQUENCE transfers_transfer_id_seq RESTART WITH 1;

UPDATE public.db_version
SET current_version = '09_00'
WHERE db_version.id = 1;

