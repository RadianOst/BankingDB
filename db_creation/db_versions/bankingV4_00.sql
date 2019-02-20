ALTER TABLE currencies
  ADD name VARCHAR(20) NOT NULL;

CREATE UNIQUE INDEX currencies_name_uindex
  ON currencies (name);

CREATE UNIQUE INDEX currencies_symbol_uindex
  ON currencies (symbol);

