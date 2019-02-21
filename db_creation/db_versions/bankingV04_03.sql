INSERT INTO "public"."currencies" ("currency_id", "main_currency_value", "symbol", "quantity", "name")
VALUES (36, 1.00000000, 'PLN', 1, 'Polski Złoty');

UPDATE public.db_version
SET current_version = '4_03' WHERE db_version.id = 1;