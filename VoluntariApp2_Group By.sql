/*Creacion y uso de la base de datos*/
drop database voluntariapp;
create database voluntariapp;
use voluntariapp;
show tables;

-- ---------------------------------------------------
-- Tabla de usuarios
-- ---------------------------------------------------
CREATE TABLE users
(
    id_user     integer auto_increment,
    email       VARCHAR(45) NOT NULL,
    password    VARCHAR(45) NOT NULL,
    is_active   TINYINT     NOT NULL,
    photo       VARCHAR(45) NOT NULL,
    rol         VARCHAR(45) NOT NULL,
    date_update date        not null,
    PRIMARY KEY (id_user)
);
# registros
insert into users values (0,'erick@gmail.com', '123456789', true, '#', 'Admin', now());
insert into users values (0,'kin@gmail.com', '123456789', true, '#', 'Admin', now());
insert into users values (0,'andrea@gmail.com', '123456789', true, '#', 'Admin', now());
insert into users values (0,'jass@gmail.com', '123456789', true, '#', 'Admin', now());
insert into users values (0,'blanca@gmail.com', '123456789', true, '#', 'Organizacion', now());
select * from users;

#Indice simple 
create index i_users_rol on users (rol);
explain  select rol from users where rol='Admin';
show index from users;


#Indices compuestos  
create index i_users_email_password on users (email,password);
show index from users;
explain select *from users;
drop index i_users_email_password on users;
# vista
create view view_user_active as
    select email, is_active
    from users;
select * from view_user_active;

/*Agrupamiento entre tabla users y persons*/
/*Muestra el nombre,apellidos,el rol y el email del usuario ,el cual es una persona */

SELECT persons.name as Name ,persons.surname as Surname ,persons.lastname as Lastname ,users.rol as Rol ,users.email as Email
FROM persons inner join users on users.id_user=persons.id_user
GROUP BY persons.name,persons.surname,persons.lastname,users.rol,users.email;

/*Order by*/
/*Agrupamiento de forma ascendente email de las personas */
SELECT persons.name as Name ,persons.surname as Surname ,persons.lastname as Lastname ,users.rol as Rol ,users.email as Email
FROM persons inner join users on users.id_user=persons.id_user
GROUP BY persons.name,persons.surname,persons.lastname,users.rol,users.email order by users.email desc;


-- -----------------------------------------------------
-- Tabla `Persons`
-- -----------------------------------------------------
CREATE TABLE persons
(
    id_person     integer auto_increment,
    id_user       integer     NOT NULL,
    name          VARCHAR(45) NOT NULL,
    surname       VARCHAR(45) NOT NULL,
    lastname      VARCHAR(45) NOT NULL,
    birth_date    date        NULL,
    curp          VARCHAR(18) NULL,
    address       VARCHAR(60) NULL,
    phone         VARCHAR(10) NULL,
    rfc           VARCHAR(13) NULL,
    bussines_name VARCHAR(45) NULL,
    date_update   date        not null,
    PRIMARY KEY (id_person),
    FOREIGN KEY (id_user) REFERENCES users (id_user)
);
# Registro
insert into persons values (0,1,'Erick Emiliano', 'Morales', 'Velazquez',null,null,null,'7772579788',null,null,now());
insert into persons values (0,2,'Vania Kinereth', 'Quezada', 'Lopez',null,null,null,'7771436571',null,null,now());
insert into persons values (0,3,'Andrea', 'Aguirre', 'Lopez',null,null,null,'77789564',null,null,now());
insert into persons values (0,4,'Jassiel', 'Peretal', 'Santos',null,null,null,'77789564',null,null,now());
insert into persons values (0,5,'Blanca', 'Rodriguez', 'Arriaga',null,null,null,'77789564',null,null,now());

select * from persons;
#Indice simple 
create index i_persons_name on persons (name);
explain select *from persons;

#Indice  compuestos
create index i_persons_name_surname_lastname on persons (name,surname,lastname);
explain select *from persons;
#Indice unico 
CREATE UNIQUE INDEX i_uni_persons ON persons(phone);
CREATE UNIQUE INDEX i_unirfc_persons ON persons(rfc);
CREATE UNIQUE INDEX i_unicurp_persons ON persons(curp);

# Vistas
create view view_user_person as
    select concat(name,concat(' ',concat(lastname,concat(' ',concat(surname,''))))) as Name
    from persons;
select * from view_user_person;
drop view view_user_person;

/*Agrupacion de la tabla persons y events*/
/*Muestra el nombre de la persona y evento ,de igual manera muestra la fecha del este y la direccion*/
/*Group*/

SELECT persons.name as Name ,events.name as Event ,events.event_date as Date_Event ,events.address as Address
FROM events inner join persons on persons.id_person=events.id_person
GROUP BY persons.name,events.name,events.event_date ,events.address;

/*Ordenamiento por fecha del evento*/
SELECT persons.name as Name ,events.name as Event ,events.event_date as Date_Event ,events.address as Address
FROM events inner join persons on persons.id_person=events.id_person
GROUP BY persons.name,events.name,events.event_date ,events.address order by events.address;


-- -----------------------------------------------------
-- Tabla `Events`
-- -----------------------------------------------------
CREATE TABLE events
(
    id_event    integer auto_increment,
    id_person   INT          NOT NULL,
    name        VARCHAR(100) NOT NULL,
    event_date  DATE         NOT NULL,
    description TEXT         NOT NULL,
    address     VARCHAR(60)  NOT NULL,
    date_update date  not null,
    PRIMARY KEY (id_event),
    FOREIGN KEY (id_person) REFERENCES persons (id_person)
);
# registros
insert into events values (0, 1, 'Evento Musical', now(), 'Un evento con tus artistas favoritos', 'Temixco, Mor, Mex', now());
insert into events values (0, 2, 'Evento Economico', now(), 'Un evento con precios a tu acceso', 'Xochitepec, Mor, Mex', now());
insert into events values (0, 3, 'Evento Caritativo', now(), 'Un evento con empatia a los demas ', 'Cuernavaca, Mor, Mex', now());
insert into events values (0, 5, 'Dia del niño', now(), 'Sonrie ,se feliz ', 'Cuernavaca, Mor, Mex', now());

select*from events;
#Indice simple
create index i_events_name on events (name);
explain select *from events;

#Indice compuesto
create index i_events_name_address on events (name,address);
explain select *from events;


# Vista
create view view_address as
    select
        name as Name_event,
        address as Event_ubication
    from events;
select * from view_address;
drop view view_address;

/*Agrupamiento entre la tabla postulaciones*/
/*El agrupamiento muestra el nombre de la persona ,del evento,la fecha,direccion y el numero de postulacion*/

SELECT persons.name as Name, events.name as Name ,events.event_date as Date_Event ,events.address as Address,postulations.id_postulation as No_Postulations
FROM events inner join postulations on postulations.id_event=events.id_event
inner join persons on persons.id_person=events.id_person
GROUP BY events.name,events.event_date ,events.address,postulations.id_postulation,persons.name;

/*Ordenamiento por el id de postulacion */
SELECT persons.name as Name, events.name as Name ,events.event_date as Date_Event ,events.address as Address,postulations.id_postulation as No_Postulations
FROM events inner join postulations on postulations.id_event=events.id_event
inner join persons on persons.id_person=events.id_person
GROUP BY events.name,events.event_date ,events.address,postulations.id_postulation,persons.name order by postulations.id_postulation desc;

-- -----------------------------------------------------
-- Tabla `Postulations`
-- -----------------------------------------------------
CREATE TABLE postulations
(
    id_postulation integer auto_increment,
    is_Accept      TINYINT NOT NULL,
    id_person      integer NOT NULL,
    id_event       integer NOT NULL,
    PRIMARY KEY (id_postulation),
    FOREIGN KEY (id_person) REFERENCES persons (id_person),
    FOREIGN KEY (id_event) REFERENCES events (id_event)
);
# Registro
insert into postulations values (0,true,1,1);
insert into postulations values (0,true,2,2);
insert into postulations values (0,true,3,3);
select*from postulations;
#Indie simple
create index i_postulations_id_person on postulations (id_person);
explain select *from postulations;

#Indice compuesto
create index i_postulations_id_person_id_event on postulations (id_person,id_event);
explain select *from postulations;


/*drop index i_postulations_id_person_id_event on postulations;*/
#Vista
create view view_approve as
    select
        id_person,
        id_event,
        is_Accept
    from postulations;
select *
from view_approve;
drop view view_approve;


-- -----------------------------------------------------
-- Tabla `Forms`
-- -----------------------------------------------------
CREATE TABLE forms
(
    id_form     integer auto_increment,
    id_person   INT         NOT NULL,
    name_form   VARCHAR(60) NOT NULL,
    instruction text        NOT NULL,
    date_update date        not null,
    PRIMARY KEY (id_form),
    FOREIGN KEY (id_person)
        REFERENCES persons (id_person)
);
insert into forms values (0,1,'Test Musical','Lee y selecciona una opcion',now());
insert into forms values (0,2,'Test Economico','Lee y selecciona una opcion',now());
insert into forms values (0,3,'Test Social','Lee y selecciona una opcion',now());

select *from forms;
#Indice simple 
create index i_forms_name_form on forms (name_form);
explain select *from forms;

#Indice compuesto
create index i_forms_name_form_id_person  on forms (name_form,id_person);
explain select *from forms;


# Vista
create view v_form_info as
    select
        name_form,
        instruction,
        date_update
    from forms;
select * from v_form_info;
drop view v_form_info;


/*Agrupamiento de la tabla forms y persons*/
/*Agrupamiento de nombre,nombre del formulario y del evento*/
SELECT persons.name as Name ,forms.name_form as Name_forms  ,events.name Name_event
FROM persons 
inner join forms on forms.id_person=persons.id_person 
inner join events on events.id_person=persons.id_person
GROUP BY persons.name,forms.name_form,events.name;




-- -----------------------------------------------------
-- Tabla `Questions`
-- -----------------------------------------------------
CREATE TABLE questions
(
    id_question integer auto_increment,
    id_form     integer     NOT NULL,
    question    VARCHAR(60) NOT NULL,
    date_update date        not null,
    PRIMARY KEY (id_question),
    FOREIGN KEY (id_form) REFERENCES forms (id_form)
);

/*Agrupamiento entre questions y forms */
/*Nombre de la persona ,el nombre del formulario del evento y la pregunta*/
SELECT persons.name as Name ,forms.name_form as Name_forms  ,events.name Name_event ,questions.question as Question
FROM forms
inner join events on events.id_person=forms.id_person
inner join questions on questions.id_form=forms.id_form 
inner join persons on  persons.id_person=events.id_person
GROUP BY persons.name,forms.name_form,events.name,questions.question;

/*Ordenamiento mediante el nombre del formulario*/
SELECT persons.name as Name ,forms.name_form as Name_forms  ,events.name Name_event ,questions.question as Question
FROM forms
inner join events on events.id_person=forms.id_person
inner join questions on questions.id_form=forms.id_form 
inner join persons on  persons.id_person=events.id_person
GROUP BY persons.name,forms.name_form,events.name,questions.question order by forms.name_form asc;

insert into questions values (0,1,'¿Banda de rock favorita?',now());
insert into questions values (0,1,'¿Español o ingles?',now());
insert into questions values (0,2,'¿Salario minimo?',now());
select*from questions;

#Indice simple
create index i_questions_question on questions (question);
explain select *from questions;

#Indice compuestos 
create index i_questions_id_question_id_form on questions (id_question,id_form );
explain select *from questions;

# Vista
create view v_questions_info as
    select
        id_form as Formulario,
        date_update as last_update
    from questions;
select * from v_questions_info;
drop view v_questions_info;


-- -----------------------------------------------------
-- Tabla `Answers`
-- -----------------------------------------------------
CREATE TABLE answers
(
    id_answer   integer auto_increment,
    id_question integer     NOT NULL,
    answer      VARCHAR(60) NOT NULL,
    is_Correct  boolean     NOT NULL,
    date_update date        not null,
    PRIMARY KEY (id_answer),
    FOREIGN KEY (id_question) REFERENCES questions (id_question)
);
insert into answers values (0,1,'Caifanes',true,now());
insert into answers values (0,1,'Ingles',true,now());
insert into answers values (0,3,'Ingles',true,now());
select*from answers;
#Indice simple
create index i_answers_answer on answers (answer);
explain select *from answers;

#Indice compuesto
create index i_answers_id_answer_id_question on answers (id_answer,id_question );
explain select *from answers;



# Vista
create view v_answer_correct as
select
    id_question as Pregunta,
    is_Correct as Calificada
from answers;
select *
from v_answer_correct;
drop view v_answer_correct;


/*Agrupamiento de questions y answers*/
/*Muestra el nombre de la persona ,nombre del forulario la pregunta y la respuesta */
SELECT persons.name as Name ,forms.name_form as Name_forms  ,events.name Name_event ,questions.question as Question,answers.answer AS Answer
FROM forms
inner join events on events.id_person=forms.id_person
inner join questions on questions.id_form=forms.id_form 
inner join persons on  persons.id_person=events.id_person
inner join answers on answers.id_question=questions.id_question
GROUP BY persons.name,forms.name_form,events.name,questions.question,answers.answer  ;


/*Ordenamiento por pregunta*/
SELECT questions.question as Question,answers.answer as Answer
FROM answers
inner join questions on  questions.id_question=answers.id_question

GROUP BY questions.question,answers.answer order by questions.question desc ;

-- -----------------------------------------------------
-- Tabla`Persons_answers`
-- -----------------------------------------------------
CREATE TABLE persons_answers
(
    id_person_answer integer auto_increment,
    id_answer        integer NOT NULL,
    id_person        integer NOT NULL,
    id_event         integer NOT NULL,
    id_postulation   integer NOT NULL,
    PRIMARY KEY (id_person_answer),
    FOREIGN KEY (id_answer) REFERENCES answers (id_answer),
    FOREIGN KEY (id_person) REFERENCES persons (id_person),
    FOREIGN KEY (id_event) REFERENCES events (id_event),
    FOREIGN KEY (id_postulation) REFERENCES postulations (id_postulation)
);



-- -----------------------------------------------------
-- Tabla `Event_has_photos`
-- -----------------------------------------------------
CREATE TABLE event_has_photos
(
    id_event_has_photo integer auto_increment,
    id_event integer NOT NULL,
    url VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_event_has_photo),
    FOREIGN KEY (id_event) REFERENCES events (id_event)
);
insert into event_has_photos values (0,1,'#');
insert into event_has_photos values (0,2,'#');

#indice simple
create index i_event_has_photos_id_event on event_has_photos (id_event);
explain select *from event_has_photos;

#Indice compuesto 
create index i_event_has_photos_id_event_id_event_has_photo  on event_has_photos ( id_event_has_photo,id_event);
explain select *from event_has_photos;
# Vista
create view v_photos_event as
select
    url as Photos,
    id_event as Event
from event_has_photos;
select *
from v_photos_event;

/*Agrupamiento entre persons ,events y photos*/
/*Nombre de la persona,fecha del evento,nombre del evento y url de foto*/
SELECT persons.name as Name ,events.event_date as Date_event  ,events.name Name_event ,event_has_photos.url as Photos
FROM events
inner join persons on persons.id_person=events.id_person
inner join event_has_photos on event_has_photos.id_event=events.id_event
GROUP BY persons.name,events.event_date,events.name,event_has_photos.url;

/*Ordenamiento por fecha del evento*/
SELECT persons.name as Name ,events.event_date as Date_event  ,events.name Name_event ,event_has_photos.url as Photos
FROM events
inner join persons on persons.id_person=events.id_person
inner join event_has_photos on event_has_photos.id_event=events.id_event
GROUP BY persons.name,events.event_date,events.name,event_has_photos.url order by events.event_date;
-- -----------------------------------------------------
-- Tabla `Configurations`
-- -----------------------------------------------------
CREATE TABLE configurations
(
    id_person_color integer auto_increment,
    id_person       integer      NOT NULL,
    primary_color   VARCHAR(255) NULL,
    secondary_color VARCHAR(255) NULL,
    url_logo        VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_person_color),
    FOREIGN KEY (id_person) REFERENCES persons (id_person)
);
insert into configurations values (0,5,'Azul','Negro','*');
insert into configurations values (0,1,'Morado','Negro','*');



#Indice simple
create index i_configurations_id_person on configurations (id_person);
explain select *from configurations;
#Indice compuesto 
create index i_configurations_id_person_color_id_person on configurations (id_person_color,id_person);
explain select *from configurations;


# Vista
create view v_config as
select
    primary_color as Color_primario,
    secondary_color as Color_secundario,
    url_logo as Logo
from configurations;
select *
from v_config;

/*Agrupamiento de perosns y configurations */
/*muestra id de la persona,nombre de la persona ,nombre del evento ,nombre del color tanto primario como secundario,y por ultimo el logo(url)*/
SELECT configurations.id_person ,persons.name as Name ,events.name as Name_event,  configurations.primary_color As Primary_color,configurations.secondary_color as Secondary_color ,configurations.url_logo as Logo
FROM persons
inner join configurations on configurations.id_person=persons.id_person
inner join events on events.id_person=persons.id_person
GROUP BY configurations.id_person,persons.name,events.name,configurations.primary_color ,configurations.secondary_color,configurations.url_logo;

/*Ordenamiento por id de persona */
/*Solo lo ordena de manera ascendente el id de la persona */
SELECT configurations.id_person ,persons.name as Name ,events.name as Name_event,  configurations.primary_color As Primary_color,configurations.secondary_color as Secondary_color ,configurations.url_logo as Logo
FROM persons
inner join configurations on configurations.id_person=persons.id_person
inner join events on events.id_person=persons.id_person
GROUP BY configurations.id_person,persons.name,events.name,configurations.primary_color ,configurations.secondary_color,configurations.url_logo order by configurations.id_person;


