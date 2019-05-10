INSERT INTO public.card_producers (name, security_length) VALUES ('Visa', 3);
INSERT INTO public.card_producers (name, security_length) VALUES ('MasterCard', 3);
INSERT INTO public.card_producers (name, security_length) VALUES ('American Express', 4);

UPDATE public.db_version
SET current_version = '5_01' WHERE db_version.id = 1;