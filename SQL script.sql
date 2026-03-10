-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema collage
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema collage
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `collage` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `collage` ;

-- -----------------------------------------------------
-- Table `collage`.`artist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `collage`.`artist` (
  `artist_id` INT NOT NULL,
  `name` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`artist_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `collage`.`album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `collage`.`album` (
  `album_id` INT NOT NULL,
  `title` VARCHAR(255) NULL DEFAULT NULL,
  `artist_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`album_id`),
  INDEX `fk_album_artist` (`artist_id` ASC) VISIBLE,
  CONSTRAINT `fk_album_artist`
    FOREIGN KEY (`artist_id`)
    REFERENCES `collage`.`artist` (`artist_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `collage`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `collage`.`employee` (
  `employee_id` INT NOT NULL,
  `last_name` TEXT NULL DEFAULT NULL,
  `first_name` TEXT NULL DEFAULT NULL,
  `title` TEXT NULL DEFAULT NULL,
  `reports_to` INT NULL DEFAULT NULL,
  `levels` TEXT NULL DEFAULT NULL,
  `birthdate` TEXT NULL DEFAULT NULL,
  `hire_date` TEXT NULL DEFAULT NULL,
  `address` TEXT NULL DEFAULT NULL,
  `city` TEXT NULL DEFAULT NULL,
  `state` TEXT NULL DEFAULT NULL,
  `country` TEXT NULL DEFAULT NULL,
  `postal_code` TEXT NULL DEFAULT NULL,
  `phone` TEXT NULL DEFAULT NULL,
  `fax` TEXT NULL DEFAULT NULL,
  `email` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  INDEX `fk_employee_employee_idx` (`reports_to` ASC) VISIBLE,
  CONSTRAINT `fk_employee_employee`
    FOREIGN KEY (`reports_to`)
    REFERENCES `collage`.`employee` (`reports_to`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `collage`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `collage`.`customer` (
  `customer_id` INT NOT NULL,
  `first_name` TEXT NULL DEFAULT NULL,
  `last_name` TEXT NULL DEFAULT NULL,
  `company` TEXT NULL DEFAULT NULL,
  `address` TEXT NULL DEFAULT NULL,
  `city` TEXT NULL DEFAULT NULL,
  `state` TEXT NULL DEFAULT NULL,
  `country` TEXT NULL DEFAULT NULL,
  `postal_code` TEXT NULL DEFAULT NULL,
  `phone` TEXT NULL DEFAULT NULL,
  `fax` TEXT NULL DEFAULT NULL,
  `email` TEXT NULL DEFAULT NULL,
  `support_rep_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  INDEX `fk_customer_employee_idx` (`support_rep_id` ASC) VISIBLE,
  CONSTRAINT `fk_customer_employee`
    FOREIGN KEY (`support_rep_id`)
    REFERENCES `collage`.`employee` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `collage`.`genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `collage`.`genre` (
  `genre_id` INT NOT NULL,
  `name` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`genre_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `collage`.`invoice`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `collage`.`invoice` (
  `invoice_id` INT NOT NULL,
  `customer_id` INT NULL DEFAULT NULL,
  `invoice_date` TEXT NULL DEFAULT NULL,
  `billing_address` TEXT NULL DEFAULT NULL,
  `billing_city` TEXT NULL DEFAULT NULL,
  `billing_state` TEXT NULL DEFAULT NULL,
  `billing_country` TEXT NULL DEFAULT NULL,
  `billing_postal_code` TEXT NULL DEFAULT NULL,
  `total` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`invoice_id`),
  INDEX `fk_invoice_customer_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_invoice_customer`
    FOREIGN KEY (`customer_id`)
    REFERENCES `collage`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `collage`.`invoice_line`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `collage`.`invoice_line` (
  `invoice_line_id` INT NULL DEFAULT NULL,
  `invoice_id` INT NOT NULL,
  `track_id` INT NULL DEFAULT NULL,
  `unit_price` DOUBLE NULL DEFAULT NULL,
  `quantity` INT NULL DEFAULT NULL,
  PRIMARY KEY (`invoice_id`),
  CONSTRAINT `fk_invoceline_invoice`
    FOREIGN KEY (`invoice_id`)
    REFERENCES `collage`.`invoice` (`invoice_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `collage`.`media_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `collage`.`media_type` (
  `media_type_id` INT NOT NULL,
  `name` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`media_type_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `collage`.`playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `collage`.`playlist` (
  `playlist_id` INT NOT NULL,
  `name` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`playlist_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `collage`.`track`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `collage`.`track` (
  `track_id` INT NOT NULL,
  `name` TEXT NULL DEFAULT NULL,
  `album_id` INT NULL DEFAULT NULL,
  `media_type_id` INT NULL DEFAULT NULL,
  `genre_id` INT NULL DEFAULT NULL,
  `composer` TEXT NULL DEFAULT NULL,
  `milliseconds` INT NULL DEFAULT NULL,
  `bytes` INT NULL DEFAULT NULL,
  `unit_price` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`track_id`),
  INDEX `fk_track_album_idx` (`album_id` ASC) VISIBLE,
  INDEX `fk_track_mediaTypeId_idx` (`media_type_id` ASC) VISIBLE,
  INDEX `fk_track_genre_idx` (`genre_id` ASC) VISIBLE,
  CONSTRAINT `fk_track_album`
    FOREIGN KEY (`album_id`)
    REFERENCES `collage`.`album` (`album_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_track_mediaTypeId`
    FOREIGN KEY (`media_type_id`)
    REFERENCES `collage`.`media_type` (`media_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_track_genre`
    FOREIGN KEY (`genre_id`)
    REFERENCES `collage`.`genre` (`genre_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `collage`.`playlist_track`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `collage`.`playlist_track` (
  `playlist_id` INT NOT NULL,
  `track_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`playlist_id`),
  CONSTRAINT `playlistTrack_playlist`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `collage`.`playlist` (`playlist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `playlistTrack_track`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `collage`.`track` (`track_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
