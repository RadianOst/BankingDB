drop index currencies_symbol_uindex;

drop index currencies_name_uindex;

UPDATE public.db_version
SET current_version = '06_00'
WHERE db_version.id = 1;
