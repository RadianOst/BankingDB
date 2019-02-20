
create table banking.public.address
(
	address_id serial not null
		constraint address_pk
			primary key,
	street varchar(60),
	postal_code varchar(6),
	city varchar(60)
);

alter table banking.public.address owner to admin;

create table banking.public.users
(
	user_id serial not null
		constraint users_pk
			primary key,
	name varchar(60) not null,
	surname varchar(60) not null,
	address_id integer
		constraint users_adresses_fk
			references banking.public.address
				on update cascade on delete set null,
	pesel varchar(11)
);

alter table banking.public.users owner to admin;

create unique index users_id_uindex
	on banking.public.users (user_id);

create unique index users_pesel_uindex
	on banking.public.users (pesel);

create unique index address_address_id_uindex
	on banking.public.address (address_id);

create table banking.public.currencies
(
	currency_id serial not null
		constraint currencies_pk
			primary key,
	main_currency_value numeric(12,8) not null,
	symbol varchar(3),
	shortcut varchar(10)
);

alter table banking.public.currencies owner to admin;

create table banking.public.account_types
(
	account_type_id serial not null
		constraint account_types_pk
			primary key,
	name varchar(100) not null,
	currency_id integer
		constraint account_types_currencies_currency_id_fk
			references banking.public.currencies
);

alter table banking.public.account_types owner to admin;

create unique index account_types_account_types_id_uindex
	on banking.public.account_types (account_type_id);

create table banking.public.accounts
(
	account_id serial not null
		constraint accounts_pk
			primary key,
	account_type_id integer
		constraint accounts_account_type_fk
			references banking.public.account_types,
	number varchar(30) not null,
	user_id integer
		constraint accounts_users_users_fk
			references banking.public.users
				on update cascade on delete set null
);

alter table banking.public.accounts owner to admin;

create unique index accounts_account_id_uindex
	on banking.public.accounts (account_id);

create unique index accounts_number_uindex
	on banking.public.accounts (number);

create unique index currencies_currency_id_uindex
	on banking.public.currencies (currency_id);

create table banking.public.credit_types
(
	credit_type_id serial not null
		constraint credit_types_pk
			primary key,
	name varchar(100),
	interest numeric(6,2) not null,
	instalments_number integer not null,
	interval integer default 1 not null,
	currency_id integer
		constraint credit_types_currencies_currency_id_fk
			references banking.public.currencies,
	value numeric(20,2)
);

alter table banking.public.credit_types owner to admin;

create unique index credit_types_credit_type_id_uindex
	on banking.public.credit_types (credit_type_id);

create table banking.public.credits
(
	credit_id serial not null
		constraint credits_pk
			primary key,
	credit_type_id integer not null
		constraint credits_credit_types_credit_type_id_fk
			references banking.public.credit_types,
	user_id integer not null
		constraint credits_users_user_id_fk
			references banking.public.users,
	start_date date not null
);

alter table banking.public.credits owner to admin;

create unique index credits_credit_id_uindex
	on banking.public.credits (credit_id);

create table banking.public.investment_types
(
	investment_type_id serial not null
		constraint investment_types_pk
			primary key,
	name varchar(100),
	interest numeric(6,2),
	instalment_value numeric(8,2),
	minimal_instalment_number integer
);

alter table banking.public.investment_types owner to admin;

create unique index investment_types_investment_type_id_uindex
	on banking.public.investment_types (investment_type_id);

create table banking.public.investments
(
	investment_id serial not null
		constraint investments_pk
			primary key,
	investment_type_id integer
		constraint investments_investment_types_investment_type_id_fk
			references banking.public.investment_types,
	user_id integer
		constraint investments_users_user_id_fk
			references banking.public.users,
	start_date date not null
);

alter table banking.public.investments owner to admin;

create unique index investments_investment_id_uindex
	on banking.public.investments (investment_id);

create table banking.public.card_producers
(
	card_producer_id serial not null
		constraint card_producers_pk
			primary key,
	name varchar(50) not null,
	security_length integer not null
);

alter table banking.public.card_producers owner to admin;

create unique index card_producers_card_producer_id_uindex
	on banking.public.card_producers (card_producer_id);

create unique index card_producers_name_uindex
	on banking.public.card_producers (name);

create table banking.public.card_types
(
	card_type_id serial not null
		constraint card_types_pk
			primary key,
	type_info varchar(200),
	card_producer_id integer
		constraint card_types_card_producers_card_producer_id_fk
			references banking.public.card_producers
);

alter table banking.public.card_types owner to admin;

create unique index card_types_card_type_id_uindex
	on banking.public.card_types (card_type_id);

create table banking.public.cards
(
	card_id serial not null
		constraint cards_pk
			primary key,
	card_type_id integer
		constraint cards_card_types_card_type_id_fk
			references banking.public.card_types,
	expiration_date date not null,
	release_date date not null,
	security_code varchar(5) not null,
	user_id integer
		constraint cards_users_user_id_fk
			references banking.public.users,
	card_number varchar(30)
);

alter table banking.public.cards owner to admin;

create table banking.public.account_cards
(
	account_card_id serial not null
		constraint account_cards_pk
			primary key,
	account_id integer
		constraint account_cards_accounts_account_id_fk
			references banking.public.accounts,
	card_id integer
		constraint account_cards_cards_card_id_fk
			references banking.public.cards
);

alter table banking.public.account_cards owner to admin;

create unique index account_cards_account_card_id_uindex
	on banking.public.account_cards (account_card_id);

create unique index cards_card_id_uindex
	on banking.public.cards (card_id);

create unique index cards_card_number_uindex
	on banking.public.cards (card_number);

create table banking.public.employees
(
	employee_id serial not null
		constraint employees_pk
			primary key,
	name varchar(60) not null,
	surname varchar(60) not null,
	basic_payment integer
);

alter table banking.public.employees owner to admin;

create table banking.public.departments
(
	department_id serial not null
		constraint departments_pk
			primary key,
	name varchar(200),
	employee_id integer
		constraint departments_employees_employee_id_fk
			references banking.public.employees
);

alter table banking.public.departments owner to admin;

create unique index departments_department_id_uindex
	on banking.public.departments (department_id);

create unique index employees_employee_id_uindex
	on banking.public.employees (employee_id);

create table salary_history
(
	salary_history_id serial not null
		constraint salary_history_pk
			primary key,
	date date default CURRENT_DATE not null,
	employee_id integer
		constraint salary_history_employees_employee_id_fk
			references banking.public.employees,
	amount numeric(10,2) not null,
	currency_id integer
		constraint salary_history_currencies_currency_id_fk
			references banking.public.currencies
);

alter table banking.public.salary_history owner to admin;

create unique index salary_history_salary_history_id_uindex
	on banking.public.salary_history (salary_history_id);

create table banking.public.transfers
(
	transfer_id serial not null
		constraint transfers_pk
			primary key,
	value numeric(15,2) not null,
	currency_id integer
		constraint transfers_currencies_currency_id_fk
			references banking.public.currencies,
	date date default CURRENT_DATE not null,
	exchange_rate numeric(15,6) not null,
	sender_number varchar(30) not null,
	receiver_number varchar(30) not null,
	is_sender_client boolean default false,
	is_receiver_client boolean default false
);

alter table banking.public.transfers owner to admin;

create unique index transfers_transfer_id_uindex
	on banking.public.transfers (transfer_id);

