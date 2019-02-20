alter schema public owner to admin;

create table address
(
	address_id serial not null
		constraint address_pk
			primary key,
	street varchar(60),
	postal_code varchar(6),
	city varchar(60)
);

alter table address owner to admin;

create table users
(
	user_id serial not null
		constraint users_pk
			primary key,
	name varchar(60) not null,
	surname varchar(60) not null,
	address_id integer
		constraint users_adresses_fk
			references address
				on update cascade on delete set null,
	pesel varchar(11)
);

alter table users owner to admin;

create unique index users_id_uindex
	on users (user_id);

create unique index users_pesel_uindex
	on users (pesel);

create unique index address_address_id_uindex
	on address (address_id);

create table currencies
(
	currency_id serial not null
		constraint currencies_pk
			primary key,
	main_currency_value numeric(12,8) not null,
	symbol varchar(3),
	shortcut varchar(10)
);

alter table currencies owner to admin;

create table account_types
(
	account_type_id serial not null
		constraint account_types_pk
			primary key,
	name varchar(100) not null,
	currency_id integer
		constraint account_types_currencies_currency_id_fk
			references currencies
);

alter table account_types owner to admin;

create unique index account_types_account_types_id_uindex
	on account_types (account_type_id);

create table accounts
(
	account_id serial not null
		constraint accounts_pk
			primary key,
	account_type_id integer
		constraint accounts_account_type_fk
			references account_types,
	number varchar(30) not null,
	user_id integer
		constraint accounts_users_users_fk
			references users
				on update cascade on delete set null
);

alter table accounts owner to admin;

create unique index accounts_account_id_uindex
	on accounts (account_id);

create unique index accounts_number_uindex
	on accounts (number);

create unique index currencies_currency_id_uindex
	on currencies (currency_id);

create table credit_types
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
			references currencies,
	value numeric(20,2)
);

alter table credit_types owner to admin;

create unique index credit_types_credit_type_id_uindex
	on credit_types (credit_type_id);

create table credits
(
	credit_id serial not null
		constraint credits_pk
			primary key,
	credit_type_id integer not null
		constraint credits_credit_types_credit_type_id_fk
			references credit_types,
	user_id integer not null
		constraint credits_users_user_id_fk
			references users,
	start_date date not null
);

alter table credits owner to admin;

create unique index credits_credit_id_uindex
	on credits (credit_id);

create table investment_types
(
	investment_type_id serial not null
		constraint investment_types_pk
			primary key,
	name varchar(100),
	interest numeric(6,2),
	instalment_value numeric(8,2),
	minimal_instalment_number integer
);

alter table investment_types owner to admin;

create unique index investment_types_investment_type_id_uindex
	on investment_types (investment_type_id);

create table investments
(
	investment_id serial not null
		constraint investments_pk
			primary key,
	investment_type_id integer
		constraint investments_investment_types_investment_type_id_fk
			references investment_types,
	user_id integer
		constraint investments_users_user_id_fk
			references users,
	start_date date not null
);

alter table investments owner to admin;

create unique index investments_investment_id_uindex
	on investments (investment_id);

create table card_producers
(
	card_producer_id serial not null
		constraint card_producers_pk
			primary key,
	name varchar(50) not null,
	security_length integer not null
);

alter table card_producers owner to admin;

create unique index card_producers_card_producer_id_uindex
	on card_producers (card_producer_id);

create unique index card_producers_name_uindex
	on card_producers (name);

create table card_types
(
	card_type_id serial not null
		constraint card_types_pk
			primary key,
	type_info varchar(200),
	card_producer_id integer
		constraint card_types_card_producers_card_producer_id_fk
			references card_producers
);

alter table card_types owner to admin;

create unique index card_types_card_type_id_uindex
	on card_types (card_type_id);

create table cards
(
	card_id serial not null
		constraint cards_pk
			primary key,
	card_type_id integer
		constraint cards_card_types_card_type_id_fk
			references card_types,
	expiration_date date not null,
	release_date date not null,
	security_code varchar(5) not null,
	user_id integer
		constraint cards_users_user_id_fk
			references users,
	card_number varchar(30)
);

alter table cards owner to admin;

create table account_cards
(
	account_card_id serial not null
		constraint account_cards_pk
			primary key,
	account_id integer
		constraint account_cards_accounts_account_id_fk
			references accounts,
	card_id integer
		constraint account_cards_cards_card_id_fk
			references cards
);

alter table account_cards owner to admin;

create unique index account_cards_account_card_id_uindex
	on account_cards (account_card_id);

create unique index cards_card_id_uindex
	on cards (card_id);

create unique index cards_card_number_uindex
	on cards (card_number);

create table employees
(
	employee_id serial not null
		constraint employees_pk
			primary key,
	name varchar(60) not null,
	surname varchar(60) not null,
	basic_payment integer
);

alter table employees owner to admin;

create table departments
(
	department_id serial not null
		constraint departments_pk
			primary key,
	name varchar(200),
	employee_id integer
		constraint departments_employees_employee_id_fk
			references employees
);

alter table departments owner to admin;

create unique index departments_department_id_uindex
	on departments (department_id);

create unique index employees_employee_id_uindex
	on employees (employee_id);

create table salary_history
(
	salary_history_id serial not null
		constraint salary_history_pk
			primary key,
	date date default CURRENT_DATE not null,
	employee_id integer
		constraint salary_history_employees_employee_id_fk
			references employees,
	amount numeric(10,2) not null,
	currency_id integer
		constraint salary_history_currencies_currency_id_fk
			references currencies
);

alter table salary_history owner to admin;

create unique index salary_history_salary_history_id_uindex
	on salary_history (salary_history_id);

create table transfers
(
	transfer_id serial not null
		constraint transfers_pk
			primary key,
	value numeric(15,2) not null,
	currency_id integer
		constraint transfers_currencies_currency_id_fk
			references currencies,
	date date default CURRENT_DATE not null,
	exchange_rate numeric(15,6) not null,
	sender_number varchar(30) not null,
	receiver_number varchar(30) not null,
	is_sender_client boolean default false,
	is_receiver_client boolean default false
);

alter table transfers owner to admin;

create unique index transfers_transfer_id_uindex
	on transfers (transfer_id);

