CREATE TABLE db_version
(
  current_version VARCHAR(10) NOT NULL
);

ALTER TABLE db_version
  OWNER TO admin;

INSERT INTO public.db_version (current_version)
VALUES ('2_00');