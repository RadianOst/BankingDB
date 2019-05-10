ALTER TABLE accounts
  ADD balance DECIMAL(15, 2) DEFAULT 0 NOT NULL;

alter table credits
	add value DECIMAL(15,2) not null;

alter table credit_types rename column value to max_value;

UPDATE public.db_version
SET current_version = '07_00'
WHERE db_version.id = 1;