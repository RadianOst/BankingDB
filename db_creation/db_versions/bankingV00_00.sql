CREATE TABLE banking.public.address
(
  address_id  SERIAL NOT NULL
    CONSTRAINT address_pk
      PRIMARY KEY,
  street      VARCHAR(60),
  postal_code VARCHAR(6),
  city        VARCHAR(60)
);

ALTER TABLE banking.public.address
  OWNER TO admin;

CREATE TABLE banking.public.users
(
  user_id    SERIAL      NOT NULL
    CONSTRAINT users_pk
      PRIMARY KEY,
  name       VARCHAR(60) NOT NULL,
  surname    VARCHAR(60) NOT NULL,
  address_id INTEGER
    CONSTRAINT users_adresses_fk
      REFERENCES banking.public.address
      ON UPDATE CASCADE ON DELETE SET NULL,
  pesel      VARCHAR(11)
);

ALTER TABLE banking.public.users
  OWNER TO admin;

CREATE UNIQUE INDEX users_id_uindex
  ON banking.public.users (user_id);

CREATE UNIQUE INDEX users_pesel_uindex
  ON banking.public.users (pesel);

CREATE UNIQUE INDEX address_address_id_uindex
  ON banking.public.address (address_id);

CREATE TABLE banking.public.currencies
(
  currency_id         SERIAL         NOT NULL
    CONSTRAINT currencies_pk
      PRIMARY KEY,
  main_currency_value NUMERIC(12, 8) NOT NULL,
  symbol              VARCHAR(3),
  shortcut            VARCHAR(10)
);

ALTER TABLE banking.public.currencies
  OWNER TO admin;

CREATE TABLE banking.public.account_types
(
  account_type_id SERIAL       NOT NULL
    CONSTRAINT account_types_pk
      PRIMARY KEY,
  name            VARCHAR(100) NOT NULL,
  currency_id     INTEGER
    CONSTRAINT account_types_currencies_currency_id_fk
      REFERENCES banking.public.currencies
);

ALTER TABLE banking.public.account_types
  OWNER TO admin;

CREATE UNIQUE INDEX account_types_account_types_id_uindex
  ON banking.public.account_types (account_type_id);

CREATE TABLE banking.public.accounts
(
  account_id      SERIAL      NOT NULL
    CONSTRAINT accounts_pk
      PRIMARY KEY,
  account_type_id INTEGER
    CONSTRAINT accounts_account_type_fk
      REFERENCES banking.public.account_types,
  number          VARCHAR(30) NOT NULL,
  user_id         INTEGER
    CONSTRAINT accounts_users_users_fk
      REFERENCES banking.public.users
      ON UPDATE CASCADE ON DELETE SET NULL
);

ALTER TABLE banking.public.accounts
  OWNER TO admin;

CREATE UNIQUE INDEX accounts_account_id_uindex
  ON banking.public.accounts (account_id);

CREATE UNIQUE INDEX accounts_number_uindex
  ON banking.public.accounts (number);

CREATE UNIQUE INDEX currencies_currency_id_uindex
  ON banking.public.currencies (currency_id);

CREATE TABLE banking.public.credit_types
(
  credit_type_id     SERIAL            NOT NULL
    CONSTRAINT credit_types_pk
      PRIMARY KEY,
  name               VARCHAR(100),
  interest           NUMERIC(6, 2)     NOT NULL,
  instalments_number INTEGER           NOT NULL,
  interval           INTEGER DEFAULT 1 NOT NULL,
  currency_id        INTEGER
    CONSTRAINT credit_types_currencies_currency_id_fk
      REFERENCES banking.public.currencies,
  value              NUMERIC(20, 2)
);

ALTER TABLE banking.public.credit_types
  OWNER TO admin;

CREATE UNIQUE INDEX credit_types_credit_type_id_uindex
  ON banking.public.credit_types (credit_type_id);

CREATE TABLE banking.public.credits
(
  credit_id      SERIAL  NOT NULL
    CONSTRAINT credits_pk
      PRIMARY KEY,
  credit_type_id INTEGER NOT NULL
    CONSTRAINT credits_credit_types_credit_type_id_fk
      REFERENCES banking.public.credit_types,
  user_id        INTEGER NOT NULL
    CONSTRAINT credits_users_user_id_fk
      REFERENCES banking.public.users,
  start_date     DATE    NOT NULL
);

ALTER TABLE banking.public.credits
  OWNER TO admin;

CREATE UNIQUE INDEX credits_credit_id_uindex
  ON banking.public.credits (credit_id);

CREATE TABLE banking.public.investment_types
(
  investment_type_id        SERIAL NOT NULL
    CONSTRAINT investment_types_pk
      PRIMARY KEY,
  name                      VARCHAR(100),
  interest                  NUMERIC(6, 2),
  instalment_value          NUMERIC(8, 2),
  minimal_instalment_number INTEGER
);

ALTER TABLE banking.public.investment_types
  OWNER TO admin;

CREATE UNIQUE INDEX investment_types_investment_type_id_uindex
  ON banking.public.investment_types (investment_type_id);

CREATE TABLE banking.public.investments
(
  investment_id      SERIAL NOT NULL
    CONSTRAINT investments_pk
      PRIMARY KEY,
  investment_type_id INTEGER
    CONSTRAINT investments_investment_types_investment_type_id_fk
      REFERENCES banking.public.investment_types,
  user_id            INTEGER
    CONSTRAINT investments_users_user_id_fk
      REFERENCES banking.public.users,
  start_date         DATE   NOT NULL
);

ALTER TABLE banking.public.investments
  OWNER TO admin;

CREATE UNIQUE INDEX investments_investment_id_uindex
  ON banking.public.investments (investment_id);

CREATE TABLE banking.public.card_producers
(
  card_producer_id SERIAL      NOT NULL
    CONSTRAINT card_producers_pk
      PRIMARY KEY,
  name             VARCHAR(50) NOT NULL,
  security_length  INTEGER     NOT NULL
);

ALTER TABLE banking.public.card_producers
  OWNER TO admin;

CREATE UNIQUE INDEX card_producers_card_producer_id_uindex
  ON banking.public.card_producers (card_producer_id);

CREATE UNIQUE INDEX card_producers_name_uindex
  ON banking.public.card_producers (name);

CREATE TABLE banking.public.card_types
(
  card_type_id     SERIAL NOT NULL
    CONSTRAINT card_types_pk
      PRIMARY KEY,
  type_info        VARCHAR(200),
  card_producer_id INTEGER
    CONSTRAINT card_types_card_producers_card_producer_id_fk
      REFERENCES banking.public.card_producers
);

ALTER TABLE banking.public.card_types
  OWNER TO admin;

CREATE UNIQUE INDEX card_types_card_type_id_uindex
  ON banking.public.card_types (card_type_id);

CREATE TABLE banking.public.cards
(
  card_id         SERIAL     NOT NULL
    CONSTRAINT cards_pk
      PRIMARY KEY,
  card_type_id    INTEGER
    CONSTRAINT cards_card_types_card_type_id_fk
      REFERENCES banking.public.card_types,
  expiration_date DATE       NOT NULL,
  release_date    DATE       NOT NULL,
  security_code   VARCHAR(5) NOT NULL,
  user_id         INTEGER
    CONSTRAINT cards_users_user_id_fk
      REFERENCES banking.public.users,
  card_number     VARCHAR(30)
);

ALTER TABLE banking.public.cards
  OWNER TO admin;

CREATE TABLE banking.public.account_cards
(
  account_card_id SERIAL NOT NULL
    CONSTRAINT account_cards_pk
      PRIMARY KEY,
  account_id      INTEGER
    CONSTRAINT account_cards_accounts_account_id_fk
      REFERENCES banking.public.accounts,
  card_id         INTEGER
    CONSTRAINT account_cards_cards_card_id_fk
      REFERENCES banking.public.cards
);

ALTER TABLE banking.public.account_cards
  OWNER TO admin;

CREATE UNIQUE INDEX account_cards_account_card_id_uindex
  ON banking.public.account_cards (account_card_id);

CREATE UNIQUE INDEX cards_card_id_uindex
  ON banking.public.cards (card_id);

CREATE UNIQUE INDEX cards_card_number_uindex
  ON banking.public.cards (card_number);

CREATE TABLE banking.public.employees
(
  employee_id   SERIAL      NOT NULL
    CONSTRAINT employees_pk
      PRIMARY KEY,
  name          VARCHAR(60) NOT NULL,
  surname       VARCHAR(60) NOT NULL,
  basic_payment INTEGER
);

ALTER TABLE banking.public.employees
  OWNER TO admin;

CREATE TABLE banking.public.departments
(
  department_id SERIAL NOT NULL
    CONSTRAINT departments_pk
      PRIMARY KEY,
  name          VARCHAR(200),
  employee_id   INTEGER
    CONSTRAINT departments_employees_employee_id_fk
      REFERENCES banking.public.employees
);

ALTER TABLE banking.public.departments
  OWNER TO admin;

CREATE UNIQUE INDEX departments_department_id_uindex
  ON banking.public.departments (department_id);

CREATE UNIQUE INDEX employees_employee_id_uindex
  ON banking.public.employees (employee_id);

CREATE TABLE salary_history
(
  salary_history_id SERIAL                    NOT NULL
    CONSTRAINT salary_history_pk
      PRIMARY KEY,
  date              DATE DEFAULT CURRENT_DATE NOT NULL,
  employee_id       INTEGER
    CONSTRAINT salary_history_employees_employee_id_fk
      REFERENCES banking.public.employees,
  amount            NUMERIC(10, 2)            NOT NULL,
  currency_id       INTEGER
    CONSTRAINT salary_history_currencies_currency_id_fk
      REFERENCES banking.public.currencies
);

ALTER TABLE banking.public.salary_history
  OWNER TO admin;

CREATE UNIQUE INDEX salary_history_salary_history_id_uindex
  ON banking.public.salary_history (salary_history_id);

CREATE TABLE banking.public.transfers
(
  transfer_id        SERIAL                       NOT NULL
    CONSTRAINT transfers_pk
      PRIMARY KEY,
  value              NUMERIC(15, 2)               NOT NULL,
  currency_id        INTEGER
    CONSTRAINT transfers_currencies_currency_id_fk
      REFERENCES banking.public.currencies,
  date               DATE    DEFAULT CURRENT_DATE NOT NULL,
  exchange_rate      NUMERIC(15, 6)               NOT NULL,
  sender_number      VARCHAR(30)                  NOT NULL,
  receiver_number    VARCHAR(30)                  NOT NULL,
  is_sender_client   BOOLEAN DEFAULT FALSE,
  is_receiver_client BOOLEAN DEFAULT FALSE
);

ALTER TABLE banking.public.transfers
  OWNER TO admin;

CREATE UNIQUE INDEX transfers_transfer_id_uindex
  ON banking.public.transfers (transfer_id);

