BEGIN TRANSACTION;

CREATE TABLE owner (
owner_id serial NOT NULL,
name varchar(255) NOT NULL,
address varchar(255) NOT NULL,
phone_number varchar(255) NOT NULL,
CONSTRAINT pk_owner_id PRIMARY KEY (owner_id)
);
 
 CREATE TABLE pet(
 pet_id serial NOT NULL,
 pet_name varchar(255) NOT NULL,
 age int,
 pet_type varchar(255) NOT NULL,
 sex character(1) NOT NULL,
 owner_id integer,
CONSTRAINT fk_owner_id FOREIGN KEY (owner_id) REFERENCES owner(owner_id),
CONSTRAINT sex_check CHECK ((UPPER (sex)='M') OR (UPPER (sex)='F')),
CONSTRAINT pk_pet_id PRIMARY KEY (pet_id)
);

CREATE TABLE procedure (
procedure_id serial NOT NULL,
procedure_name varchar(255) NOT NULL,
CONSTRAINT pk_procedure_id PRIMARY KEY (procedure_id)
);

CREATE TABLE dates (
visit_date DATE NOT NULL,
CONSTRAINT pk_visit_date PRIMARY KEY (visit_date)
);

CREATE TABLE visit_pet (
visit_date DATE,
procedure_id integer NOT NULL,
pet_id integer NOT NULL, 
CONSTRAINT pk_visit_pet_id PRIMARY KEY (procedure_id,pet_id),
CONSTRAINT fk_procedure_id FOREIGN KEY (procedure_id) REFERENCES procedure(procedure_id),
CONSTRAINT fk_pet_id FOREIGN KEY (pet_id) REFeRENCES pet(pet_id)
);

CREATE TABLE visit (
visit_id serial NOT NULL,
date_id DATE NOT NULL,
procedure_pet_id integer NOT NULL,
CONSTRAINT pk_visit_id PRIMARY KEY (visit_id),
CONSTRAINT fk_date_id FOREIGN KEY (date_id) REFeRENCES dates(visit_date),
CONSTRAINT fk_procedure_pet_id FOREIGN KEY (procedure_pet_id) REFERENCES procedure_pet(procedure_pet_id)
);

ALTER TABLE visit_procedure
ADD FOREIGN KEY(visit_id)
REFERENCES visit(visit_id);

ALTER TABLE visit_procedure
ADD FOREIGN KEY (procedure_id)
REFERENCES procedure(procedure_id);

CREATE TABLE invoice (
invoice_id serial NOT NULL,
invoice_date DATE NOT NULL,
procedure_id integer,
pet_id integer NOT NULL,
CONSTRAINT pk_invoice_id PRIMARY KEY (invoice_id),
CONSTRAINT fk_visit_pet_id FOREIGN KEY (procedure_id,pet_id) REFERENCES visit_pet(procedure_id,pet_id)

);

drop table dates;

ROLLBACK;