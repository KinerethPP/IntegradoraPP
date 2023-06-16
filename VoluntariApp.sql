/*Creacion y uso de la base de datos*/
create database voluntariapp;
use voluntariapp ;
show tables;

/*Tabla de usuarios */
CREATE TABLE users (
  id_user  integer auto_increment,
  email VARCHAR(45) NOT NULL,
  password VARCHAR(45) NOT NULL,
  is_active TINYINT NOT NULL,
  photo VARCHAR(45) NOT NULL,
  rol VARCHAR(45) NOT NULL,
  date_update date not null,
  PRIMARY KEY (id_user)
  );


-- -----------------------------------------------------
-- Tabla `Persons`
-- -----------------------------------------------------
CREATE TABLE  persons (
  id_person integer auto_increment ,
  name VARCHAR(45) NOT NULL,
  surname VARCHAR(45) NOT NULL,
  lastname VARCHAR(45) NOT NULL,
  birth_date date NULL,
  curp VARCHAR(18) NULL,
  address VARCHAR(60) NULL,
  phone VARCHAR(10) NULL,
  rfc VARCHAR(13) NULL,
  bussines_name VARCHAR(45) NULL,
  date_update date not null,
 id_user integer NOT NULL,
  PRIMARY KEY (id_person),
  FOREIGN KEY (id_user)  REFERENCES  users (id_user)
   );



-- -----------------------------------------------------
-- Tabla `Events`
-- -----------------------------------------------------
CREATE TABLE events (
  id_event integer auto_increment ,
  name VARCHAR(100) NOT NULL,
  event_date DATE NOT NULL,
  description TEXT NOT NULL,
  address VARCHAR(60) NOT NULL,
 id_person INT NOT NULL,
 date_update date not null,
  PRIMARY KEY (id_event),
 FOREIGN KEY (id_person) REFERENCES persons (id_person)
   );




-- -----------------------------------------------------
-- Tabla `Postulations`
-- -----------------------------------------------------
CREATE TABLE postulations (
  id_postulation integer auto_increment ,
  is_Accept TINYINT NOT NULL,
 id_person integer NOT NULL,
  id_event integer NOT NULL,
  PRIMARY KEY (id_postulation),
  FOREIGN KEY (id_person)REFERENCES persons (id_person),
 FOREIGN KEY (id_event) REFERENCES events (id_event)
   
 );




-- -----------------------------------------------------
-- Tabla `Forms`
-- -----------------------------------------------------
CREATE TABLE forms (
  id_form integer auto_increment,
  name_form VARCHAR(60) NOT NULL,
  instruction text  NOT NULL,
  id_person INT NOT NULL,
  date_update date not null,
  PRIMARY KEY (id_form),
  FOREIGN KEY (id_person)
    REFERENCES persons (id_person)
    );




-- -----------------------------------------------------
-- Tabla `Questions`
-- -----------------------------------------------------
CREATE TABLE questions (
  id_question integer auto_increment ,
  question VARCHAR(60) NOT NULL,
  id_form integer  NOT NULL,
  date_update date not null,
  PRIMARY KEY (id_question),
FOREIGN KEY (id_form) REFERENCES forms (id_form)
    );




-- -----------------------------------------------------
-- Tabla `Answers`
-- -----------------------------------------------------
CREATE TABLE answers (
  id_answer integer auto_increment ,
  answer VARCHAR(60) NOT NULL,
  is_Correct boolean NOT NULL,
  id_question integer NOT NULL,
  date_update date not null,
  PRIMARY KEY (id_answer),
  FOREIGN KEY (id_question) REFERENCES questions (id_question)
    );




-- -----------------------------------------------------
-- Tabla`Persons_answers`
-- -----------------------------------------------------
CREATE TABLE persons_answers (
  id_person_answer integer auto_increment,
  id_answer integer NOT NULL,
  id_person integer NOT NULL,
  id_event integer NOT NULL,
  id_postularion integer NOT NULL,
  PRIMARY KEY (id_person_answer),
 FOREIGN KEY (id_answer) REFERENCES answers (id_answer),
FOREIGN KEY (id_person)REFERENCES persons (id_person),
FOREIGN KEY (id_event)REFERENCES events (id_event),
FOREIGN KEY (id_postularion)REFERENCES postulations (id_postulation)
    );




-- -----------------------------------------------------
-- Tabla `Event_has_photos`
-- -----------------------------------------------------
CREATE TABLE event_has_photos (
  id_event_has_photo integer auto_increment,
  url VARCHAR(255) NOT NULL,
  id_event integer NOT NULL,
  PRIMARY KEY (id_event_has_photo),
 
FOREIGN KEY (id_event)REFERENCES events(id_event)
   );




-- -----------------------------------------------------
-- Tabla `Configurations`
-- -----------------------------------------------------
CREATE TABLE configurations (
  id_person_color integer auto_increment ,
  primary_color VARCHAR(255) NULL,
  secondary_color VARCHAR(255) NULL,
  url_logo VARCHAR(255) NOT NULL,
  id_person integer NOT NULL,
  PRIMARY KEY (id_person_color),
FOREIGN KEY (id_person) REFERENCES persons (id_person)
    );

/**/
