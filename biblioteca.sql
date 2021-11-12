-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema biblioteca
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema biblioteca
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `biblioteca` DEFAULT CHARACTER SET utf8 ;
USE `biblioteca` ;

-- -----------------------------------------------------
-- Table `biblioteca`.`Autor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`Autor` (
  `idAutor` INT NOT NULL,
  `nombre_apellido` VARCHAR(45) NOT NULL,
  `nombre_fantasia` VARCHAR(45) NULL,
  `fecha_nacimiento` DATE NULL,
  `biografia` VARCHAR(1000) NULL,
  PRIMARY KEY (`idAutor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`Libro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`Libro` (
  `id_libro` INT NOT NULL,
  `titulo` VARCHAR(45) NOT NULL,
  `idioma` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_libro`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`Editorial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`Editorial` (
  `nombre_editorial` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`nombre_editorial`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`Edicion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`Edicion` (
  `ISBN` VARCHAR(13) NOT NULL,
  `indice` VARCHAR(45) NULL,
  `fecha_publicacion` DATE NOT NULL,
  `cant_ejemplares` INT NOT NULL,
  `estanteria` VARCHAR(45) NULL,
  `id_libro` INT NOT NULL,
  PRIMARY KEY (`ISBN`),
  INDEX (`id_libro` ASC) VISIBLE,
  CONSTRAINT `id_libro_edicion`
    FOREIGN KEY (`id_libro`)
    REFERENCES `biblioteca`.`Libro` (`id_libro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`Escribe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`Escribe` (
  `id_autor` INT NOT NULL,
  `id_libro` INT NOT NULL,
  PRIMARY KEY (`id_autor`, `id_libro`),
  INDEX `id_libro_idx` (`id_libro` ASC) VISIBLE,
  CONSTRAINT `id_autor_esc`
    FOREIGN KEY (`id_autor`)
    REFERENCES `biblioteca`.`Autor` (`idAutor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_libro_esc`
    FOREIGN KEY (`id_libro`)
    REFERENCES `biblioteca`.`Libro` (`id_libro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`Publicado_por`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`Publicado_por` (
  `id_libro` INT NOT NULL,
  `nombre_editorial` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_libro`, `nombre_editorial`),
  INDEX `nombre_editorial_idx` (`nombre_editorial` ASC) VISIBLE,
  CONSTRAINT `id_libro_pub`
    FOREIGN KEY (`id_libro`)
    REFERENCES `biblioteca`.`Libro` (`id_libro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `nombre_editorial_pub`
    FOREIGN KEY (`nombre_editorial`)
    REFERENCES `biblioteca`.`Editorial` (`nombre_editorial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`Ejemplar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`Ejemplar` (
  `id_ejemplar` INT NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  `ISBN` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_ejemplar`, `ISBN`),
  INDEX (`ISBN` ASC) VISIBLE,
  CONSTRAINT `ISBN_ej`
    FOREIGN KEY (`ISBN`)
    REFERENCES `biblioteca`.`Edicion` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`Palabra_clave`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`Palabra_clave` (
  `palabra` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`palabra`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`Tema`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`Tema` (
  `nombre_tema` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`nombre_tema`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`Prestamo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`Prestamo` (
  `id_prestamo` INT NOT NULL,
  `fecha_prestamo` DATE NOT NULL,
  `fecha_devolucion` DATE NULL,
  PRIMARY KEY (`id_prestamo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`Lector`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`Lector` (
  `num_lector` INT NOT NULL,
  `nombre_apellido` VARCHAR(45) NOT NULL,
  `CUIL` BIGINT NULL,
  `telefono` BIGINT NULL,
  PRIMARY KEY (`num_lector`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`Docente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`Docente` (
  `num_lector` INT NOT NULL,
  PRIMARY KEY (`num_lector`),
  CONSTRAINT `num_lector_doc`
    FOREIGN KEY (`num_lector`)
    REFERENCES `biblioteca`.`Lector` (`num_lector`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`Universitario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`Universitario` (
  `num_lector` INT NOT NULL,
  `libreta_universitaria` VARCHAR(45) NULL,
  PRIMARY KEY (`num_lector`),
  CONSTRAINT `num_lector_uni`
    FOREIGN KEY (`num_lector`)
    REFERENCES `biblioteca`.`Lector` (`num_lector`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`Alumno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`Alumno` (
  `num_lector` INT NOT NULL,
  PRIMARY KEY (`num_lector`),
  CONSTRAINT `num_lector_alum`
    FOREIGN KEY (`num_lector`)
    REFERENCES `biblioteca`.`Universitario` (`num_lector`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`Egresado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`Egresado` (
  `num_lector` INT NOT NULL,
  `fecha_egreso` DATE NOT NULL,
  PRIMARY KEY (`num_lector`),
  CONSTRAINT `num_lector_egr`
    FOREIGN KEY (`num_lector`)
    REFERENCES `biblioteca`.`Universitario` (`num_lector`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`Materia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`Materia` (
  `cod_materia` VARCHAR(5) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cod_materia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`Contiene`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`Contiene` (
  `ISBN` VARCHAR(13) NOT NULL,
  `palabra` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ISBN`, `palabra`),
  INDEX `palabra_idx` (`palabra` ASC) VISIBLE,
  CONSTRAINT `ISBN_cont`
    FOREIGN KEY (`ISBN`)
    REFERENCES `biblioteca`.`Edicion` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `palabra_cont`
    FOREIGN KEY (`palabra`)
    REFERENCES `biblioteca`.`Palabra_clave` (`palabra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`Trata`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`Trata` (
  `ISBN` VARCHAR(13) NOT NULL,
  `nombre_tema` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ISBN`, `nombre_tema`),
  INDEX `nombre_tema_idx` (`nombre_tema` ASC) VISIBLE,
  CONSTRAINT `ISBN_trata`
    FOREIGN KEY (`ISBN`)
    REFERENCES `biblioteca`.`Edicion` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `nombre_tema_trata`
    FOREIGN KEY (`nombre_tema`)
    REFERENCES `biblioteca`.`Tema` (`nombre_tema`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`Es_retirado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`Es_retirado` (
  `id_ejemplar` INT NOT NULL,
  `id_prestamo` INT NOT NULL,
  PRIMARY KEY (`id_ejemplar`, `id_prestamo`),
  INDEX `id_prestamo_idx` (`id_prestamo` ASC) VISIBLE,
  CONSTRAINT `id_ejemplar_ret`
    FOREIGN KEY (`id_ejemplar`)
    REFERENCES `biblioteca`.`Ejemplar` (`id_ejemplar`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_prestamo_ret`
    FOREIGN KEY (`id_prestamo`)
    REFERENCES `biblioteca`.`Prestamo` (`id_prestamo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`Realizado_por`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`Realizado_por` (
  `id_prestamo` INT NOT NULL,
  `num_lector` INT NOT NULL,
  PRIMARY KEY (`id_prestamo`, `num_lector`),
  INDEX `num_lector_idx` (`num_lector` ASC) VISIBLE,
  CONSTRAINT `id_prestamo_re`
    FOREIGN KEY (`id_prestamo`)
    REFERENCES `biblioteca`.`Prestamo` (`id_prestamo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `num_lector_re`
    FOREIGN KEY (`num_lector`)
    REFERENCES `biblioteca`.`Lector` (`num_lector`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`Es_dictada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`Es_dictada` (
  `cod_materia` VARCHAR(5) NOT NULL,
  `num_lector` INT NOT NULL,
  PRIMARY KEY (`cod_materia`, `num_lector`),
  INDEX `num_lector_idx` (`num_lector` ASC) VISIBLE,
  CONSTRAINT `cod_materia_dic`
    FOREIGN KEY (`cod_materia`)
    REFERENCES `biblioteca`.`Materia` (`cod_materia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `num_lector_dic`
    FOREIGN KEY (`num_lector`)
    REFERENCES `biblioteca`.`Lector` (`num_lector`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`Es_bibliografia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`Es_bibliografia` (
  `id_libro` INT NOT NULL,
  `cod_materia` VARCHAR(5) NOT NULL,
  `obligatoriedad` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`id_libro`, `cod_materia`, `obligatoriedad`),
  INDEX `cod_materia_idx` (`cod_materia` ASC) VISIBLE,
  CONSTRAINT `id_libro_bib`
    FOREIGN KEY (`id_libro`)
    REFERENCES `biblioteca`.`Libro` (`id_libro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cod_materia_bib`
    FOREIGN KEY (`cod_materia`)
    REFERENCES `biblioteca`.`Materia` (`cod_materia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`Es_recomendado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`Es_recomendado` (
  `id_libro` INT NOT NULL,
  `cod_materia` VARCHAR(5) NOT NULL,
  `num_lector` INT NOT NULL,
  PRIMARY KEY (`id_libro`, `cod_materia`, `num_lector`),
  INDEX `cod_materia_idx` (`cod_materia` ASC) VISIBLE,
  INDEX `num_lector_idx` (`num_lector` ASC) VISIBLE,
  CONSTRAINT `id_libro_rec`
    FOREIGN KEY (`id_libro`)
    REFERENCES `biblioteca`.`Libro` (`id_libro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cod_materia_rec`
    FOREIGN KEY (`cod_materia`)
    REFERENCES `biblioteca`.`Es_dictada` (`cod_materia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `num_lector_rec`
    FOREIGN KEY (`num_lector`)
    REFERENCES `biblioteca`.`Es_dictada` (`num_lector`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `biblioteca` ;

-- -----------------------------------------------------
-- procedure prestamo_vencido
-- -----------------------------------------------------

DELIMITER $$
-- USE `biblioteca`$$
-- CREATE PROCEDURE `prestamo_vencido` (fecha date)
-- BEGIN
-- declare limite int;
-- select pre.id_prestamo, lec.*
-- from prestamo pre natural join realizado_por rea natural join lector lec, docente doc
-- where datediff(pre.fecha_prestamo,pre.fecha_devolucion)>limite and datediff(pre.fecha_prestamo,fecha)>=0;
-- if rea.num_lector in(select doc.num_lector from docente doc) then set limite=14;
-- 	else set limite=7;
-- end if;
-- END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
