ALTER TABLE currencies
  ALTER COLUMN symbol TYPE CHAR(3) USING symbol::CHAR(3);

ALTER TABLE currencies
  ALTER COLUMN symbol SET NOT NULL;

ALTER TABLE currencies
  ADD quantity INT DEFAULT 1 NOT NULL;

ALTER TABLE currencies
  DROP COLUMN shortcut;

