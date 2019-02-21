ALTER TABLE accounts
  ADD balance DECIMAL(15, 2) DEFAULT 0 NOT NULL;

UPDATE public.db_version
SET current_version = '07_00'
WHERE db_version.id = 1;