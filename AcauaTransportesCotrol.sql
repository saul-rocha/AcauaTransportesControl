-- MySQL Script generated by MySQL Workbench
-- Thu Jan  7 09:21:33 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `Estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Estado` ;

CREATE TABLE IF NOT EXISTS `Estado` (
  `id_estado` INT NOT NULL AUTO_INCREMENT,
  `nm_estado` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_estado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Municipio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Municipio` ;

CREATE TABLE IF NOT EXISTS `Municipio` (
  `id_municipio` INT NOT NULL AUTO_INCREMENT,
  `nm_municipio` VARCHAR(100) NOT NULL,
  `Estado_id_estado` INT NOT NULL,
  `Estado_id_estado1` INT NOT NULL,
  PRIMARY KEY (`id_municipio`, `Estado_id_estado`),
  INDEX `fk_Municipio_Estado1_idx` (`Estado_id_estado1` ASC) VISIBLE,
  CONSTRAINT `fk_Municipio_Estado1`
    FOREIGN KEY (`Estado_id_estado1`)
    REFERENCES `Estado` (`id_estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Local de Saída`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Local de Saída` ;

CREATE TABLE IF NOT EXISTS `Local de Saída` (
  `id_local_saida` INT NOT NULL,
  `Municipio_id_municipio` INT NOT NULL,
  `Municipio_Estado_id_estado` INT NOT NULL,
  `Municipio_id_municipio1` INT NOT NULL,
  `Municipio_Estado_id_estado1` INT NOT NULL,
  PRIMARY KEY (`id_local_saida`, `Municipio_id_municipio`, `Municipio_Estado_id_estado`),
  INDEX `fk_Local de Saída_Municipio1_idx` (`Municipio_id_municipio1` ASC, `Municipio_Estado_id_estado1` ASC) VISIBLE,
  CONSTRAINT `fk_Local de Saída_Municipio1`
    FOREIGN KEY (`Municipio_id_municipio1` , `Municipio_Estado_id_estado1`)
    REFERENCES `Municipio` (`id_municipio` , `Estado_id_estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `local_destino`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `local_destino` ;

CREATE TABLE IF NOT EXISTS `local_destino` (
  `id_local_destino` INT NOT NULL,
  `Municipio_id_municipio` INT NOT NULL,
  `Municipio_Estado_id_estado` INT NOT NULL,
  PRIMARY KEY (`id_local_destino`),
  INDEX `fk_local_destino_Municipio1_idx` (`Municipio_id_municipio` ASC, `Municipio_Estado_id_estado` ASC) VISIBLE,
  CONSTRAINT `fk_local_destino_Municipio1`
    FOREIGN KEY (`Municipio_id_municipio` , `Municipio_Estado_id_estado`)
    REFERENCES `Municipio` (`id_municipio` , `Estado_id_estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Motorista`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Motorista` ;

CREATE TABLE IF NOT EXISTS `Motorista` (
  `id_motorista` INT NOT NULL AUTO_INCREMENT,
  `nm_motorista` VARCHAR(100) NOT NULL,
  `cpf_motorista` VARCHAR(11) NOT NULL,
  `rg_motorista` VARCHAR(10) NOT NULL,
  `cnh_motorista` VARCHAR(11) NOT NULL,
  `dt_nascimento` DATE NOT NULL,
  `sexo` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_motorista`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ônibus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Ônibus` ;

CREATE TABLE IF NOT EXISTS `Ônibus` (
  `id_onibus` INT NOT NULL AUTO_INCREMENT,
  `nm_onibus` VARCHAR(100) NOT NULL,
  `placa` VARCHAR(7) NOT NULL,
  `chassi` VARCHAR(17) NOT NULL,
  `marca` VARCHAR(50) NOT NULL,
  `ano_modelo` YEAR(4) NOT NULL,
  PRIMARY KEY (`id_onibus`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Viagem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Viagem` ;

CREATE TABLE IF NOT EXISTS `Viagem` (
  `id_viagem` INT NOT NULL AUTO_INCREMENT,
  `dt_viagem` DATE NOT NULL,
  `valor_viagem` FLOAT NOT NULL DEFAULT 0.0,
  `Motorista_id_motorista` INT NOT NULL,
  `Ônibus_id_onibus` INT NOT NULL,
  `Cliente (Passageiro)_id_cliente` INT NOT NULL,
  `Local de Saída_id_local_saida` INT NOT NULL,
  `Local de Saída_Municipio_id_municipio` INT NOT NULL,
  `Local de Saída_Municipio_Estado_id_estado` INT NOT NULL,
  `local_destino_id_local_destino` INT NOT NULL,
  `Motorista_id_motorista1` INT NOT NULL,
  `Ônibus_id_onibus1` INT NOT NULL,
  PRIMARY KEY (`id_viagem`, `Motorista_id_motorista`, `Ônibus_id_onibus`, `Cliente (Passageiro)_id_cliente`),
  UNIQUE INDEX `id_viagem_UNIQUE` (`id_viagem` ASC) VISIBLE,
  INDEX `fk_Viagem_Local de Saída1_idx` (`Local de Saída_id_local_saida` ASC, `Local de Saída_Municipio_id_municipio` ASC, `Local de Saída_Municipio_Estado_id_estado` ASC) VISIBLE,
  INDEX `fk_Viagem_local_destino1_idx` (`local_destino_id_local_destino` ASC) VISIBLE,
  INDEX `fk_Viagem_Motorista1_idx` (`Motorista_id_motorista1` ASC) VISIBLE,
  INDEX `fk_Viagem_Ônibus1_idx` (`Ônibus_id_onibus1` ASC) VISIBLE,
  CONSTRAINT `fk_Viagem_Local de Saída1`
    FOREIGN KEY (`Local de Saída_id_local_saida` , `Local de Saída_Municipio_id_municipio` , `Local de Saída_Municipio_Estado_id_estado`)
    REFERENCES `Local de Saída` (`id_local_saida` , `Municipio_id_municipio` , `Municipio_Estado_id_estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Viagem_local_destino1`
    FOREIGN KEY (`local_destino_id_local_destino`)
    REFERENCES `local_destino` (`id_local_destino`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Viagem_Motorista1`
    FOREIGN KEY (`Motorista_id_motorista1`)
    REFERENCES `Motorista` (`id_motorista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Viagem_Ônibus1`
    FOREIGN KEY (`Ônibus_id_onibus1`)
    REFERENCES `Ônibus` (`id_onibus`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cliente (Passageiro)`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cliente (Passageiro)` ;

CREATE TABLE IF NOT EXISTS `Cliente (Passageiro)` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nm_cliente` VARCHAR(100) NOT NULL,
  `fone` VARCHAR(11) NOT NULL DEFAULT 'S/N',
  `endereco` VARCHAR(100) NOT NULL DEFAULT 'S/N',
  `dt_nascimento` DATE NOT NULL,
  `sexo` VARCHAR(20) NOT NULL,
  `Viagem_id_viagem` INT NOT NULL,
  `Viagem_Motorista_id_motorista` INT NOT NULL,
  `Viagem_Ônibus_id_onibus` INT NOT NULL,
  `Viagem_Cliente (Passageiro)_id_cliente` INT NOT NULL,
  PRIMARY KEY (`id_cliente`),
  INDEX `fk_Cliente (Passageiro)_Viagem1_idx` (`Viagem_id_viagem` ASC, `Viagem_Motorista_id_motorista` ASC, `Viagem_Ônibus_id_onibus` ASC, `Viagem_Cliente (Passageiro)_id_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente (Passageiro)_Viagem1`
    FOREIGN KEY (`Viagem_id_viagem` , `Viagem_Motorista_id_motorista` , `Viagem_Ônibus_id_onibus` , `Viagem_Cliente (Passageiro)_id_cliente`)
    REFERENCES `Viagem` (`id_viagem` , `Motorista_id_motorista` , `Ônibus_id_onibus` , `Cliente (Passageiro)_id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
