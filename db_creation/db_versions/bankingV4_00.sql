alter table currencies
	add name varchar(20) not null;

create unique index currencies_name_uindex
	on currencies (name);

create unique index currencies_symbol_uindex
	on currencies (symbol);

