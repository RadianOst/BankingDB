alter table currencies alter column name type varchar(22) using name::varchar(22);

alter table cards alter column card_type_id set not null;

alter table cards rename column user_id to account_id;

alter table cards alter column account_id set not null;

alter table cards alter column card_number type varchar(19) using card_number::varchar(19);

alter table cards alter column card_number set not null;

alter table cards drop constraint cards_users_user_id_fk;

alter table cards
	add constraint cards_accounts_account_id_fk
		foreign key (account_id) references accounts;

