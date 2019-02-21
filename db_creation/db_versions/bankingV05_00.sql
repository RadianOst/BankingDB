ALTER TABLE currencies
  ALTER COLUMN name TYPE VARCHAR(22) USING name::VARCHAR(22);

ALTER TABLE cards
  ALTER COLUMN card_type_id SET NOT NULL;

ALTER TABLE cards
  RENAME COLUMN user_id TO account_id;

ALTER TABLE cards
  ALTER COLUMN account_id SET NOT NULL;

ALTER TABLE cards
  ALTER COLUMN card_number TYPE VARCHAR(19) USING card_number::VARCHAR(19);

ALTER TABLE cards
  ALTER COLUMN card_number SET NOT NULL;

ALTER TABLE cards
  DROP COLUMN release_date;

ALTER TABLE cards
  DROP CONSTRAINT cards_users_user_id_fk;

ALTER TABLE cards
  ADD CONSTRAINT cards_accounts_account_id_fk
    FOREIGN KEY (account_id) REFERENCES accounts;

UPDATE public.db_version
SET current_version = '5_00'
WHERE id = 1;