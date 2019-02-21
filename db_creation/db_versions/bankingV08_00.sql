ALTER TABLE departments
	ALTER COLUMN name SET NOT NULL;

CREATE UNIQUE INDEX departments_name_uindex
	ON departments (name);

ALTER TABLE departments
	DROP CONSTRAINT departments_employees_employee_id_fk;

ALTER TABLE departments
	DROP COLUMN employee_id;


ALTER TABLE employees
	ALTER COLUMN basic_payment TYPE DECIMAL(10, 2) USING basic_payment::DECIMAL(10, 2);

ALTER TABLE employees
	ALTER COLUMN basic_payment SET NOT NULL;

ALTER TABLE employees
	ADD account_number VARCHAR(19) NOT NULL;

CREATE UNIQUE INDEX employees_account_number_uindex
	ON employees (account_number);

UPDATE public.db_version
SET current_version = '8_00' WHERE db_version.id = 1;