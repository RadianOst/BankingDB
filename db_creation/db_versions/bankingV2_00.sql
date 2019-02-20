create table db_version
(
  current_version varchar(10) not null
);

alter table db_version
  owner to admin;

INSERT INTO public.db_version (current_version) VALUES ('2_00');