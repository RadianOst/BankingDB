INSERT INTO public.card_types (type_info, card_producer_id) VALUES ('Bronze', 1);
INSERT INTO public.card_types (type_info, card_producer_id) VALUES ('Silver', 1);
INSERT INTO public.card_types (type_info, card_producer_id) VALUES ('Gold', 1);
INSERT INTO public.card_types (type_info, card_producer_id) VALUES ('Platinum', 1);
INSERT INTO public.card_types (type_info, card_producer_id) VALUES ('Diamond', 1);
INSERT INTO public.card_types (type_info, card_producer_id) VALUES ('Master', 1);
INSERT INTO public.card_types (type_info, card_producer_id) VALUES ('GrandMaster', 1);
INSERT INTO public.card_types (type_info, card_producer_id) VALUES ('Iron', 2);
INSERT INTO public.card_types (type_info, card_producer_id) VALUES ('Bronze', 2);
INSERT INTO public.card_types (type_info, card_producer_id) VALUES ( 'Silver', 2);
INSERT INTO public.card_types (type_info, card_producer_id) VALUES ( 'Gold', 2);
INSERT INTO public.card_types (type_info, card_producer_id) VALUES ( 'Platinum', 2);
INSERT INTO public.card_types (type_info, card_producer_id) VALUES ( 'Diamond', 2);
INSERT INTO public.card_types (type_info, card_producer_id) VALUES ( 'Challenger', 2);
INSERT INTO public.card_types (type_info, card_producer_id) VALUES ( 'Void', 3);
INSERT INTO public.card_types (type_info, card_producer_id) VALUES ( 'Blank', 3);
INSERT INTO public.card_types (type_info, card_producer_id) VALUES ( 'Null', 3);
INSERT INTO public.card_types (type_info, card_producer_id) VALUES ( 'Nil', 3);
INSERT INTO public.card_types (type_info, card_producer_id) VALUES ( 'NaN', 3);
INSERT INTO public.card_types (type_info, card_producer_id) VALUES ( 'undefined', 3);

UPDATE public.db_version
SET current_version = '5_02' WHERE db_version.id = 1;
