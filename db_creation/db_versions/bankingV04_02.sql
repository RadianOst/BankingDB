INSERT INTO "public"."credit_types" ("credit_type_id", "name", "interest", "instalments_number", "interval",
                                     "currency_id", "value")
VALUES (DEFAULT, 'wooden', 50.00, 2, 1, 1, 1000000.00);

ALTER  TABLE public.db_version ADD COLUMN id SERIAL PRIMARY KEY;

UPDATE public.db_version
SET current_version = '4_02' WHERE db_version.id = 1;