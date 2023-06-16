-- MySQL Script generated by MySQL Workbench
-- Thu Jun 15 20:55:19 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Users` (
  `idUsers` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `isActive` TINYINT NOT NULL,
  `photo` VARCHAR(45) NOT NULL,
  `rol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idUsers`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Persons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Persons` (
  `idPersons` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `birth_date` VARCHAR(45) NULL,
  `curp` VARCHAR(45) NULL,
  `address` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `rfc` VARCHAR(45) NULL,
  `bussines_name` VARCHAR(45) NULL,
  `fk_users_id` INT NOT NULL,
  PRIMARY KEY (`idPersons`),
  INDEX `fk_Persons_Users1_idx` (`fk_users_id` ASC) VISIBLE,
  CONSTRAINT `fk_Persons_Users1`
    FOREIGN KEY (`fk_users_id`)
    REFERENCES `mydb`.`Users` (`idUsers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Events`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Events` (
  `idEvents` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `event_date` DATE NOT NULL,
  `description` TEXT NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `fk_persons_id` INT NOT NULL,
  PRIMARY KEY (`idEvents`),
  INDEX `fk_Events_Persons1_idx` (`fk_persons_id` ASC) VISIBLE,
  CONSTRAINT `fk_Events_Persons1`
    FOREIGN KEY (`fk_persons_id`)
    REFERENCES `mydb`.`Persons` (`idPersons`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Postulations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Postulations` (
  `idPostulations` INT NOT NULL,
  `is_Accept` TINYINT NOT NULL,
  `fk_persons_id` INT NOT NULL,
  `fk_event` INT NOT NULL,
  PRIMARY KEY (`idPostulations`),
  INDEX `fk_Postulations_Persons1_idx` (`fk_persons_id` ASC) VISIBLE,
  INDEX `fk_postulation_event_idx` (`fk_event` ASC) VISIBLE,
  CONSTRAINT `fk_Postulations_Persons1`
    FOREIGN KEY (`fk_persons_id`)
    REFERENCES `mydb`.`Persons` (`idPersons`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_postulation_event`
    FOREIGN KEY (`fk_event`)
    REFERENCES `mydb`.`Events` (`idEvents`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Forms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Forms` (
  `idForms` INT NOT NULL,
  `name_forms` VARCHAR(45) NOT NULL,
  `instructions` VARCHAR(45) NOT NULL,
  `fk_persons_id` INT NOT NULL,
  PRIMARY KEY (`idForms`),
  INDEX `fk_Forms_Persons1_idx` (`fk_persons_id` ASC) VISIBLE,
  CONSTRAINT `fk_Forms_Persons1`
    FOREIGN KEY (`fk_persons_id`)
    REFERENCES `mydb`.`Persons` (`idPersons`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Questions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Questions` (
  `idQuestions` INT NOT NULL,
  `question` VARCHAR(45) NOT NULL,
  `fk_forms_id` INT NOT NULL,
  PRIMARY KEY (`idQuestions`),
  INDEX `fk_Questions_Forms1_idx` (`fk_forms_id` ASC) VISIBLE,
  CONSTRAINT `fk_Questions_Forms1`
    FOREIGN KEY (`fk_forms_id`)
    REFERENCES `mydb`.`Forms` (`idForms`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Answers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Answers` (
  `idAnswers` INT NOT NULL,
  `answer` VARCHAR(45) NOT NULL,
  `is_Correct` VARCHAR(45) NOT NULL,
  `fk_questions_id` INT NOT NULL,
  PRIMARY KEY (`idAnswers`),
  INDEX `fk_Answers_Questions1_idx` (`fk_questions_id` ASC) VISIBLE,
  CONSTRAINT `fk_Answers_Questions1`
    FOREIGN KEY (`fk_questions_id`)
    REFERENCES `mydb`.`Questions` (`idQuestions`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Persons_answers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Persons_answers` (
  `idPersons_answers` INT NOT NULL,
  `fk_answers_id` INT NOT NULL,
  `fk_persons_id` INT NOT NULL,
  `fk_events_id` INT NOT NULL,
  `fk_postularion` INT NOT NULL,
  PRIMARY KEY (`idPersons_answers`),
  INDEX `fk_Persons_answers_Answers1_idx` (`fk_answers_id` ASC) VISIBLE,
  INDEX `fk_Persons_answers_Persons1_idx` (`fk_persons_id` ASC) VISIBLE,
  INDEX `fk_Persons_answers_Events1_idx` (`fk_events_id` ASC) VISIBLE,
  INDEX `fk_answers_person_postulation_idx` (`fk_postularion` ASC) VISIBLE,
  CONSTRAINT `fk_Persons_answers_Answers1`
    FOREIGN KEY (`fk_answers_id`)
    REFERENCES `mydb`.`Answers` (`idAnswers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Persons_answers_Persons1`
    FOREIGN KEY (`fk_persons_id`)
    REFERENCES `mydb`.`Persons` (`idPersons`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Persons_answers_Events1`
    FOREIGN KEY (`fk_events_id`)
    REFERENCES `mydb`.`Events` (`idEvents`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_answers_person_postulation`
    FOREIGN KEY (`fk_postularion`)
    REFERENCES `mydb`.`Postulations` (`idPostulations`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Event_has_photos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Event_has_photos` (
  `idEvent_has_photos` INT NOT NULL,
  `url` VARCHAR(255) NOT NULL,
  `fk_events_id` INT NOT NULL,
  PRIMARY KEY (`idEvent_has_photos`),
  INDEX `fk_Event_has_photos_Events1_idx` (`fk_events_id` ASC) VISIBLE,
  CONSTRAINT `fk_Event_has_photos_Events1`
    FOREIGN KEY (`fk_events_id`)
    REFERENCES `mydb`.`Events` (`idEvents`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Configurations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Configurations` (
  `idPerson_colors` INT NOT NULL,
  `primary_color` VARCHAR(255) NULL,
  `secondary_color` VARCHAR(45) NULL,
  `url_logo` VARCHAR(255) NOT NULL,
  `fk_persons_id` INT NOT NULL,
  PRIMARY KEY (`idPerson_colors`),
  INDEX `fk_Configurations_Persons1_idx` (`fk_persons_id` ASC) VISIBLE,
  CONSTRAINT `fk_Configurations_Persons1`
    FOREIGN KEY (`fk_persons_id`)
    REFERENCES `mydb`.`Persons` (`idPersons`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
USE `mydb`;

DELIMITER $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Persons_AFTER_INSERT` AFTER INSERT ON `Persons` FOR EACH ROW
BEGIN

END
$$


DELIMITER ;