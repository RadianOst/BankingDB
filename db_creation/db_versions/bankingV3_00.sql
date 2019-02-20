alter table currencies alter column symbol type char(3) using symbol::char(3);

alter table currencies alter column symbol set not null;

alter table currencies
	add quantity int default 1 not null;

alter table currencies drop column shortcut;

