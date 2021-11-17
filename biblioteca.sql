-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema biblioteca
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `biblioteca` ;

-- -----------------------------------------------------
-- Schema biblioteca
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `biblioteca` DEFAULT CHARACTER SET utf8 ;
USE `biblioteca` ;

-- -----------------------------------------------------
-- Table `biblioteca`.`Autor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`Autor` (
  `id_autor` INT NOT NULL,
  `nombre_apellido` VARCHAR(45) NOT NULL,
  `nombre_fantasia` VARCHAR(45) NULL,
  `fecha_nacimiento` DATE NULL,
  `biografia` TINYTEXT NULL,
  PRIMARY KEY (`id_autor`))
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
    REFERENCES `biblioteca`.`Autor` (`id_autor`)
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
    ON UPDATE CASCADE)
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
    ON UPDATE CASCADE)
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
    ON UPDATE CASCADE)
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
    ON UPDATE CASCADE,
  CONSTRAINT `palabra_cont`
    FOREIGN KEY (`palabra`)
    REFERENCES `biblioteca`.`Palabra_clave` (`palabra`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
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
  PRIMARY KEY (`id_libro`, `cod_materia`),
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
-- Placeholder table for view `biblioteca`.`lectores_libros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`lectores_libros` (`num_lector` INT, `id_libro` INT);

-- -----------------------------------------------------
-- procedure Prestamos_vencidos
-- -----------------------------------------------------

DELIMITER $$
USE `biblioteca`$$
CREATE PROCEDURE `Prestamos_vencidos` (fecha date)
BEGIN
SELECT 
    lib.titulo as Libro, ej.ISBN, ej.id_ejemplar, pre.*, lec.*
FROM
    biblioteca.prestamo pre
    inner join biblioteca.realizado_por rea on pre.id_prestamo = rea.id_prestamo
    inner join Lector lec on rea.num_lector = lec.num_lector
    inner join Es_retirado ret on ret.id_prestamo = pre.id_prestamo
    inner join Ejemplar ej on ej.id_ejemplar = ret.id_ejemplar
    inner join Edicion ed on ed.ISBN = ej.ISBN
    inner join Libro lib on lib.id_libro = ed.id_libro
WHERE
	((rea.num_lector not in (select doc.num_lector from docente doc) and DATEDIFF(pre.fecha_devolucion, pre.fecha_prestamo) > 7 ) 
    OR DATEDIFF(pre.fecha_devolucion, pre.fecha_prestamo) > 14)
	AND DATEDIFF(fecha, pre.fecha_prestamo) >= 0;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function CHECK_NUM_EJEMPLARES
-- -----------------------------------------------------

DELIMITER $$
USE `biblioteca`$$
CREATE FUNCTION CHECK_NUM_EJEMPLARES (isbn VARCHAR(13))
RETURNS INT

BEGIN
   declare num int;
   SELECT cant_ejemplares INTO num FROM Edicion WHERE Edicion.ISBN = isbn;
   return num;
END;$$

DELIMITER ;

-- -----------------------------------------------------
-- function HAY_DISPONIBLE
-- -----------------------------------------------------

DELIMITER $$
USE `biblioteca`$$
CREATE FUNCTION HAY_DISPONIBLE (isbn VARCHAR(13))
RETURNS BOOLEAN

BEGIN
   declare res boolean;
   IF EXISTS( SELECT estado FROM Ejemplar WHERE Ejemplar.ISBN = isbn AND Ejemplar.estado = 'Disponible' ) THEN
	BEGIN
		SET res = true;
	END;
   ELSE
    BEGIN
		SET res = false;
    END;
   END IF;
   return res;
END;$$

DELIMITER ;

-- -----------------------------------------------------
-- function CHECK_PRESTAMO
-- -----------------------------------------------------

DELIMITER $$
USE `biblioteca`$$
CREATE FUNCTION `CHECK_PRESTAMO` (ID_EJEMPLAR INT, ID_PRESTAMO INT)
RETURNS BOOLEAN
BEGIN
    DECLARE res BOOLEAN;
	DECLARE ISBN_EJEMPLAR VARCHAR(13);
    SELECT ISBN INTO ISBN_EJEMPLAR FROM Ejemplar WHERE ID_EJEMPLAR=Ejemplar.id_ejemplar;
	IF EXISTS( 
    SELECT id_ejemplar
    FROM Es_retirado 
    INNER JOIN Ejemplar ON Es_retirado.id_ejemplar = Ejemplar.id_ejemplar
    WHERE Es_retirado.id_prestamo = ID_PRESTAMO AND Ejemplar.ISBN = ISBN_EJEMPLAR) THEN
    BEGIN
		SET res = false;
    END;
    ELSE 
     BEGIN
		SET res = true;
	 END;
    END IF;
    return res;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure CantLibrosTitulo
-- -----------------------------------------------------

DELIMITER $$
USE `biblioteca`$$
CREATE PROCEDURE `CantLibrosTitulo` ()
BEGIN
	SELECT Libro.titulo "Titulo del libro",month(fecha_prestamo) "Mes", YEAR (fecha_prestamo) "Anio", count(*) "Cantidad de libros prestados"
    FROM Prestamo
    inner join Es_retirado on (prestamo.id_prestamo = Es_retirado.id_prestamo)
    inner join Ejemplar on (Ejemplar.id_ejemplar = Es_retirado.id_ejemplar)
    inner join Edicion on (Edicion.ISBN = Ejemplar.ISBN)
    inner join Libro on (Libro.id_libro = Edicion.id_libro)
    group by month(fecha_prestamo),year(fecha_prestamo),Libro.titulo;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure CantLibrosAutor
-- -----------------------------------------------------

DELIMITER $$
USE `biblioteca`$$
CREATE PROCEDURE `CantLibrosAutor` ()
BEGIN
	SELECT Autor.nombre_apellido "Autor",month(fecha_prestamo) "Mes", YEAR (fecha_prestamo) "Anio", count(*) "Cantidad de libros prestados"
    FROM Prestamo
    inner join Es_retirado on (prestamo.id_prestamo = Es_retirado.id_prestamo)
    inner join Ejemplar on (Ejemplar.id_ejemplar = Es_retirado.id_ejemplar)
    inner join Edicion on (Edicion.ISBN = Ejemplar.ISBN)
    inner join Libro on (Libro.id_libro = Edicion.id_libro)
    inner join Escribe on (Escribe.id_libro = Libro.id_libro)
    inner join Autor on (Autor.id_autor = Escribe.id_autor)
    group by month(fecha_prestamo),year(fecha_prestamo),Autor.id_autor;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure CantLibrosEditorial
-- -----------------------------------------------------

DELIMITER $$
USE `biblioteca`$$
CREATE PROCEDURE `CantLibrosEditorial` ()
BEGIN
	SELECT Publicado_por.nombre_editorial "Editorial",month(fecha_prestamo) "Mes", YEAR (fecha_prestamo) "Anio", count(*) "Cantidad de libros prestados"
    FROM Prestamo
    inner join Es_retirado on (prestamo.id_prestamo = Es_retirado.id_prestamo)
    inner join Ejemplar on (Ejemplar.id_ejemplar = Es_retirado.id_ejemplar)
    inner join Edicion on (Edicion.ISBN = Ejemplar.ISBN)
    inner join Libro on (Libro.id_libro = Edicion.id_libro)
    inner join Publicado_por on (Publicado_por.id_libro = Libro.id_libro)
    group by month(fecha_prestamo),year(fecha_prestamo),Publicado_por.id_libro;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure CantLibrosTema
-- -----------------------------------------------------

DELIMITER $$
USE `biblioteca`$$
CREATE PROCEDURE `CantLibrosTema` ()
BEGIN
	SELECT  Trata.nombre_tema "Tema",month(fecha_prestamo) "Mes", YEAR (fecha_prestamo) "Anio", count(*) "Cantidad de libros prestados"
    FROM Prestamo
    inner join Es_retirado on (prestamo.id_prestamo = Es_retirado.id_prestamo)
    inner join Ejemplar on (Ejemplar.id_ejemplar = Es_retirado.id_ejemplar)
    inner join Edicion on (Edicion.ISBN = Ejemplar.ISBN)
    inner join Trata on (Trata.ISBN = Edicion.ISBN)
    group by month(fecha_prestamo),year(fecha_prestamo),Trata.nombre_tema;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function vencido
-- -----------------------------------------------------

DELIMITER $$
USE `biblioteca`$$
CREATE FUNCTION `vencido` (idPrestamo int)
RETURNS tinytext
BEGIN
	declare estado_venc tinytext;
	declare fecha_venc date;
SELECT DEVOLUCION(idPrestamo) INTO fecha_venc;
	if(idPrestamo is null) then set estado_venc=null;
    else
    begin
    if(datediff(curdate(), fecha_venc)>0) then
    set estado_venc='Prestamo no vencido';
    else set estado_venc='Prestamo vencido';
    end if;
    end;
    end if;
    return estado_venc;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function devolucion
-- -----------------------------------------------------

DELIMITER $$
USE `biblioteca`$$
CREATE function `devolucion` (idPrestamo int)
RETURNS date
BEGIN
	declare fecha_dev date ;
    select fecha_prestamo 
    into fecha_dev
    from Prestamo
    where Prestamo.id_prestamo = idPrestamo;
    if exists(SELECT 
    rea.*
FROM
    prestamo pre
    inner join realizado_por rea on pre.id_prestamo = rea.id_prestamo
WHERE rea.num_lector not in (select doc.num_lector from docente doc) and pre.id_prestamo = idPrestamo) then
set fecha_dev = adddate(fecha_dev,7);
else set fecha_dev = adddate(fecha_dev,14);
end if;
return fecha_dev;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Ejemplares_autor
-- -----------------------------------------------------

DELIMITER $$
USE `biblioteca`$$
CREATE PROCEDURE `Ejemplares_autor`(nombre_autor varchar(45))
BEGIN
	declare idPrestamo int;
    declare fecha_prestamo date default null;
	SELECT lib.titulo, ed.estanteria, ej.estado, devolucion(ret.id_prestamo) as 'fecha de devolucion', vencido(ret.id_prestamo) as 'estado de prestamo'
    FROM Ejemplar ej
        left join Es_retirado ret on ret.id_ejemplar = ej.id_ejemplar
        inner join Edicion ed on ej.ISBN = ed.ISBN
        inner join Escribe es on es.id_libro = ed.id_libro
        inner join Autor au on au.id_autor = es.id_autor
        inner join Libro lib on lib.id_libro = ed.id_libro
    WHERE au.nombre_apellido = nombre_autor;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure lectores_avisados
-- -----------------------------------------------------

DELIMITER $$
USE `biblioteca`$$
CREATE PROCEDURE `lectores_avisados` (IDLIBRO INT)
BEGIN
	declare autor_act int;
    
    -- autor del libro dado
    select Autor.id_autor into autor_act from Autor  
    inner join Escribe on (Autor.id_autor = Escribe.id_autor)
    where Escribe.id_libro = IDLIBRO;
    
    -- busco que no exista un libro que no haya retirado 
    SELECT Lector.num_lector
    FROM Lector
    WHERE NOT EXISTS (
		SELECT Libro.id_libro
		FROM  Libro
		inner join Escribe on (Libro.id_libro = Escribe.id_libro)
		where Escribe.id_autor = autor_act AND
        NOT EXISTS (SELECT * from lectores_libros where lectores_libros.num_lector = Lector.num_lector)
	);

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Ejemplares_tema
-- -----------------------------------------------------

DELIMITER $$
USE `biblioteca`$$
CREATE PROCEDURE `Ejemplares_tema`(tema varchar(45))
BEGIN
	declare idPrestamo int;
    declare fecha_prestamo date default null;
	SELECT lib.titulo, ed.estanteria, ej.estado, devolucion(ret.id_prestamo) as 'fecha de devolucion', vencido(ret.id_prestamo) as 'estado de prestamo'
    FROM Ejemplar ej
        left join Es_retirado ret on ret.id_ejemplar = ej.id_ejemplar
        inner join Edicion ed on ej.ISBN = ed.ISBN
        inner join Escribe es on es.id_libro = ed.id_libro
        inner join Libro lib on lib.id_libro = ed.id_libro
        inner join Trata tr on tr.ISBN = ej.ISBN
    WHERE tr.nombre_tema = tema;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Ejemplares_recomendacion_profesor
-- -----------------------------------------------------

DELIMITER $$
USE `biblioteca`$$
CREATE PROCEDURE `Ejemplares_recomendacion_profesor`(nombre_profesor varchar(45))
BEGIN
	declare idPrestamo int;
    declare fecha_prestamo date default null;
	SELECT lib.titulo, ed.estanteria, ej.estado, devolucion(ret.id_prestamo) as 'fecha de devolucion', vencido(ret.id_prestamo) as 'estado de prestamo'
    FROM Ejemplar ej
        left join Es_retirado ret on ret.id_ejemplar = ej.id_ejemplar
        inner join Edicion ed on ej.ISBN = ed.ISBN
        inner join Escribe es on es.id_libro = ed.id_libro
        inner join Libro lib on lib.id_libro = ed.id_libro
        inner join Es_recomendado rec on rec.id_libro = ed.id_libro
        inner join Lector prof on prof.num_lector = rec.num_lector
    WHERE prof.nombre_apellido = nombre_profesor;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `biblioteca`.`lectores_libros`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `biblioteca`.`lectores_libros`;
USE `biblioteca`;
CREATE  OR REPLACE VIEW `lectores_libros` AS
	SELECT Lector.num_lector, Libro.id_libro
    FROM Lector
    inner join Realizado_por on (Lector.num_lector = Realizado_por.num_lector)
    inner join Prestamo on (Realizado_por.id_prestamo =Prestamo.id_prestamo)
    inner join Es_retirado on (prestamo.id_prestamo = Es_retirado.id_prestamo)
	inner join Ejemplar on (Ejemplar.id_ejemplar = Es_retirado.id_ejemplar)
    inner join Edicion on (Edicion.ISBN = Ejemplar.ISBN)
	inner join Libro on (Libro.id_libro = Edicion.id_libro);
USE `biblioteca`;

DELIMITER $$
USE `biblioteca`$$
CREATE DEFINER = CURRENT_USER TRIGGER `biblioteca`.`Ejemplar_BEFORE_UPDATE` BEFORE UPDATE ON `Ejemplar` FOR EACH ROW
BEGIN
-- Si solo hay un ejemplar de una determinada edicion el mismo no puede ser prestado
-- LLAMAR A CHECK_NUM_EJEMPLARES SI NUM > 1 SE LLAMA A HAY_DISPONIBLE SI DA TRUE SE HACE EL UPDATE
-- SI DA FALSE O NUM<1 ERROR
	DECLARE NUM INT;
    DECLARE RES BOOLEAN;
	SELECT CHECK_NUM_EJEMPLARES(OLD.ISBN) INTO NUM;
    SELECT HAY_DISPONIBLE(OLD.ISBN) INTO RES;
    IF(NUM<=1 AND RES=false) THEN
		BEGIN 
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error no hay suficientes ejemplares de esa edicion';
		END;
    END IF;
END$$

USE `biblioteca`$$
CREATE DEFINER = CURRENT_USER TRIGGER `biblioteca`.`Es_retirado_BEFORE_INSERT` BEFORE INSERT ON `Es_retirado` FOR EACH ROW
BEGIN
	DECLARE res BOOLEAN;
	SELECT CHECK_PRESTAMO(NEW.id_ejemplar, NEW.id_prestamo) INTO res;
    IF res=false THEN
		BEGIN 
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error no es posible prestar mas de un ejemplar de la misma edicion';
		END;
    END IF;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `biblioteca`.`Autor`
-- -----------------------------------------------------
START TRANSACTION;
USE `biblioteca`;
INSERT INTO `biblioteca`.`Autor` (`id_autor`, `nombre_apellido`, `nombre_fantasia`, `fecha_nacimiento`, `biografia`) VALUES (001, 'Charles Dickens', 'Dickens', '1970-06-09', '\'Charles John Huffam Dickens fue un escritor británico.\'');
INSERT INTO `biblioteca`.`Autor` (`id_autor`, `nombre_apellido`, `nombre_fantasia`, `fecha_nacimiento`, `biografia`) VALUES (002, 'Homero', 'Homero', NULL, '\'Homero es el nombre dado a quien se atribuye la autoría de la Ilíada y la Odisea.\'');
INSERT INTO `biblioteca`.`Autor` (`id_autor`, `nombre_apellido`, `nombre_fantasia`, `fecha_nacimiento`, `biografia`) VALUES (003, 'Herman Melville', 'H.Melville', '1819-08-01', '\'Herman Melville ​ fue un escritor, novelista, poeta y ensayista estadounidense\'');
INSERT INTO `biblioteca`.`Autor` (`id_autor`, `nombre_apellido`, `nombre_fantasia`, `fecha_nacimiento`, `biografia`) VALUES (004, 'Emily Bronte', 'Ellis Bell', '1818-07-30', '\'Emily Jane Brontë fue una escritora británica.\'');
INSERT INTO `biblioteca`.`Autor` (`id_autor`, `nombre_apellido`, `nombre_fantasia`, `fecha_nacimiento`, `biografia`) VALUES (005, 'Jane Austen', NULL, '1775-12-16', '\'Jane Austen fue una novelista británica que vivió durante la época georgiana.\'');
INSERT INTO `biblioteca`.`Autor` (`id_autor`, `nombre_apellido`, `nombre_fantasia`, `fecha_nacimiento`, `biografia`) VALUES (006, 'Madeline Miller', NULL, '1978-07-24', '\'Madeline Miller, es una novelista y profesora estadounidense.\'');
INSERT INTO `biblioteca`.`Autor` (`id_autor`, `nombre_apellido`, `nombre_fantasia`, `fecha_nacimiento`, `biografia`) VALUES (007, 'Julio Cortazar', NULL, '1914-08-26', '\'Julio Florencio Cortázar fue un escritor y traductor argentino.​\'');
INSERT INTO `biblioteca`.`Autor` (`id_autor`, `nombre_apellido`, `nombre_fantasia`, `fecha_nacimiento`, `biografia`) VALUES (008, 'Jorge Luis Borges', NULL, '1899-08-24', '\'Jorge Luis Borges, fue un destacado escritor de cuentos, poemas y ensayos argentino.​\'');
INSERT INTO `biblioteca`.`Autor` (`id_autor`, `nombre_apellido`, `nombre_fantasia`, `fecha_nacimiento`, `biografia`) VALUES (009, 'Robert Resnick', NULL, '1923-01-11', '\'Robert Resnick fue un educador de física y autor de libros de texto de física.\'');
INSERT INTO `biblioteca`.`Autor` (`id_autor`, `nombre_apellido`, `nombre_fantasia`, `fecha_nacimiento`, `biografia`) VALUES (010, 'Kenneth S. Krane', NULL, NULL, NULL);
INSERT INTO `biblioteca`.`Autor` (`id_autor`, `nombre_apellido`, `nombre_fantasia`, `fecha_nacimiento`, `biografia`) VALUES (011, 'Michael Halliday', NULL, '1925-04-13', '\'Michael Halliday​ fue un lingüista, filósofo, pedagogo y profesor universitario.\'');
INSERT INTO `biblioteca`.`Autor` (`id_autor`, `nombre_apellido`, `nombre_fantasia`, `fecha_nacimiento`, `biografia`) VALUES (012, 'Ramez Elmasri', NULL, '1950-10-20', '\'Ramez A. Elmasri es un científico informático y un destacado investigador.\'');
INSERT INTO `biblioteca`.`Autor` (`id_autor`, `nombre_apellido`, `nombre_fantasia`, `fecha_nacimiento`, `biografia`) VALUES (013, 'Shamkant B. Navathe', NULL, NULL, '\'Shamkant B. Navathe es un destacado investigador en el campo de las bases de datos.\'');
INSERT INTO `biblioteca`.`Autor` (`id_autor`, `nombre_apellido`, `nombre_fantasia`, `fecha_nacimiento`, `biografia`) VALUES (014, 'Abraham Silberschatz', NULL, '1947-05-01', '\'Abraham Silberschatz es un doctorado en Informática graduado en 1976.\'');
INSERT INTO `biblioteca`.`Autor` (`id_autor`, `nombre_apellido`, `nombre_fantasia`, `fecha_nacimiento`, `biografia`) VALUES (015, 'Henry F. Korth', NULL, NULL, NULL);
INSERT INTO `biblioteca`.`Autor` (`id_autor`, `nombre_apellido`, `nombre_fantasia`, `fecha_nacimiento`, `biografia`) VALUES (016, 'S. Sudarshan', '', NULL, NULL);
INSERT INTO `biblioteca`.`Autor` (`id_autor`, `nombre_apellido`, `nombre_fantasia`, `fecha_nacimiento`, `biografia`) VALUES (017, 'Isabel Allende', NULL, '1942-08-02', '\'Isabel Allende​ es una escritora chilena con nacionalidad estadounidense.\'');
INSERT INTO `biblioteca`.`Autor` (`id_autor`, `nombre_apellido`, `nombre_fantasia`, `fecha_nacimiento`, `biografia`) VALUES (018, 'Ernesto Sabato', NULL, '1911-06-24', '\'Ernesto Sabato​​ fue un ensayista, novelista, fisico y pintor argentino.\'');
INSERT INTO `biblioteca`.`Autor` (`id_autor`, `nombre_apellido`, `nombre_fantasia`, `fecha_nacimiento`, `biografia`) VALUES (019, 'Ana Frank', NULL, '1929-06-12', '\'Ana Frank, ​​​ fue una niña alemana con ascendencia judía conocida gracias al Diario de Ana Frank\'');
INSERT INTO `biblioteca`.`Autor` (`id_autor`, `nombre_apellido`, `nombre_fantasia`, `fecha_nacimiento`, `biografia`) VALUES (020, 'H. G. Wells', NULL, '1866-09-21', '\'H. G. Wells es considerado uno de los padres creadores de la ciencia ficción.\'');
INSERT INTO `biblioteca`.`Autor` (`id_autor`, `nombre_apellido`, `nombre_fantasia`, `fecha_nacimiento`, `biografia`) VALUES (021, 'Victor Hugo', NULL, '1802-02-26', '\'Victor Hugo fue un escritor, crítico, pintor y académico francés. \'');
INSERT INTO `biblioteca`.`Autor` (`id_autor`, `nombre_apellido`, `nombre_fantasia`, `fecha_nacimiento`, `biografia`) VALUES (022, 'William Shakespeare', NULL, '1564-04-01', '\'William Shakespeare ​ fue un dramaturgo, poeta y actor inglés.\'');
INSERT INTO `biblioteca`.`Autor` (`id_autor`, `nombre_apellido`, `nombre_fantasia`, `fecha_nacimiento`, `biografia`) VALUES (023, 'Sylvia Plath', NULL, '1932-10-27', '\'Sylvia Plath fue una escritora y poeta estadounidense.​\'');

COMMIT;


-- -----------------------------------------------------
-- Data for table `biblioteca`.`Libro`
-- -----------------------------------------------------
START TRANSACTION;
USE `biblioteca`;
INSERT INTO `biblioteca`.`Libro` (`id_libro`, `titulo`, `idioma`) VALUES (001, 'Orgullo y prejuicio', 'ESP');
INSERT INTO `biblioteca`.`Libro` (`id_libro`, `titulo`, `idioma`) VALUES (002, 'Cumbres borrascosas', 'ESP');
INSERT INTO `biblioteca`.`Libro` (`id_libro`, `titulo`, `idioma`) VALUES (003, 'Odisea', 'ESP');
INSERT INTO `biblioteca`.`Libro` (`id_libro`, `titulo`, `idioma`) VALUES (004, 'Moby Dick', 'ESP');
INSERT INTO `biblioteca`.`Libro` (`id_libro`, `titulo`, `idioma`) VALUES (005, 'Oliver Twist', 'ESP');
INSERT INTO `biblioteca`.`Libro` (`id_libro`, `titulo`, `idioma`) VALUES (006, 'Emma', 'ENG');
INSERT INTO `biblioteca`.`Libro` (`id_libro`, `titulo`, `idioma`) VALUES (007, 'The Song of Achilles', 'ENG');
INSERT INTO `biblioteca`.`Libro` (`id_libro`, `titulo`, `idioma`) VALUES (008, 'Circe', 'ESP');
INSERT INTO `biblioteca`.`Libro` (`id_libro`, `titulo`, `idioma`) VALUES (009, 'Rayuela', 'ESP');
INSERT INTO `biblioteca`.`Libro` (`id_libro`, `titulo`, `idioma`) VALUES (010, 'Bestiario', 'ESP');
INSERT INTO `biblioteca`.`Libro` (`id_libro`, `titulo`, `idioma`) VALUES (011, 'Ficciones', 'ESP');
INSERT INTO `biblioteca`.`Libro` (`id_libro`, `titulo`, `idioma`) VALUES (012, 'Labyrinths', 'ENG');
INSERT INTO `biblioteca`.`Libro` (`id_libro`, `titulo`, `idioma`) VALUES (013, 'La biblioteca de Babel', 'ESP');
INSERT INTO `biblioteca`.`Libro` (`id_libro`, `titulo`, `idioma`) VALUES (014, 'Fisica 1', 'ESP');
INSERT INTO `biblioteca`.`Libro` (`id_libro`, `titulo`, `idioma`) VALUES (015, 'Fisica 2', 'ESP');
INSERT INTO `biblioteca`.`Libro` (`id_libro`, `titulo`, `idioma`) VALUES (016, 'Fundamentals of Database Systems', 'ENG');
INSERT INTO `biblioteca`.`Libro` (`id_libro`, `titulo`, `idioma`) VALUES (017, 'Database System Concepts', 'ENG');
INSERT INTO `biblioteca`.`Libro` (`id_libro`, `titulo`, `idioma`) VALUES (018, 'La casa de los espíritus', 'ESP');
INSERT INTO `biblioteca`.`Libro` (`id_libro`, `titulo`, `idioma`) VALUES (019, 'Paula', 'ESP');
INSERT INTO `biblioteca`.`Libro` (`id_libro`, `titulo`, `idioma`) VALUES (020, 'Eva Luna', 'ESP');
INSERT INTO `biblioteca`.`Libro` (`id_libro`, `titulo`, `idioma`) VALUES (021, 'Sobre heroes y tumbas', 'ESP');
INSERT INTO `biblioteca`.`Libro` (`id_libro`, `titulo`, `idioma`) VALUES (022, 'El exterminador', 'ESP');
INSERT INTO `biblioteca`.`Libro` (`id_libro`, `titulo`, `idioma`) VALUES (023, 'El tunel', 'ESP');
INSERT INTO `biblioteca`.`Libro` (`id_libro`, `titulo`, `idioma`) VALUES (024, 'Diario de Ana Frank', 'ESP');
INSERT INTO `biblioteca`.`Libro` (`id_libro`, `titulo`, `idioma`) VALUES (025, 'El hombre invisible', 'ESP');
INSERT INTO `biblioteca`.`Libro` (`id_libro`, `titulo`, `idioma`) VALUES (026, 'Nuestra Señora de Paris', 'ESP');
INSERT INTO `biblioteca`.`Libro` (`id_libro`, `titulo`, `idioma`) VALUES (027, 'El rey Lear', 'ESP');
INSERT INTO `biblioteca`.`Libro` (`id_libro`, `titulo`, `idioma`) VALUES (028, 'Hamlet', 'ESP');
INSERT INTO `biblioteca`.`Libro` (`id_libro`, `titulo`, `idioma`) VALUES (029, 'Romeo y Julieta', 'ESP');
INSERT INTO `biblioteca`.`Libro` (`id_libro`, `titulo`, `idioma`) VALUES (030, 'Macbeth', 'ESP');
INSERT INTO `biblioteca`.`Libro` (`id_libro`, `titulo`, `idioma`) VALUES (031, 'La tempestad', 'ESP');

COMMIT;


-- -----------------------------------------------------
-- Data for table `biblioteca`.`Editorial`
-- -----------------------------------------------------
START TRANSACTION;
USE `biblioteca`;
INSERT INTO `biblioteca`.`Editorial` (`nombre_editorial`) VALUES ('Editorial Alma');
INSERT INTO `biblioteca`.`Editorial` (`nombre_editorial`) VALUES ('Pluton Ediciones');
INSERT INTO `biblioteca`.`Editorial` (`nombre_editorial`) VALUES ('Anaya');
INSERT INTO `biblioteca`.`Editorial` (`nombre_editorial`) VALUES ('Alfaguara');
INSERT INTO `biblioteca`.`Editorial` (`nombre_editorial`) VALUES ('Scholastic');
INSERT INTO `biblioteca`.`Editorial` (`nombre_editorial`) VALUES ('BLOOMSBURY PUBLISHING');
INSERT INTO `biblioteca`.`Editorial` (`nombre_editorial`) VALUES ('Catedra');
INSERT INTO `biblioteca`.`Editorial` (`nombre_editorial`) VALUES ('Editorial Continental');
INSERT INTO `biblioteca`.`Editorial` (`nombre_editorial`) VALUES ('Pearson');
INSERT INTO `biblioteca`.`Editorial` (`nombre_editorial`) VALUES ('McGrawHill Inc');
INSERT INTO `biblioteca`.`Editorial` (`nombre_editorial`) VALUES ('Sudamericana ');
INSERT INTO `biblioteca`.`Editorial` (`nombre_editorial`) VALUES ('Sur');
INSERT INTO `biblioteca`.`Editorial` (`nombre_editorial`) VALUES ('GUADAL');
INSERT INTO `biblioteca`.`Editorial` (`nombre_editorial`) VALUES ('EDELVIVES');

COMMIT;


-- -----------------------------------------------------
-- Data for table `biblioteca`.`Edicion`
-- -----------------------------------------------------
START TRANSACTION;
USE `biblioteca`;
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9788415618782', NULL, '2018-02-14', 3, '101', 001);
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9788415618898', NULL, '2018-07-01', 1, '101', 002);
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9788415089728', NULL, '2015-01-01', 2, '101', 003);
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9788469847978', NULL, '2019-02-01', 1, '101', 004);
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9788420457505', NULL, '1997-01-01', 1, '101', 005);
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9781407172668', NULL, '2017-03-02', 1, '101', 006);
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9780062060624', NULL, '2012-08-28', 2, '102', 007);
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9781408821985', NULL, '2012-09-01', 1, '102', 007);
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9788491814122', NULL, '2019-01-01', 1, '102', 008);
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9788437604572', NULL, '1963-06-28', 2, '103', 009);
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9788437624747', NULL, '1965-10-04', 2, '103', 009);
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9788420416571', NULL, '1951-10-01', 1, '103', 010);
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9788466302272', NULL, '2010-08-20', 2, '103', 010);
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9789875666474', NULL, '2011-01-01', 1, '104', 011);
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9788499089508', NULL, '2017-01-01', 1, '104', 011);
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9780140093131', NULL, '1962-08-08', 3, '104', 012);
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9788420638751', NULL, '1941-05-12', 3, '104', 013);
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9789702402572', NULL, '2004-01-01', 4, '201', 014);
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9789702403265', NULL, '2003-01-01', 3, '201', 015);
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9780133970777', NULL, '2016-02-01', 2, '202', 016);
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9780073523323', NULL, '2002-04-01', 1, '202', 017);
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9780060951306', NULL, '1982-06-10', 2, '301', 018);
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9780060172534', NULL, '1994-05-11', 1, '301', 019);
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9780060951283', NULL, '1987-05-01', 1, '301', 020);
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9789802763818', NULL, '2003-06-22', 2, '301', 021);
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9788432211386', NULL, '2002-06-11', 2, '301', 022);
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9788437600895', NULL, '2011-06-14', 2, '301', 023);
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9788432215148', NULL, '1997-07-04', 1, '301', 023);
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9789873201813', NULL, '2015-09-02', 4, '302', 024);
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9789872933005', NULL, '2003-03-07', 2, '302', 025);
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9788426390912', NULL, '2013-05-02', 1, '302', 026);
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9789500305563', NULL, '2000-08-01', 2, '302', 027);
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9788441425071', NULL, '2013-05-01', 1, '302', 028);
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9789872121358', NULL, '2004-07-03', 1, '302', 029);
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9789872121334', NULL, '2003-05-01', 1, '302', 030);
INSERT INTO `biblioteca`.`Edicion` (`ISBN`, `indice`, `fecha_publicacion`, `cant_ejemplares`, `estanteria`, `id_libro`) VALUES ('9789871165322', NULL, '2005-04-03', 2, '302', 031);

COMMIT;


-- -----------------------------------------------------
-- Data for table `biblioteca`.`Escribe`
-- -----------------------------------------------------
START TRANSACTION;
USE `biblioteca`;
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (001, 005);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (002, 003);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (003, 004);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (004, 002);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (005, 001);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (005, 006);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (009, 014);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (010, 014);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (011, 014);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (006, 007);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (006, 008);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (007, 009);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (007, 010);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (008, 011);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (008, 012);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (008, 013);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (009, 015);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (010, 015);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (011, 015);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (012, 016);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (013, 016);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (014, 017);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (015, 017);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (016, 017);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (017, 018);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (017, 019);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (017, 020);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (018, 021);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (018, 022);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (018, 023);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (019, 024);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (020, 025);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (021, 026);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (022, 027);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (022, 028);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (022, 029);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (022, 030);
INSERT INTO `biblioteca`.`Escribe` (`id_autor`, `id_libro`) VALUES (022, 031);

COMMIT;


-- -----------------------------------------------------
-- Data for table `biblioteca`.`Publicado_por`
-- -----------------------------------------------------
START TRANSACTION;
USE `biblioteca`;
INSERT INTO `biblioteca`.`Publicado_por` (`id_libro`, `nombre_editorial`) VALUES (001, 'Editorial Alma');
INSERT INTO `biblioteca`.`Publicado_por` (`id_libro`, `nombre_editorial`) VALUES (002, 'Editorial Alma');
INSERT INTO `biblioteca`.`Publicado_por` (`id_libro`, `nombre_editorial`) VALUES (003, 'Pluton Ediciones');
INSERT INTO `biblioteca`.`Publicado_por` (`id_libro`, `nombre_editorial`) VALUES (004, 'Anaya');
INSERT INTO `biblioteca`.`Publicado_por` (`id_libro`, `nombre_editorial`) VALUES (005, 'Alfaguara');
INSERT INTO `biblioteca`.`Publicado_por` (`id_libro`, `nombre_editorial`) VALUES (006, 'Scholastic');
INSERT INTO `biblioteca`.`Publicado_por` (`id_libro`, `nombre_editorial`) VALUES (007, 'BLOOMSBURY PUBLISHING');
INSERT INTO `biblioteca`.`Publicado_por` (`id_libro`, `nombre_editorial`) VALUES (008, 'BLOOMSBURY PUBLISHING');
INSERT INTO `biblioteca`.`Publicado_por` (`id_libro`, `nombre_editorial`) VALUES (009, 'Catedra');
INSERT INTO `biblioteca`.`Publicado_por` (`id_libro`, `nombre_editorial`) VALUES (010, 'Catedra');
INSERT INTO `biblioteca`.`Publicado_por` (`id_libro`, `nombre_editorial`) VALUES (011, 'Alfaguara');
INSERT INTO `biblioteca`.`Publicado_por` (`id_libro`, `nombre_editorial`) VALUES (012, 'Scholastic');
INSERT INTO `biblioteca`.`Publicado_por` (`id_libro`, `nombre_editorial`) VALUES (013, 'Alfaguara');
INSERT INTO `biblioteca`.`Publicado_por` (`id_libro`, `nombre_editorial`) VALUES (014, 'Editorial Continental');
INSERT INTO `biblioteca`.`Publicado_por` (`id_libro`, `nombre_editorial`) VALUES (015, 'Editorial Continental');
INSERT INTO `biblioteca`.`Publicado_por` (`id_libro`, `nombre_editorial`) VALUES (016, 'Pearson');
INSERT INTO `biblioteca`.`Publicado_por` (`id_libro`, `nombre_editorial`) VALUES (017, 'McGrawHill Inc');
INSERT INTO `biblioteca`.`Publicado_por` (`id_libro`, `nombre_editorial`) VALUES (018, 'Sudamericana ');
INSERT INTO `biblioteca`.`Publicado_por` (`id_libro`, `nombre_editorial`) VALUES (019, 'Sudamericana ');
INSERT INTO `biblioteca`.`Publicado_por` (`id_libro`, `nombre_editorial`) VALUES (020, 'Sudamericana ');
INSERT INTO `biblioteca`.`Publicado_por` (`id_libro`, `nombre_editorial`) VALUES (021, 'Sur');
INSERT INTO `biblioteca`.`Publicado_por` (`id_libro`, `nombre_editorial`) VALUES (022, 'Sur');
INSERT INTO `biblioteca`.`Publicado_por` (`id_libro`, `nombre_editorial`) VALUES (023, 'Sur');
INSERT INTO `biblioteca`.`Publicado_por` (`id_libro`, `nombre_editorial`) VALUES (024, 'GUADAL');
INSERT INTO `biblioteca`.`Publicado_por` (`id_libro`, `nombre_editorial`) VALUES (025, 'Editorial Continental');
INSERT INTO `biblioteca`.`Publicado_por` (`id_libro`, `nombre_editorial`) VALUES (026, 'EDELVIVES');
INSERT INTO `biblioteca`.`Publicado_por` (`id_libro`, `nombre_editorial`) VALUES (027, 'Editorial Alma');
INSERT INTO `biblioteca`.`Publicado_por` (`id_libro`, `nombre_editorial`) VALUES (028, 'Sudamericana ');
INSERT INTO `biblioteca`.`Publicado_por` (`id_libro`, `nombre_editorial`) VALUES (029, 'Editorial Alma');
INSERT INTO `biblioteca`.`Publicado_por` (`id_libro`, `nombre_editorial`) VALUES (030, 'Editorial Alma');
INSERT INTO `biblioteca`.`Publicado_por` (`id_libro`, `nombre_editorial`) VALUES (031, 'Catedra');

COMMIT;


-- -----------------------------------------------------
-- Data for table `biblioteca`.`Ejemplar`
-- -----------------------------------------------------
START TRANSACTION;
USE `biblioteca`;
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (001, 'No Disponible', '9788415618782');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (002, 'No Disponible', '9788415618782');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (003, 'Disponible', '9788415618782');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (004, 'Disponible', '9788415618898');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (005, 'Disponible', '9788415089728');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (006, 'Disponible', '9788415089728');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (007, 'Disponible', '9788469847978');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (008, 'Disponible', '9788420457505');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (009, 'Disponible', '9780062060624');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (010, 'Disponible', '9780062060624');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (011, 'Disponible', '9781408821985');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (012, 'Disponible', '9788491814122');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (013, 'No Disponible', '9788437604572');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (014, 'Disponible', '9788437604572');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (015, 'No Disponible', '9788437624747');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (016, 'No Disponible', '9788437624747');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (017, 'Disponible', '9788420416571');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (018, 'Disponible', '9788466302272');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (019, 'Disponible', '9788466302272');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (020, 'Disponible', '9789875666474');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (021, 'Disponible', '9788499089508');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (022, 'Disponible', '9780140093131');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (023, 'Disponible', '9780140093131');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (024, 'Disponible', '9780140093131');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (025, 'Disponible', '9788420638751');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (026, 'Disponible', '9788420638751');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (027, 'Disponible', '9788420638751');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (028, 'Disponible', '9789702402572');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (029, 'Disponible', '9789702402572');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (030, 'Disponible', '9789702402572');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (031, 'Disponible', '9789702402572');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (032, 'Disponible', '9789702403265');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (033, 'Disponible', '9789702403265');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (034, 'Disponible', '9789702403265');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (035, 'Disponible', '9780133970777');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (036, 'Disponible', '9780133970777');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (037, 'Disponible', '9780073523323');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (038, 'Disponible', '9780060951306');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (039, 'Disponible', '9780060951306');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (040, 'Disponible', '9780060172534');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (041, 'Disponible', '9780060951283');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (042, 'Disponible', '9789802763818');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (043, 'Disponible', '9789802763818');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (044, 'Disponible', '9788432211386');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (045, 'Disponible', '9788432211386');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (046, 'Disponible', '9788437600895');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (047, 'Disponible', '9788437600895');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (048, 'Disponible', '9788432215148');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (049, 'Disponible', '9789873201813');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (050, 'Disponible', '9789873201813');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (051, 'Disponible', '9789873201813');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (052, 'Disponible', '9789873201813');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (053, 'Disponible', '9789872933005');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (054, 'Disponible', '9789872933005');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (055, 'Disponible', '9789500305563');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (056, 'Disponible', '9789500305563');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (057, 'Disponible', '9788441425071');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (058, 'Disponible', '9789872121358');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (059, 'Disponible', '9789872121334');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (060, 'Disponible', '9789871165322');
INSERT INTO `biblioteca`.`Ejemplar` (`id_ejemplar`, `estado`, `ISBN`) VALUES (061, 'Disponible', '9789871165322');

COMMIT;


-- -----------------------------------------------------
-- Data for table `biblioteca`.`Palabra_clave`
-- -----------------------------------------------------
START TRANSACTION;
USE `biblioteca`;
INSERT INTO `biblioteca`.`Palabra_clave` (`palabra`) VALUES ('Ficcion');
INSERT INTO `biblioteca`.`Palabra_clave` (`palabra`) VALUES ('Clasicos');
INSERT INTO `biblioteca`.`Palabra_clave` (`palabra`) VALUES ('Romance');
INSERT INTO `biblioteca`.`Palabra_clave` (`palabra`) VALUES ('Poesia');
INSERT INTO `biblioteca`.`Palabra_clave` (`palabra`) VALUES ('Aventura');
INSERT INTO `biblioteca`.`Palabra_clave` (`palabra`) VALUES ('Ficcion historica');
INSERT INTO `biblioteca`.`Palabra_clave` (`palabra`) VALUES ('Mitologia');
INSERT INTO `biblioteca`.`Palabra_clave` (`palabra`) VALUES ('LGBT+');
INSERT INTO `biblioteca`.`Palabra_clave` (`palabra`) VALUES ('Literatura Argentina');
INSERT INTO `biblioteca`.`Palabra_clave` (`palabra`) VALUES ('Misterio');
INSERT INTO `biblioteca`.`Palabra_clave` (`palabra`) VALUES ('Reflexivo');
INSERT INTO `biblioteca`.`Palabra_clave` (`palabra`) VALUES ('Historias cortas');
INSERT INTO `biblioteca`.`Palabra_clave` (`palabra`) VALUES ('Ciencias fisicas');
INSERT INTO `biblioteca`.`Palabra_clave` (`palabra`) VALUES ('Mecanica');
INSERT INTO `biblioteca`.`Palabra_clave` (`palabra`) VALUES ('Electromecanica');
INSERT INTO `biblioteca`.`Palabra_clave` (`palabra`) VALUES ('Informatica');
INSERT INTO `biblioteca`.`Palabra_clave` (`palabra`) VALUES ('Literatura latinoamericana');
INSERT INTO `biblioteca`.`Palabra_clave` (`palabra`) VALUES ('Biografia');
INSERT INTO `biblioteca`.`Palabra_clave` (`palabra`) VALUES ('No ficcion');
INSERT INTO `biblioteca`.`Palabra_clave` (`palabra`) VALUES ('Trilogia');
INSERT INTO `biblioteca`.`Palabra_clave` (`palabra`) VALUES ('Historia');
INSERT INTO `biblioteca`.`Palabra_clave` (`palabra`) VALUES ('Ciencia Ficcion');
INSERT INTO `biblioteca`.`Palabra_clave` (`palabra`) VALUES ('Obra de teatro');

COMMIT;


-- -----------------------------------------------------
-- Data for table `biblioteca`.`Tema`
-- -----------------------------------------------------
START TRANSACTION;
USE `biblioteca`;
INSERT INTO `biblioteca`.`Tema` (`nombre_tema`) VALUES ('Romantico');
INSERT INTO `biblioteca`.`Tema` (`nombre_tema`) VALUES ('Clasico');
INSERT INTO `biblioteca`.`Tema` (`nombre_tema`) VALUES ('Mitologia');
INSERT INTO `biblioteca`.`Tema` (`nombre_tema`) VALUES ('Fantasia');
INSERT INTO `biblioteca`.`Tema` (`nombre_tema`) VALUES ('Realismo magico');
INSERT INTO `biblioteca`.`Tema` (`nombre_tema`) VALUES ('Fisica');
INSERT INTO `biblioteca`.`Tema` (`nombre_tema`) VALUES ('Bases de Datos');
INSERT INTO `biblioteca`.`Tema` (`nombre_tema`) VALUES ('Biografia');
INSERT INTO `biblioteca`.`Tema` (`nombre_tema`) VALUES ('Ciencia Ficcion');
INSERT INTO `biblioteca`.`Tema` (`nombre_tema`) VALUES ('Tragedia');
INSERT INTO `biblioteca`.`Tema` (`nombre_tema`) VALUES ('Ficcion');
INSERT INTO `biblioteca`.`Tema` (`nombre_tema`) VALUES ('Filosofia');

COMMIT;


-- -----------------------------------------------------
-- Data for table `biblioteca`.`Prestamo`
-- -----------------------------------------------------
START TRANSACTION;
USE `biblioteca`;
INSERT INTO `biblioteca`.`Prestamo` (`id_prestamo`, `fecha_prestamo`, `fecha_devolucion`) VALUES (001, '2021-03-08', '2021-03-15');
INSERT INTO `biblioteca`.`Prestamo` (`id_prestamo`, `fecha_prestamo`, `fecha_devolucion`) VALUES (002, '2021-03-08', '2021-03-22');
INSERT INTO `biblioteca`.`Prestamo` (`id_prestamo`, `fecha_prestamo`, `fecha_devolucion`) VALUES (003, '2021-03-22', '2021-04-09');
INSERT INTO `biblioteca`.`Prestamo` (`id_prestamo`, `fecha_prestamo`, `fecha_devolucion`) VALUES (004, '2021-04-05', '2021-04-09');
INSERT INTO `biblioteca`.`Prestamo` (`id_prestamo`, `fecha_prestamo`, `fecha_devolucion`) VALUES (005, '2021-11-09', NULL);
INSERT INTO `biblioteca`.`Prestamo` (`id_prestamo`, `fecha_prestamo`, `fecha_devolucion`) VALUES (006, '2021-11-18', NULL);
INSERT INTO `biblioteca`.`Prestamo` (`id_prestamo`, `fecha_prestamo`, `fecha_devolucion`) VALUES (007, '2021-11-18', NULL);
INSERT INTO `biblioteca`.`Prestamo` (`id_prestamo`, `fecha_prestamo`, `fecha_devolucion`) VALUES (008, '2020-11-11', '2020-12-11');
INSERT INTO `biblioteca`.`Prestamo` (`id_prestamo`, `fecha_prestamo`, `fecha_devolucion`) VALUES (009, '2019-10-13', '2019-10-21');
INSERT INTO `biblioteca`.`Prestamo` (`id_prestamo`, `fecha_prestamo`, `fecha_devolucion`) VALUES (010, '2019-10-13', '2019-10-21');

COMMIT;


-- -----------------------------------------------------
-- Data for table `biblioteca`.`Lector`
-- -----------------------------------------------------
START TRANSACTION;
USE `biblioteca`;
INSERT INTO `biblioteca`.`Lector` (`num_lector`, `nombre_apellido`, `CUIL`, `telefono`) VALUES (001, 'Valentina Fernandez', 11111111111, 2231111111);
INSERT INTO `biblioteca`.`Lector` (`num_lector`, `nombre_apellido`, `CUIL`, `telefono`) VALUES (002, 'Enzo Nogueira Barria', 22222222222, 2231111112);
INSERT INTO `biblioteca`.`Lector` (`num_lector`, `nombre_apellido`, `CUIL`, `telefono`) VALUES (003, 'Maria Josefina Oller', 33333333333, 2231111113);
INSERT INTO `biblioteca`.`Lector` (`num_lector`, `nombre_apellido`, `CUIL`, `telefono`) VALUES (004, 'Deborah Kollman', 44444444444, 2231111114);
INSERT INTO `biblioteca`.`Lector` (`num_lector`, `nombre_apellido`, `CUIL`, `telefono`) VALUES (005, 'Estanislao Mileta', 55555555555, 2231111115);
INSERT INTO `biblioteca`.`Lector` (`num_lector`, `nombre_apellido`, `CUIL`, `telefono`) VALUES (006, 'Fernando Soriano', 66666666666, 2231111116);
INSERT INTO `biblioteca`.`Lector` (`num_lector`, `nombre_apellido`, `CUIL`, `telefono`) VALUES (007, 'Hernan Hinojal', 77777777777, 2231111117);
INSERT INTO `biblioteca`.`Lector` (`num_lector`, `nombre_apellido`, `CUIL`, `telefono`) VALUES (008, 'Ivonne Gallon', 88888888888, 2231111118);
INSERT INTO `biblioteca`.`Lector` (`num_lector`, `nombre_apellido`, `CUIL`, `telefono`) VALUES (009, 'Juan Gonzalez', 99999999999, 2231111119);
INSERT INTO `biblioteca`.`Lector` (`num_lector`, `nombre_apellido`, `CUIL`, `telefono`) VALUES (010, 'Gustavo Cornu', 12345678901, 2231111110);
INSERT INTO `biblioteca`.`Lector` (`num_lector`, `nombre_apellido`, `CUIL`, `telefono`) VALUES (011, 'Cirse Calzetta', 23456789012, 2232222222);
INSERT INTO `biblioteca`.`Lector` (`num_lector`, `nombre_apellido`, `CUIL`, `telefono`) VALUES (012, 'Camila Campos', 34567890123, NULL);
INSERT INTO `biblioteca`.`Lector` (`num_lector`, `nombre_apellido`, `CUIL`, `telefono`) VALUES (013, 'Carolina Cretton', 45678901234, NULL);
INSERT INTO `biblioteca`.`Lector` (`num_lector`, `nombre_apellido`, `CUIL`, `telefono`) VALUES (014, 'Giuliana Manassero', 56789012345, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `biblioteca`.`Docente`
-- -----------------------------------------------------
START TRANSACTION;
USE `biblioteca`;
INSERT INTO `biblioteca`.`Docente` (`num_lector`) VALUES (005);
INSERT INTO `biblioteca`.`Docente` (`num_lector`) VALUES (006);
INSERT INTO `biblioteca`.`Docente` (`num_lector`) VALUES (007);
INSERT INTO `biblioteca`.`Docente` (`num_lector`) VALUES (008);
INSERT INTO `biblioteca`.`Docente` (`num_lector`) VALUES (009);
INSERT INTO `biblioteca`.`Docente` (`num_lector`) VALUES (010);
INSERT INTO `biblioteca`.`Docente` (`num_lector`) VALUES (011);

COMMIT;


-- -----------------------------------------------------
-- Data for table `biblioteca`.`Universitario`
-- -----------------------------------------------------
START TRANSACTION;
USE `biblioteca`;
INSERT INTO `biblioteca`.`Universitario` (`num_lector`, `libreta_universitaria`) VALUES (001, '11857');
INSERT INTO `biblioteca`.`Universitario` (`num_lector`, `libreta_universitaria`) VALUES (002, '11858');
INSERT INTO `biblioteca`.`Universitario` (`num_lector`, `libreta_universitaria`) VALUES (003, '14789');
INSERT INTO `biblioteca`.`Universitario` (`num_lector`, `libreta_universitaria`) VALUES (004, '14790');
INSERT INTO `biblioteca`.`Universitario` (`num_lector`, `libreta_universitaria`) VALUES (012, '12345');
INSERT INTO `biblioteca`.`Universitario` (`num_lector`, `libreta_universitaria`) VALUES (013, '11232');
INSERT INTO `biblioteca`.`Universitario` (`num_lector`, `libreta_universitaria`) VALUES (014, '12139');

COMMIT;


-- -----------------------------------------------------
-- Data for table `biblioteca`.`Alumno`
-- -----------------------------------------------------
START TRANSACTION;
USE `biblioteca`;
INSERT INTO `biblioteca`.`Alumno` (`num_lector`) VALUES (001);
INSERT INTO `biblioteca`.`Alumno` (`num_lector`) VALUES (002);
INSERT INTO `biblioteca`.`Alumno` (`num_lector`) VALUES (003);
INSERT INTO `biblioteca`.`Alumno` (`num_lector`) VALUES (004);

COMMIT;


-- -----------------------------------------------------
-- Data for table `biblioteca`.`Egresado`
-- -----------------------------------------------------
START TRANSACTION;
USE `biblioteca`;
INSERT INTO `biblioteca`.`Egresado` (`num_lector`, `fecha_egreso`) VALUES (012, '2021-07-16');
INSERT INTO `biblioteca`.`Egresado` (`num_lector`, `fecha_egreso`) VALUES (013, '2019-08-15');
INSERT INTO `biblioteca`.`Egresado` (`num_lector`, `fecha_egreso`) VALUES (014, '2020-12-02');

COMMIT;


-- -----------------------------------------------------
-- Data for table `biblioteca`.`Materia`
-- -----------------------------------------------------
START TRANSACTION;
USE `biblioteca`;
INSERT INTO `biblioteca`.`Materia` (`cod_materia`, `nombre`) VALUES ('6B6', 'Bases de Datos');
INSERT INTO `biblioteca`.`Materia` (`cod_materia`, `nombre`) VALUES ('1A1', 'Literatura Argentina I');
INSERT INTO `biblioteca`.`Materia` (`cod_materia`, `nombre`) VALUES ('1A2', 'Lengua y Cultura Griegas I');
INSERT INTO `biblioteca`.`Materia` (`cod_materia`, `nombre`) VALUES ('1A3', 'Teoría y crítica literarias I');
INSERT INTO `biblioteca`.`Materia` (`cod_materia`, `nombre`) VALUES ('1A4', 'Literatura y cultura europeas I');
INSERT INTO `biblioteca`.`Materia` (`cod_materia`, `nombre`) VALUES ('2B1', 'Fisica I');
INSERT INTO `biblioteca`.`Materia` (`cod_materia`, `nombre`) VALUES ('2B2', 'Fisica II');

COMMIT;


-- -----------------------------------------------------
-- Data for table `biblioteca`.`Contiene`
-- -----------------------------------------------------
START TRANSACTION;
USE `biblioteca`;
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9781407172668', 'Clasicos');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9781407172668', 'Romance');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9788415618782', 'Romance');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9788415618782', 'Ficcion');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9788415618782', 'Ficcion historica');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9788415089728', 'Clasicos');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9788415089728', 'Ficcion');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9788415089728', 'Poesia');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9788415089728', 'Aventura');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9788415089728', 'Mitologia');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9788420457505', 'Ficcion');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9781407172668', 'Ficcion');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9780062060624', 'Mitologia');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9780062060624', 'Ficcion historica');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9780062060624', 'Romance');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9780062060624', 'LGBT+');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9781408821985', 'Mitologia');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9781408821985', 'Ficcion historica');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9781408821985', 'Romance');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9781408821985', 'LGBT+');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9788491814122', 'Ficcion');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9788491814122', 'Mitologia');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9789875666474', 'Ficcion');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9789875666474', 'Literatura Argentina');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9789875666474', 'Misterio');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9789875666474', 'Reflexivo');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9788499089508', 'Literatura Argentina');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9788499089508', 'Misterio');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9788499089508', 'Reflexivo');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9780140093131', 'Ficcion');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9780140093131', 'Literatura Argentina');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9788420638751', 'Ficcion');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9788420638751', 'Literatura Argentina');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9788420416571', 'Historias cortas');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9788466302272', 'Historias cortas');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9789875666474', 'Historias cortas');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9788499089508', 'Historias cortas');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9789702402572', 'Ciencias fisicas');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9789702402572', 'Mecanica');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9789702403265', 'Ciencias fisicas');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9789702403265', 'Electromecanica');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9780133970777', 'Informatica');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9780073523323', 'Informatica');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9780060951306', 'Ficcion');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9780060951306', 'Literatura latinoamericana');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9780060172534', 'No ficcion');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9780060172534', 'Biografia');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9780060172534', 'Reflexivo');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9780060951283', 'Ficcion');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9780060951283', 'Aventura');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9789802763818', 'Ficcion');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9789802763818', 'Literatura Argentina');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9789802763818', 'Trilogia');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9788432211386', 'Ficcion');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9788432211386', 'Literatura Argentina');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9788432211386', 'Trilogia');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9788437600895', 'Ficcion');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9788437600895', 'Literatura Argentina');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9788437600895', 'Trilogia');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9788432215148', 'Ficcion');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9788432215148', 'Literatura Argentina');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9788432215148', 'Trilogia');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9789873201813', 'No ficcion');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9789873201813', 'Clasicos');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9789873201813', 'Historia');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9789872933005', 'Ficcion');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9789872933005', 'Clasicos');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9789872933005', 'Ciencia ficcion');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9788426390912', 'Ficcion');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9788426390912', 'Clasicos');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9788426390912', 'Historia');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9789500305563', 'Obra de teatro');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9789500305563', 'Ficcion');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9789500305563', 'Clasicos');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9788441425071', 'Obra de teatro');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9788441425071', 'Ficcion');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9788441425071', 'Clasicos');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9789872121358', 'Obra de teatro');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9789872121358', 'Ficcion');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9789872121358', 'Clasicos');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9789872121358', 'Romance');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9789872121334', 'Ficcion');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9789872121334', 'Clasicos');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9789872121334', 'Obra de teatro');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9789871165322', 'Ficcion');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9789871165322', 'Clasicos');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9789871165322', 'Historias cortas');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9789871165322', 'Romance');
INSERT INTO `biblioteca`.`Contiene` (`ISBN`, `palabra`) VALUES ('9789871165322', 'Obra de teatro');

COMMIT;


-- -----------------------------------------------------
-- Data for table `biblioteca`.`Trata`
-- -----------------------------------------------------
START TRANSACTION;
USE `biblioteca`;
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9788415618782', 'Romantico');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9788415618782', 'Clasico');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9788415618898', 'Romantico');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9788415618898', 'Clasico');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9788415089728', 'Clasico');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9788469847978', 'Clasico');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9788420457505', 'Clasico');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9781407172668', 'Clasico');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9781407172668', 'Romantico');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9780062060624', 'Romantico');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9780062060624', 'Mitologia');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9780062060624', 'Fantasia');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9781408821985', 'Romantico');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9781408821985', 'Mitologia');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9781408821985', 'Fantasia');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9788491814122', 'Mitologia');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9788437604572', 'Ficcion');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9788437624747', 'Ficcion');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9788420416571', 'Ficcion');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9788420416571', 'Realismo magico');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9788466302272', 'Ficcion');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9788466302272', 'Realismo magico');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9789875666474', 'Ficcion');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9789875666474', 'Realismo magico');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9788499089508', 'Realismo magico');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9788499089508', 'Ficcion');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9780140093131', 'Ficcion');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9788420638751', 'Ficcion');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9789702402572', 'Fisica');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9789702403265', 'Fisica');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9780133970777', 'Bases de Datos');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9780073523323', 'Bases de Datos');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9780060951306', 'Ficcion');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9780060951306', 'Realismo Magico');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9780060172534', 'Biografia');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9780060951283', 'Ficcion');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9789802763818', 'Ficcion');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9788432211386', 'Ficcion');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9788437600895', 'Ficcion');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9788432215148', 'Ficcion');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9789873201813', 'Biografia');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9789873201813', 'Clasico');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9789872933005', 'Ciencia Ficcion');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9788426390912', 'Clasico');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9788426390912', 'Ficcion');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9789500305563', 'Ficcion');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9789500305563', 'Tragedia');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9788441425071', 'Ficcion');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9788441425071', 'Tragedia');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9789872121358', 'Ficcion');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9789872121358', 'Tragedia');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9789872121358', 'Romantico');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9789872121334', 'Ficcion');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9789872121334', 'Tragedia');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9789872121334', 'Clasico');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9789871165322', 'Ficcion');
INSERT INTO `biblioteca`.`Trata` (`ISBN`, `nombre_tema`) VALUES ('9789871165322', 'Romantico');

COMMIT;


-- -----------------------------------------------------
-- Data for table `biblioteca`.`Es_retirado`
-- -----------------------------------------------------
START TRANSACTION;
USE `biblioteca`;
INSERT INTO `biblioteca`.`Es_retirado` (`id_ejemplar`, `id_prestamo`) VALUES (022, 001);
INSERT INTO `biblioteca`.`Es_retirado` (`id_ejemplar`, `id_prestamo`) VALUES (035, 002);
INSERT INTO `biblioteca`.`Es_retirado` (`id_ejemplar`, `id_prestamo`) VALUES (028, 003);
INSERT INTO `biblioteca`.`Es_retirado` (`id_ejemplar`, `id_prestamo`) VALUES (032, 004);
INSERT INTO `biblioteca`.`Es_retirado` (`id_ejemplar`, `id_prestamo`) VALUES (035, 004);
INSERT INTO `biblioteca`.`Es_retirado` (`id_ejemplar`, `id_prestamo`) VALUES (037, 004);
INSERT INTO `biblioteca`.`Es_retirado` (`id_ejemplar`, `id_prestamo`) VALUES (001, 005);
INSERT INTO `biblioteca`.`Es_retirado` (`id_ejemplar`, `id_prestamo`) VALUES (002, 006);
INSERT INTO `biblioteca`.`Es_retirado` (`id_ejemplar`, `id_prestamo`) VALUES (013, 006);
INSERT INTO `biblioteca`.`Es_retirado` (`id_ejemplar`, `id_prestamo`) VALUES (015, 006);
INSERT INTO `biblioteca`.`Es_retirado` (`id_ejemplar`, `id_prestamo`) VALUES (016, 007);
INSERT INTO `biblioteca`.`Es_retirado` (`id_ejemplar`, `id_prestamo`) VALUES (006, 008);
INSERT INTO `biblioteca`.`Es_retirado` (`id_ejemplar`, `id_prestamo`) VALUES (049, 009);
INSERT INTO `biblioteca`.`Es_retirado` (`id_ejemplar`, `id_prestamo`) VALUES (050, 010);

COMMIT;


-- -----------------------------------------------------
-- Data for table `biblioteca`.`Realizado_por`
-- -----------------------------------------------------
START TRANSACTION;
USE `biblioteca`;
INSERT INTO `biblioteca`.`Realizado_por` (`id_prestamo`, `num_lector`) VALUES (001, 001);
INSERT INTO `biblioteca`.`Realizado_por` (`id_prestamo`, `num_lector`) VALUES (002, 005);
INSERT INTO `biblioteca`.`Realizado_por` (`id_prestamo`, `num_lector`) VALUES (003, 010);
INSERT INTO `biblioteca`.`Realizado_por` (`id_prestamo`, `num_lector`) VALUES (004, 004);
INSERT INTO `biblioteca`.`Realizado_por` (`id_prestamo`, `num_lector`) VALUES (005, 013);
INSERT INTO `biblioteca`.`Realizado_por` (`id_prestamo`, `num_lector`) VALUES (006, 014);
INSERT INTO `biblioteca`.`Realizado_por` (`id_prestamo`, `num_lector`) VALUES (007, 012);
INSERT INTO `biblioteca`.`Realizado_por` (`id_prestamo`, `num_lector`) VALUES (008, 002);
INSERT INTO `biblioteca`.`Realizado_por` (`id_prestamo`, `num_lector`) VALUES (009, 004);
INSERT INTO `biblioteca`.`Realizado_por` (`id_prestamo`, `num_lector`) VALUES (010, 011);

COMMIT;


-- -----------------------------------------------------
-- Data for table `biblioteca`.`Es_dictada`
-- -----------------------------------------------------
START TRANSACTION;
USE `biblioteca`;
INSERT INTO `biblioteca`.`Es_dictada` (`cod_materia`, `num_lector`) VALUES ('6B6', 005);
INSERT INTO `biblioteca`.`Es_dictada` (`cod_materia`, `num_lector`) VALUES ('1A1', 006);
INSERT INTO `biblioteca`.`Es_dictada` (`cod_materia`, `num_lector`) VALUES ('1A2', 007);
INSERT INTO `biblioteca`.`Es_dictada` (`cod_materia`, `num_lector`) VALUES ('1A3', 008);
INSERT INTO `biblioteca`.`Es_dictada` (`cod_materia`, `num_lector`) VALUES ('1A4', 009);
INSERT INTO `biblioteca`.`Es_dictada` (`cod_materia`, `num_lector`) VALUES ('2B1', 010);
INSERT INTO `biblioteca`.`Es_dictada` (`cod_materia`, `num_lector`) VALUES ('2B2', 011);

COMMIT;


-- -----------------------------------------------------
-- Data for table `biblioteca`.`Es_bibliografia`
-- -----------------------------------------------------
START TRANSACTION;
USE `biblioteca`;
INSERT INTO `biblioteca`.`Es_bibliografia` (`id_libro`, `cod_materia`, `obligatoriedad`) VALUES (014, '2B1', 'si');
INSERT INTO `biblioteca`.`Es_bibliografia` (`id_libro`, `cod_materia`, `obligatoriedad`) VALUES (015, '2B2', 'si');
INSERT INTO `biblioteca`.`Es_bibliografia` (`id_libro`, `cod_materia`, `obligatoriedad`) VALUES (016, '6B6', 'si');
INSERT INTO `biblioteca`.`Es_bibliografia` (`id_libro`, `cod_materia`, `obligatoriedad`) VALUES (009, '1A1', 'no');
INSERT INTO `biblioteca`.`Es_bibliografia` (`id_libro`, `cod_materia`, `obligatoriedad`) VALUES (011, '1A1', 'si');
INSERT INTO `biblioteca`.`Es_bibliografia` (`id_libro`, `cod_materia`, `obligatoriedad`) VALUES (003, '1A2', 'si');
INSERT INTO `biblioteca`.`Es_bibliografia` (`id_libro`, `cod_materia`, `obligatoriedad`) VALUES (013, '1A3', 'si');
INSERT INTO `biblioteca`.`Es_bibliografia` (`id_libro`, `cod_materia`, `obligatoriedad`) VALUES (008, '1A1', 'no');
INSERT INTO `biblioteca`.`Es_bibliografia` (`id_libro`, `cod_materia`, `obligatoriedad`) VALUES (006, '1A4', 'si');
INSERT INTO `biblioteca`.`Es_bibliografia` (`id_libro`, `cod_materia`, `obligatoriedad`) VALUES (021, '1A1', 'si');
INSERT INTO `biblioteca`.`Es_bibliografia` (`id_libro`, `cod_materia`, `obligatoriedad`) VALUES (022, '1A1', 'no');
INSERT INTO `biblioteca`.`Es_bibliografia` (`id_libro`, `cod_materia`, `obligatoriedad`) VALUES (023, '1A1', 'no');
INSERT INTO `biblioteca`.`Es_bibliografia` (`id_libro`, `cod_materia`, `obligatoriedad`) VALUES (024, '1A4', 'si');
INSERT INTO `biblioteca`.`Es_bibliografia` (`id_libro`, `cod_materia`, `obligatoriedad`) VALUES (027, '1A4', 'si');
INSERT INTO `biblioteca`.`Es_bibliografia` (`id_libro`, `cod_materia`, `obligatoriedad`) VALUES (028, '1A4', 'si');
INSERT INTO `biblioteca`.`Es_bibliografia` (`id_libro`, `cod_materia`, `obligatoriedad`) VALUES (029, '1A4', 'si');
INSERT INTO `biblioteca`.`Es_bibliografia` (`id_libro`, `cod_materia`, `obligatoriedad`) VALUES (027, '1A3', 'si');
INSERT INTO `biblioteca`.`Es_bibliografia` (`id_libro`, `cod_materia`, `obligatoriedad`) VALUES (028, '1A3', 'no');

COMMIT;


-- -----------------------------------------------------
-- Data for table `biblioteca`.`Es_recomendado`
-- -----------------------------------------------------
START TRANSACTION;
USE `biblioteca`;
INSERT INTO `biblioteca`.`Es_recomendado` (`id_libro`, `cod_materia`, `num_lector`) VALUES (017, '6B6', 005);
INSERT INTO `biblioteca`.`Es_recomendado` (`id_libro`, `cod_materia`, `num_lector`) VALUES (012, '1A1', 006);
INSERT INTO `biblioteca`.`Es_recomendado` (`id_libro`, `cod_materia`, `num_lector`) VALUES (007, '1A3', 008);
INSERT INTO `biblioteca`.`Es_recomendado` (`id_libro`, `cod_materia`, `num_lector`) VALUES (025, '1A4', 009);
INSERT INTO `biblioteca`.`Es_recomendado` (`id_libro`, `cod_materia`, `num_lector`) VALUES (026, '1A4', 009);
INSERT INTO `biblioteca`.`Es_recomendado` (`id_libro`, `cod_materia`, `num_lector`) VALUES (031, '1A3', 008);
INSERT INTO `biblioteca`.`Es_recomendado` (`id_libro`, `cod_materia`, `num_lector`) VALUES (031, '1A4', 009);
INSERT INTO `biblioteca`.`Es_recomendado` (`id_libro`, `cod_materia`, `num_lector`) VALUES (030, '1A4', 009);

COMMIT;

