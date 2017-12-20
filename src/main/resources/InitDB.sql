CREATE SCHEMA `sqltask` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE `sqltask`.`skills` (
  `skills_id` INT NOT NULL AUTO_INCREMENT,
  `skills_name` VARCHAR(45) NULL,
  PRIMARY KEY (`skills_id`));

CREATE TABLE `sqltask`.`developers` (
  `developer_id` INT NOT NULL AUTO_INCREMENT,
  `developer_firsName` VARCHAR(45) NOT NULL,
  `developer_lastName` VARCHAR(45) NOT NULL,
  `developer_specialty` VARCHAR(45) NULL,
   PRIMARY KEY (`developer_id`));

CREATE TABLE `sqltask`.`skillsDeveloper` (
  `developer_id` INT NOT NULL,
  `skill_id` INT NOT NULL,
  INDEX `fk_skillsDeveloper_1_idx` (`developer_id` ASC),
  INDEX `fk_skillsDeveloper_2_idx` (`skill_id` ASC),
  CONSTRAINT `fk_skillsDeveloper_1`
    FOREIGN KEY (`developer_id`)
    REFERENCES `sqltask`.`developers` (`developer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_skillsDeveloper_2`
    FOREIGN KEY (`skill_id`)
    REFERENCES `sqltask`.`skills` (`skills_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `sqltask`.`teams` (
  `team_id` INT NOT NULL AUTO_INCREMENT,
  `team_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`team_id`));


CREATE TABLE `sqltask`.`devInTeam` (
  `team_id` INT NOT NULL,
  `developer_id` INT NOT NULL,
  INDEX `fk_devInTeam_1_idx` (`team_id` ASC),
  INDEX `fk_devInTeam_2_idx` (`developer_id` ASC),
  CONSTRAINT `fk_devInTeam_1`
    FOREIGN KEY (`team_id`)
    REFERENCES `sqltask`.`teams` (`team_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_devInTeam_2`
    FOREIGN KEY (`developer_id`)
    REFERENCES `sqltask`.`developers` (`developer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE `sqltask`.`projects` (
  `project_id` INT NOT NULL AUTO_INCREMENT,
  `project_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`project_id`));

CREATE TABLE `sqltask`.`teamsInTheProject` (
  `project_id` INT NOT NULL,
  `team_id` INT NOT NULL,
  INDEX `fk_teamsInTheProject_1_idx` (`project_id` ASC),
  INDEX `fk_teamsInTheProject_2_idx` (`team_id` ASC),
  CONSTRAINT `fk_teamsInTheProject_1`
    FOREIGN KEY (`project_id`)
    REFERENCES `sqltask`.`projects` (`project_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_teamsInTheProject_2`
    FOREIGN KEY (`team_id`)
    REFERENCES `sqltask`.`teams` (`team_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE `sqltask`.`customers` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `customer_firstName` VARCHAR(45) NOT NULL,
  `customer_lastName` VARCHAR(45) NOT NULL,
  `customer_address` VARCHAR(45) NULL,
  PRIMARY KEY (`customer_id`));

CREATE TABLE `sqltask`.`projectsFromTheCustmer` (
  `customer_id` INT NOT NULL,
  `project_id` INT NOT NULL,
  INDEX `fk_projectsFromTheCustmer_1_idx` (`customer_id` ASC),
  INDEX `fk_projectsFromTheCustmer_2_idx` (`project_id` ASC),
  CONSTRAINT `fk_projectsFromTheCustmer_1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `sqltask`.`customers` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_projectsFromTheCustmer_2`
    FOREIGN KEY (`project_id`)
    REFERENCES `sqltask`.`projects` (`project_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `sqltask`.`companies` (
  `company_id` INT NOT NULL AUTO_INCREMENT,
  `company_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`company_id`));

CREATE TABLE `sqltask`.`projectsFromTheCompany` (
  `company_id` INT NOT NULL,
  `project_id` INT NOT NULL,
  INDEX `fk_projectsFromTheCompany_1_idx` (`company_id` ASC),
  INDEX `fk_projectsFromTheCompany_2_idx` (`project_id` ASC),
  CONSTRAINT `fk_projectsFromTheCompany_1`
    FOREIGN KEY (`company_id`)
    REFERENCES `sqltask`.`companies` (`company_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_projectsFromTheCompany_2`
    FOREIGN KEY (`project_id`)
    REFERENCES `sqltask`.`projects` (`project_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `sqltask`.`customersOfCompanies` (
  `company_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  INDEX `fk_customersOfCompanies_1_idx` (`company_id` ASC),
  INDEX `fk_customersOfCompanies_2_idx` (`customer_id` ASC),
  CONSTRAINT `fk_customersOfCompanies_1`
    FOREIGN KEY (`company_id`)
    REFERENCES `sqltask`.`companies` (`company_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customersOfCompanies_2`
    FOREIGN KEY (`customer_id`)
    REFERENCES `sqltask`.`customers` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

