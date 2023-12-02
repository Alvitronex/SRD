-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 24-09-2023 a las 10:45:36
-- Versión del servidor: 8.0.33-0ubuntu0.20.04.2
-- Versión de PHP: 7.4.3-4ubuntu2.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sys_sge`
--
CREATE DATABASE IF NOT EXISTS `sys_sge` DEFAULT CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci;
USE `sys_sge`;

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`admin`@`localhost` PROCEDURE `SaveDataGrupos` (IN `idmateria` INT, IN `iddocente` INT, IN `idhorario` INT, IN `idaula` INT, IN `fecha` DATE, IN `idusuario` INT)  BEGIN
    SET @idmateria = idmateria;
    SET @iddocente = iddocente;
    SET @idhorario = idhorario;
    SET @idaula = idaula;
    SET @fecha = fecha;
    SET @idusuario = idusuario;
    SET @BuscaDato = (SELECT COUNT(iddocente) FROM grupos WHERE iddocente=@iddocente AND idmateria=@idmateria AND idhorario=@idhorario);
    IF @BuscaDato >  0 THEN
        SELECT 'Error el grupo ya existe...' AS Respuesta;
    ELSE 
        INSERT INTO grupos(idmateria,iddocente,idhorario,idaula,fecha,idusuario) VALUES(@idmateria,@iddocente,@idhorario,@idaula,@fecha,@idusuario);
        SELECT 'Grupo registrado...' AS Respuesta;
    END IF;
END$$

--
-- Funciones
--
CREATE DEFINER=`admin`@`localhost` FUNCTION `BuscaDepa` (`iddepa` INT) RETURNS TEXT CHARSET utf8mb3 READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE depa TEXT;
    SELECT departamento INTO depa FROM departamentos WHERE iddepartamento=iddepa;
    RETURN depa;
END$$

CREATE DEFINER=`admin`@`localhost` FUNCTION `CalculaPromedio` (`n1` DECIMAL(5,2), `n2` DECIMAL(5,2), `n3` DECIMAL(5,2), `n4` DECIMAL(5,2)) RETURNS DECIMAL(5,2) BEGIN
    DECLARE promedio DECIMAL(5,2);
    SET promedio = ((n1*0.20)+(n2*0.20)+(n3*0.20)+(n4*0.40));
    RETURN promedio;
END$$

CREATE DEFINER=`admin`@`localhost` FUNCTION `CalcularPromedio` (`n1` DECIMAL(5,2), `n2` DECIMAL(5,2), `n3` DECIMAL(5,2), `n4` DECIMAL(5,2)) RETURNS DECIMAL(5,2) BEGIN
    DECLARE promedio DECIMAL(5,2);
    SET promedio = ((n1*0.20)+(n2*0.20)+(n3*0.20)+(n4*0.40));
    RETURN promedio;
END$$

CREATE DEFINER=`admin`@`localhost` FUNCTION `DelDataInscripcionNotas` (`carnetI` VARCHAR(15), `idgrupoI` INT, `cicloI` VARCHAR(15)) RETURNS TEXT CHARSET utf8mb3 BEGIN
    DECLARE BuscaDato INT;
    SELECT COUNT(carnet) INTO BuscaDato FROM inscripciones WHERE  carnet=carnetI AND idgrupo=idgrupoI AND ciclo=cicloI;
    IF BuscaDato != 0 THEN
        DELETE FROM inscripciones WHERE carnet=carnetI AND idgrupo=idgrupoI AND ciclo=cicloI;
        DELETE FROM notas WHERE carnet=carnetI AND idgrupo=idgrupoI;
        RETURN "Dato eliminado...";
    ELSE
        RETURN "Error Dato no existe...";
    END IF;
END$$

CREATE DEFINER=`admin`@`localhost` FUNCTION `SaveDataInscripcion` (`carnetI` VARCHAR(15), `idgrupoI` INT, `cicloI` VARCHAR(15), `fechaI` DATE) RETURNS INT BEGIN
    DECLARE BuscaDato INT;
    SELECT COUNT(carnet) INTO BuscaDato FROM inscripciones WHERE  carnet=carnetI AND idgrupo=idgrupoI AND ciclo=cicloI;
    IF BuscaDato != 0 THEN
        return 0;
    ELSE
        INSERT INTO inscripciones (carnet,idgrupo,ciclo, fecha) VALUES(CarnetI,idgrupoI,cicloI,fechaI);
        INSERT INTO notas (carnet,idgrupo) VALUES(carnetI,idgrupoI);
        RETURN 1;
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aulas`
--

CREATE TABLE `aulas` (
  `idaula` int NOT NULL,
  `aula` varchar(50) DEFAULT NULL,
  `tipo` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `aulas`
--

INSERT INTO `aulas` (`idaula`, `aula`, `tipo`) VALUES
(1, 'A8', 'Aula'),
(2, 'A10', 'Aula'),
(3, 'B12', 'Kiosco'),
(4, 'B15', 'Kiosco'),
(5, 'B1', 'Computo'),
(6, 'B2', 'Computo'),
(7, 'B3', 'Computo'),
(8, 'C3', 'Computo'),
(9, 'C4', 'Aula'),
(10, 'C10', 'Aula');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciclos`
--

CREATE TABLE `ciclos` (
  `idciclo` int NOT NULL,
  `ciclo` varchar(15) DEFAULT NULL,
  `tipo` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `ciclos`
--

INSERT INTO `ciclos` (`idciclo`, `ciclo`, `tipo`) VALUES
(1, '1-2021', 'Ordinario'),
(2, '2-2021', 'Ordinario'),
(3, '1-2022', 'Ordinario'),
(4, '2-2022', 'Ordinario'),
(5, '1-2023', 'Ordinario');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `DataEstudante`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `DataEstudante` (
`Carnet` varchar(15)
,`Departamento` varchar(100)
,`Estudiante` varchar(201)
,`Municipio` varchar(100)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `DataGrupo`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `DataGrupo` (
`Aula` varchar(91)
,`Docente` varchar(201)
,`Fecha` date
,`Horario` varchar(142)
,`Materia` varchar(100)
,`Usuario_Registro` varchar(50)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `DataGrupos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `DataGrupos` (
`Aula` varchar(91)
,`Docente` varchar(201)
,`Fecha Registro` date
,`Horario` varchar(142)
,`Materia` varchar(100)
,`Usuario` varchar(50)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamentos`
--

CREATE TABLE `departamentos` (
  `iddepartamento` int NOT NULL,
  `departamento` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `departamentos`
--

INSERT INTO `departamentos` (`iddepartamento`, `departamento`) VALUES
(1, 'Ahuachapán'),
(2, 'Cabañas'),
(3, 'Chalatenango'),
(4, 'Cuscatlán'),
(5, 'La Libertad'),
(6, 'La Paz'),
(7, 'La Unión'),
(8, 'Morazán'),
(9, 'San Miguel'),
(10, 'San Salvador'),
(11, 'San Vicente'),
(12, 'Santa Ana'),
(13, 'Sonsonate'),
(14, 'Usulután');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `docentes`
--

CREATE TABLE `docentes` (
  `iddocente` int NOT NULL,
  `nombres` varchar(100) DEFAULT NULL,
  `apellidos` varchar(100) DEFAULT NULL,
  `telefono` varchar(9) DEFAULT NULL,
  `email` text,
  `direccion` text,
  `iddepartamento` int DEFAULT NULL,
  `idmunicipio` int DEFAULT NULL,
  `idtipodocente` int DEFAULT NULL,
  `genero` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `docentes`
--

INSERT INTO `docentes` (`iddocente`, `nombres`, `apellidos`, `telefono`, `email`, `direccion`, `iddepartamento`, `idmunicipio`, `idtipodocente`, `genero`) VALUES
(1, 'Antonio', 'Mejía', '1111-1130', 'antoniomejia@uls.edu.sv', 'SS', 13, 227, 2, 'M'),
(2, 'Daniel', 'Valle', '1111-1131', 'danielvalle@uls.edu.sv', 'SS', 14, 259, 2, 'M'),
(3, 'Carlos', 'Gomez', '1111-1134', 'carlosgomez@uls.edu.sv', 'SS', 10, 189, 1, 'M'),
(4, 'Karla', 'Campos', '1111-1135', 'karlacampos@uls.edu.sv', 'SS', 10, 196, 1, 'F'),
(5, 'Katerine', 'González', '1111-1136', 'katerinegonzalez@uls.edu.sv', 'SS', 6, 112, 2, 'F');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupos`
--

CREATE TABLE `grupos` (
  `idgrupo` int NOT NULL,
  `idmateria` int DEFAULT NULL,
  `iddocente` int DEFAULT NULL,
  `idhorario` int DEFAULT NULL,
  `idaula` int DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `idusuario` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `grupos`
--

INSERT INTO `grupos` (`idgrupo`, `idmateria`, `iddocente`, `idhorario`, `idaula`, `fecha`, `idusuario`) VALUES
(1, 1, 4, 16, 8, '2023-09-07', 1),
(2, 2, 5, 17, 7, '2023-09-07', 1),
(3, 2, 5, 17, 7, '2023-09-07', 1),
(4, 2, 5, 17, 7, '2023-09-07', 1),
(5, 2, 5, 17, 7, '2023-09-07', 1),
(6, 2, 5, 17, 7, '2023-09-07', 1),
(7, 2, 5, 17, 7, '2023-09-07', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horarios`
--

CREATE TABLE `horarios` (
  `idhorario` int NOT NULL,
  `dia` varchar(50) DEFAULT NULL,
  `hora` varchar(50) DEFAULT NULL,
  `tipo` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `horarios`
--

INSERT INTO `horarios` (`idhorario`, `dia`, `hora`, `tipo`) VALUES
(1, 'Lunes', '07:00:00 - 08:40:00', 'AM'),
(2, 'Lunes', '09:00:00 - 10:40:00', 'AM'),
(3, 'Lunes', '11:00:00 - 12:40:00', 'M'),
(4, 'Martes', '07:00:00 - 08:40:00', 'AM'),
(5, 'Martes', '09:00:00 - 10:40:00', 'AM'),
(6, 'Martes', '11:00:00 - 12:40:00', 'M'),
(7, 'Miércoles', '07:00:00 - 08:40:00', 'AM'),
(8, 'Miércoles', '09:00:00 - 10:40:00', 'AM'),
(9, 'Miércoles', '11:00:00 - 12:40:00', 'M'),
(10, 'Jueves', '07:00:00 - 08:40:00', 'AM'),
(11, 'Jueves', '09:00:00 - 10:40:00', 'AM'),
(12, 'Jueves', '11:00:00 - 12:40:00', 'M'),
(13, 'Viernes', '07:00:00 - 08:40:00', 'AM'),
(14, 'Viernes', '09:00:00 - 10:40:00', 'AM'),
(15, 'Viernes', '11:00:00 - 12:40:00', 'M'),
(16, 'Sábado', '07:00:00 - 08:40:00', 'AM'),
(17, 'Sábado', '09:00:00 - 10:40:00', 'AM'),
(18, 'Sábado', '11:00:00 - 12:40:00', 'M'),
(19, 'Domingo', '07:00:00 - 08:40:00', 'AM'),
(20, 'Domingo', '09:00:00 - 10:40:00', 'AM'),
(21, 'Domingo', '11:00:00 - 12:40:00', 'M');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inscripciones`
--

CREATE TABLE `inscripciones` (
  `idinscripcion` int NOT NULL,
  `carnet` varchar(15) DEFAULT NULL,
  `idgrupo` int DEFAULT NULL,
  `ciclo` varchar(15) DEFAULT NULL,
  `fecha` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materias`
--

CREATE TABLE `materias` (
  `idmateria` int NOT NULL,
  `materia` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `materias`
--

INSERT INTO `materias` (`idmateria`, `materia`) VALUES
(1, 'Economía'),
(2, 'Ética'),
(3, 'Filosofía'),
(4, 'Internet I'),
(5, 'Internet II'),
(6, 'Programación I'),
(7, 'Programación II'),
(8, 'Programación III'),
(9, 'Desarrollo Web'),
(10, 'Desarrollo Móvil'),
(11, 'Proyectos de Desarrollo Web'),
(12, 'Ingenieria de Software'),
(13, 'Redacción y Ortografía'),
(14, 'Base de Datos I'),
(15, 'Base de Datos II'),
(16, 'Nuevas Tendencias de Programación'),
(17, 'Teoría Administrativa'),
(18, 'Auditoria de Sistemas'),
(19, 'Proyectos de Software Libre'),
(20, 'Prácticas Profesionales Informáticas'),
(21, 'Seminario de Investigación');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `matriculas`
--

CREATE TABLE `matriculas` (
  `carnet` varchar(15) NOT NULL,
  `nombres` varchar(100) DEFAULT NULL,
  `apellidos` varchar(100) DEFAULT NULL,
  `telefono` varchar(9) DEFAULT NULL,
  `email` text,
  `direccion` text,
  `iddepartamento` int DEFAULT NULL,
  `idmunicipio` int DEFAULT NULL,
  `genero` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `matriculas`
--

INSERT INTO `matriculas` (`carnet`, `nombres`, `apellidos`, `telefono`, `email`, `direccion`, `iddepartamento`, `idmunicipio`, `genero`) VALUES
('AL2242', 'Carlos Alfredo', 'Alvarez Lopez', '1111-1120', 'al2242@uls.edu.sv', 'San Juan Nonualco', 6, 102, 'M'),
('AM01137352', 'Diana Carolina ', 'Alvarado Mejia', '1111-1129', 'am01137352@uls.edu.sv', 'Santiago Nonualco La paz', 6, 112, 'F'),
('AM01137399', 'Anthony Steven', 'Alvarenga Menéndez', '1111-1118', 'am01137399@uls.edu.sv', 'SS', 2, 13, 'M'),
('AZ01137379', 'Ana Beatriz', 'Argueta Zelaya', '1111-1111', 'az01137379@uls.edu.sv', 'San Juan Talpa, ', 6, 103, 'F'),
('BC01137313', ' Samuel Ernesto', 'Beltran Castillo', '1111-1112', 'bc01137313@uls.edu.sv', 'SS', 6, 97, 'M'),
('CH01137269', 'Salvador Josué', 'Cisneros Hernández', '7985 1543', 'ch01137269@uls.edu.sv', 'SS', 6, 114, 'M'),
('CQ01137436', 'Jason Giovanni', 'Chacon Quintanilla', '1111-1114', 'CQ01137436@uls.edu.sv', 'SS', 10, 192, 'M'),
('CT01137543', 'Rene Orlando', 'CarranzaToloza', '1111-1119', 'ct01137543@uls.edu.sv', 'Zacatecoluca', 6, 114, 'M'),
('DB2245', 'Rafael Eduardo', 'Dominguez Biche', '1111-1117', 'db2245@uls.edu.sv', 'zacatecoluca', 6, 114, 'M'),
('DR01136018', 'José Abel ', 'Delcid Rivas', '1111-1123', 'dr01136018@uls.edu.sv', 'LP', 6, 114, 'M'),
('ds01137487', 'Karen Abigail ', 'Deleon Sanchez', '1111-1117', 'ds01137487@uls.edu.sv', 'SS', 10, 186, 'F'),
('GC01137370', 'Gabriela Stefany', 'Gregorio Cubías', '1111-1132', 'gc01137370@uls.edu.sv', 'SS', 10, 193, 'F'),
('GO01137220', 'Balduino Ernesto', 'Gómez Ortiz', '1111-1126', 'go01137220@uls.edu.sv', 'SS', 10, 193, 'M'),
('HS01137376', 'Diego Alejandro', 'Henriquez Segovia', '1111-1115', 'hs01137376@uls.edu.sv', 'SS', 6, 94, 'M'),
('LR01137350', 'Javier Enrique', 'Lopez Ramirez', '1111-1124', 'lr01137350@uls.edu.sv', 'Olocuilta', 6, 97, 'M'),
('LT01132122', 'David Ancelmo ', 'Lemus Turcios', '1111-1130', 'LT01132122@uls.edu.sv', 'Usulután', 14, 252, 'M'),
('MC01137153', 'Jose David', 'Martinez Chavez', '1111-1115', 'mc01137153@uls.edu.sv', 'San Salvador', 10, 80, 'M'),
('MG01136050', 'Moises', 'Mozo Garcia', '1111-1128', 'mg01136050@uls.edu.sv', 'Cuyultitan', 6, 93, 'M'),
('MJ01137252', 'Noemy Marisol', 'Mejia Jacinto', '1111-1127', 'mj01137252@uls.edu.sv', 'CANDELARIA', 4, 55, 'F'),
('ML01137152', 'Cristofer Eduardo', 'Mendoza Lòpez', '1111-1125', 'ml01137152@uls.edu.sv', 'SS', 10, 194, 'M'),
('MR01137320', 'Elizabeth Carolina ', 'Morales Rodriguez', '1111-1118', 'mr01137320@uls.edu.sv', 'Troncal del norte', 10, 182, 'F'),
('NO01137273', 'Miguel Angel', 'Nolasco Osorio', '1111-1121', 'no01137273@uls.edu.sv', 'LP', 6, 114, 'M'),
('OM01137298', 'Madeline Marisela', 'Ortiz Mejía', '1111-1116', 'om01137298@uls.edu.sv', 'SS', 10, 190, 'F'),
('PH01137391', 'Diana Beatriz', 'Perez Hernandez ', '1111-1116', 'ph01137391@uls.edu.sv', 'San Salvador', 10, 10, 'M'),
('QV01137367', 'David Eugenio', 'Quinteros Valles', '1111-1122', 'qv01137367@uls.edu.sv', 'SS', 6, 97, 'M'),
('RA01137239', 'Willian Antonio', 'Romero Alvarado', '1111-1112', 'ra01137239@uls,edu,sv', 'El Rosario, La Paz', 6, 94, 'M'),
('RB01137486', 'Gerardo Alfonso', 'Rivas Barrios', '1111-1111', 'rb01137486@uls.edu.sv', 'SS', 10, 194, 'M'),
('RF01137446', 'Carlos Javier', 'Rivera Flores', '1111-1114', 'rf01137446@uls.edu.sv', 'Santa Tecla', 5, 80, 'M'),
('RM01137191', 'Juan Carlos', 'Rauda Martínez', '1111-1122', 'rm01137191@uls.edu.sv', 'SS', 10, 194, 'M'),
('RM01137266', 'Yenifer Raquel ', 'Rivas Mejia', '1111-1113', 'rm01137266@uls.edu.sv', 'Santiago Nonualco', 6, 112, 'F'),
('RP01137145', 'Jose Saul', 'Raymundo perez', '1111-1123', 'rp01137145@uls.edu.sv', 'San Salvador', 10, 195, 'm'),
('S01137521', 'Maricela Guadalupe', 'Sànchez', '1111-1131', 's01137521@uls.edu.sv', 'San Salvador', 10, 191, 'F'),
('VM01137362', 'Sebastiàn Emilio', 'Vásquez Mejía', '1111-1120', 'vm01137362@uls.edu.sv', 'LP', 6, 112, 'M'),
('ZS01137002', 'Dennis Steven', 'Zaldaña Sanchez', '1111-1119', 'zs01137002@uls.edu.sv', 'SS', 10, 193, 'M');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `municipios`
--

CREATE TABLE `municipios` (
  `idmunicipio` int NOT NULL,
  `municipio` varchar(100) DEFAULT NULL,
  `iddepartamento` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `municipios`
--

INSERT INTO `municipios` (`idmunicipio`, `municipio`, `iddepartamento`) VALUES
(1, 'Ahuachapán', 1),
(2, 'Apaneca', 1),
(3, 'Atiquizaya', 1),
(4, 'Concepción de Ataco', 1),
(5, 'El Refugio', 1),
(6, 'Guaymango', 1),
(7, 'Jujutla', 1),
(8, 'San Francisco Menéndez', 1),
(9, 'San Lorenzo', 1),
(10, 'San Pedro Puxtla', 1),
(11, 'Tacuba', 1),
(12, 'Turín', 1),
(13, 'Cinquera', 2),
(14, 'Dolores', 2),
(15, 'Guacotecti', 2),
(16, 'Ilobasco', 2),
(17, 'Jutiapa', 2),
(18, 'San Isidro', 2),
(19, 'Sensuntepeque', 2),
(20, 'Tejutepeque', 2),
(21, 'Victoria', 2),
(22, 'Agua Caliente', 3),
(23, 'Arcatao', 3),
(24, 'Azacualpa', 3),
(25, 'Chalatenango', 3),
(26, 'Comalapa', 3),
(27, 'Citalá', 3),
(28, 'Concepción Quezaltepeque', 3),
(29, 'Dulce Nombre de María', 3),
(30, 'El Carrizal', 3),
(31, 'El Paraíso', 3),
(32, 'La Laguna', 3),
(33, 'La Palma', 3),
(34, 'La Reina', 3),
(35, 'Las Vueltas', 3),
(36, 'Nueva Concepción', 3),
(37, 'Nueva Trinidad', 3),
(38, 'Nombre de Jesús', 3),
(39, 'Ojos de Agua', 3),
(40, 'Potonico', 3),
(41, 'San Antonio de la Cruz', 3),
(42, 'San Antonio Los Ranchos', 3),
(43, 'San Fernando', 3),
(44, 'San Francisco Lempa', 3),
(45, 'San Francisco Morazán', 3),
(46, 'San Ignacio', 3),
(47, 'San Isidro Labrador', 3),
(48, 'San José Cancasque', 3),
(49, 'San José Las Flores', 3),
(50, 'San Luis del Carmen', 3),
(51, 'San Miguel de Mercedes', 3),
(52, 'San Rafael', 3),
(53, 'Santa Rita', 3),
(54, 'Tejutla', 3),
(55, 'Candelaria', 4),
(56, 'Cojutepeque', 4),
(57, 'El Carmen', 4),
(58, 'El Rosario', 4),
(59, 'Monte San Juan', 4),
(60, 'Oratorio de Concepción', 4),
(61, 'San Bartolomé Perulapía', 4),
(62, 'San Cristóbal', 4),
(63, 'San José Guayabal', 4),
(64, 'San Pedro Perulapán', 4),
(65, 'San Rafael Cedros', 4),
(66, 'San Ramón', 4),
(67, 'Santa Cruz Analquito', 4),
(68, 'Santa Cruz Michapa', 4),
(69, 'Suchitoto', 4),
(70, 'Tenancingo', 4),
(71, 'Antiguo Cuscatlán', 5),
(72, 'Chiltiupán', 5),
(73, 'Ciudad Arce', 5),
(74, 'Colón', 5),
(75, 'Comasagua', 5),
(76, 'Huizúcar', 5),
(77, 'Jayaque', 5),
(78, 'Jicalapa', 5),
(79, 'La Libertad', 5),
(80, 'Santa Tecla', 5),
(81, 'Nuevo Cuscatlán', 5),
(82, 'San Juan Opico', 5),
(83, 'Quezaltepeque', 5),
(84, 'Sacacoyo', 5),
(85, 'San José Villanueva', 5),
(86, 'San Matías', 5),
(87, 'San Pablo Tacachico', 5),
(88, 'Talnique', 5),
(89, 'Tamanique', 5),
(90, 'Teotepeque', 5),
(91, 'Tepecoyo', 5),
(92, 'Zaragoza', 5),
(93, 'Cuyultitán', 6),
(94, 'El Rosario', 6),
(95, 'Jerusalén', 6),
(96, 'Mercedes La Ceiba', 6),
(97, 'Olocuilta', 6),
(98, 'Paraíso de Osorio', 6),
(99, 'San Antonio Masahuat', 6),
(100, 'San Emigdio', 6),
(101, 'San Francisco Chinameca', 6),
(102, 'San Juan Nonualco', 6),
(103, 'San Juan Talpa', 6),
(104, 'San Juan Tepezontes', 6),
(105, 'San Luis Talpa', 6),
(106, 'San Luis La Herradura', 6),
(107, 'San Miguel Tepezontes', 6),
(108, 'San Pedro Masahuat', 6),
(109, 'San Pedro Nonualco', 6),
(110, 'San Rafael Obrajuelo', 6),
(111, 'Santa María Ostuma', 6),
(112, 'Santiago Nonualco', 6),
(113, 'Tapalhuaca', 6),
(114, 'Zacatecoluca', 6),
(115, 'Anamorós', 7),
(116, 'Bolívar', 7),
(117, 'Concepción de Oriente', 7),
(118, 'Conchagua', 7),
(119, 'El Carmen', 7),
(120, 'El Sauce', 7),
(121, 'Intipucá', 7),
(122, 'La Unión', 7),
(123, 'Lislique', 7),
(124, 'Meanguera del Golfo', 7),
(125, 'Nueva Esparta', 7),
(126, 'Pasaquina', 7),
(127, 'Polorós', 7),
(128, 'San Alejo', 7),
(129, 'San José', 7),
(130, 'Santa Rosa de Lima', 7),
(131, 'Yayantique', 7),
(132, 'Yucuaiquín', 7),
(133, 'Arambala', 8),
(134, 'Cacaopera', 8),
(135, 'Chilanga', 8),
(136, 'Corinto', 8),
(137, 'Delicias de Concepción', 8),
(138, 'El Divisadero', 8),
(139, 'El Rosario', 8),
(140, 'Gualococti', 8),
(141, 'Guatajiagua', 8),
(142, 'Joateca', 8),
(143, 'Jocoaitique', 8),
(144, 'Jocoro', 8),
(145, 'Lolotiquillo', 8),
(146, 'Meanguera', 8),
(147, 'Osicala', 8),
(148, 'Perquín', 8),
(149, 'San Carlos', 8),
(150, 'San Fernando', 8),
(151, 'San Francisco Gotera', 8),
(152, 'San Isidro', 8),
(153, 'San Simón', 8),
(154, 'Sensembra', 8),
(155, 'Sociedad', 8),
(156, 'Torola', 8),
(157, 'Yamabal', 8),
(158, 'Yoloaiquín', 8),
(159, 'Carolina', 9),
(160, 'Chapeltique', 9),
(161, 'Chinameca', 9),
(162, 'Chirilagua', 9),
(163, 'Ciudad Barrios', 9),
(164, 'Comacarán', 9),
(165, 'El Tránsito', 9),
(166, 'Lolotique', 9),
(167, 'Moncagua', 9),
(168, 'Nueva Guadalupe', 9),
(169, 'Nuevo Edén de San Juan', 9),
(170, 'Quelepa', 9),
(171, 'San Antonio del Mosco', 9),
(172, 'San Gerardo', 9),
(173, 'San Jorge', 9),
(174, 'San Luis de la Reina', 9),
(175, 'San Miguel', 9),
(176, 'San Rafael Oriente', 9),
(177, 'Sesori', 9),
(178, 'Uluazapa', 9),
(179, 'Aguilares', 10),
(180, 'Apopa', 10),
(181, 'Ayutuxtepeque', 10),
(182, 'Cuscatancingo', 10),
(183, 'Ciudad Delgado', 10),
(184, 'El Paisnal', 10),
(185, 'Guazapa', 10),
(186, 'Ilopango', 10),
(187, 'Mejicanos', 10),
(188, 'Nejapa', 10),
(189, 'Panchimalco', 10),
(190, 'Rosario de Mora', 10),
(191, 'San Marcos', 10),
(192, 'San Martín', 10),
(193, 'San Salvador', 10),
(194, 'Santiago Texacuangos', 10),
(195, 'Santo Tomás', 10),
(196, 'Soyapango', 10),
(197, 'Tonacatepeque', 10),
(198, 'Apastepeque', 11),
(199, 'Guadalupe', 11),
(200, 'San Cayetano Istepeque', 11),
(201, 'San Esteban Catarina', 11),
(202, 'San Ildefonso', 11),
(203, 'San Lorenzo', 11),
(204, 'San Sebastián', 11),
(205, 'San Vicente', 11),
(206, 'Santa Clara', 11),
(207, 'Santo Domingo', 11),
(208, 'Tecoluca', 11),
(209, 'Tepetitán', 11),
(210, 'Verapaz', 11),
(211, 'Candelaria de la Frontera', 12),
(212, 'Chalchuapa', 12),
(213, 'Coatepeque', 12),
(214, 'El Congo', 12),
(215, 'El Porvenir', 12),
(216, 'Masahuat', 12),
(217, 'Metapán', 12),
(218, 'San Antonio Pajonal', 12),
(219, 'San Sebastián Salitrillo', 12),
(220, 'Santa Ana', 12),
(221, 'Santa Rosa Guachipilín', 12),
(222, 'Santiago de la Frontera', 12),
(223, 'Texistepeque', 12),
(224, 'Acajutla', 13),
(225, 'Armenia', 13),
(226, 'Caluco', 13),
(227, 'Cuisnahuat', 13),
(228, 'Izalco', 13),
(229, 'Juayúa', 13),
(230, 'Nahuizalco', 13),
(231, 'Nahulingo', 13),
(232, 'Salcoatitán', 13),
(233, 'San Antonio del Monte', 13),
(234, 'San Julián', 13),
(235, 'Santa Catarina Masahuat', 13),
(236, 'Santa Isabel Ishuatán', 13),
(237, 'Santo Domingo Guzmán', 13),
(238, 'Sonsonate', 13),
(239, 'Sonzacate', 13),
(240, 'Alegría', 14),
(241, 'Berlín', 14),
(242, 'California', 14),
(243, 'Concepción Batres', 14),
(244, 'El Triunfo', 14),
(245, 'Ereguayquín', 14),
(246, 'Estanzuelas', 14),
(247, 'Jiquilisco', 14),
(248, 'Jucuapa', 14),
(249, 'Jucuarán', 14),
(250, 'Mercedes Umaña', 14),
(251, 'Nueva Granada', 14),
(252, 'Ozatlán', 14),
(253, 'Puerto El Triunfo', 14),
(254, 'San Agustín', 14),
(255, 'San Buenaventura', 14),
(256, 'San Dionisio', 14),
(257, 'San Francisco Javier', 14),
(258, 'Santa Elena', 14),
(259, 'Santa María', 14),
(260, 'Santiago de María', 14),
(261, 'Tecapán', 14),
(262, 'Usulután', 14);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notas`
--

CREATE TABLE `notas` (
  `idnota` int NOT NULL,
  `carnet` varchar(15) DEFAULT NULL,
  `idgrupo` int DEFAULT NULL,
  `nota_1` float DEFAULT NULL,
  `nota_2` float DEFAULT NULL,
  `nota_3` float DEFAULT NULL,
  `nota_4` float DEFAULT NULL,
  `promedio` float DEFAULT NULL,
  `n_reposicion` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_docente`
--

CREATE TABLE `tipo_docente` (
  `idtipodocente` int NOT NULL,
  `tipo` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `tipo_docente`
--

INSERT INTO `tipo_docente` (`idtipodocente`, `tipo`) VALUES
(1, 'Hora Clase'),
(2, 'Tiempo Completo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_usuario`
--

CREATE TABLE `tipo_usuario` (
  `idtipo` int NOT NULL,
  `tipo` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `tipo_usuario`
--

INSERT INTO `tipo_usuario` (`idtipo`, `tipo`) VALUES
(1, 'Administrador'),
(2, 'Coordinación'),
(3, 'Administración_Académica');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `idusuario` int NOT NULL,
  `usuario` varchar(50) DEFAULT NULL,
  `clave` text,
  `tipo` int DEFAULT NULL,
  `estado` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`idusuario`, `usuario`, `clave`, `tipo`, `estado`) VALUES
(1, 'admin', 'Admin2022', 1, 1),
(2, 'jperez', 'Academico2022', 2, 1),
(3, 'gcampos', 'Academica2022', 3, 1);

-- --------------------------------------------------------

--
-- Estructura para la vista `DataEstudante`
--
DROP TABLE IF EXISTS `DataEstudante`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`localhost` SQL SECURITY DEFINER VIEW `DataEstudante`  AS  select `ma`.`carnet` AS `Carnet`,concat(`ma`.`nombres`,' ',`ma`.`apellidos`) AS `Estudiante`,`d`.`departamento` AS `Departamento`,`mu`.`municipio` AS `Municipio` from ((`matriculas` `ma` join `departamentos` `d` on((`d`.`iddepartamento` = `ma`.`iddepartamento`))) join `municipios` `mu` on((`mu`.`idmunicipio` = `ma`.`idmunicipio`))) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `DataGrupo`
--
DROP TABLE IF EXISTS `DataGrupo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`localhost` SQL SECURITY DEFINER VIEW `DataGrupo`  AS  select `mat`.`materia` AS `Materia`,concat(`d`.`nombres`,' ',`d`.`apellidos`) AS `Docente`,concat(`h`.`dia`,' ',`h`.`hora`,' ',`h`.`tipo`) AS `Horario`,concat(`au`.`tipo`,' ',`au`.`aula`) AS `Aula`,`gru`.`fecha` AS `Fecha`,`us`.`usuario` AS `Usuario_Registro` from (((((`grupos` `gru` join `materias` `mat` on((`mat`.`idmateria` = `gru`.`idmateria`))) join `docentes` `d` on((`d`.`iddocente` = `gru`.`iddocente`))) join `horarios` `h` on((`h`.`idhorario` = `gru`.`idhorario`))) join `aulas` `au` on((`au`.`idaula` = `gru`.`idaula`))) join `usuarios` `us` on((`us`.`idusuario` = `gru`.`idusuario`))) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `DataGrupos`
--
DROP TABLE IF EXISTS `DataGrupos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`localhost` SQL SECURITY DEFINER VIEW `DataGrupos`  AS  select `mat`.`materia` AS `Materia`,concat(`d`.`nombres`,' ',`d`.`apellidos`) AS `Docente`,concat(`h`.`dia`,' ',`h`.`hora`,' ',`h`.`tipo`) AS `Horario`,concat(`au`.`tipo`,' ',`au`.`aula`) AS `Aula`,`gru`.`fecha` AS `Fecha Registro`,`us`.`usuario` AS `Usuario` from (((((`grupos` `gru` join `materias` `mat` on((`mat`.`idmateria` = `gru`.`idmateria`))) join `docentes` `d` on((`d`.`iddocente` = `gru`.`iddocente`))) join `horarios` `h` on((`h`.`idhorario` = `gru`.`idhorario`))) join `aulas` `au` on((`au`.`idaula` = `gru`.`idaula`))) join `usuarios` `us` on((`us`.`idusuario` = `gru`.`idusuario`))) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `aulas`
--
ALTER TABLE `aulas`
  ADD PRIMARY KEY (`idaula`);

--
-- Indices de la tabla `ciclos`
--
ALTER TABLE `ciclos`
  ADD PRIMARY KEY (`idciclo`);

--
-- Indices de la tabla `departamentos`
--
ALTER TABLE `departamentos`
  ADD PRIMARY KEY (`iddepartamento`);

--
-- Indices de la tabla `docentes`
--
ALTER TABLE `docentes`
  ADD PRIMARY KEY (`iddocente`),
  ADD KEY `iddepartamento` (`iddepartamento`),
  ADD KEY `idmunicipio` (`idmunicipio`),
  ADD KEY `idtipodocente` (`idtipodocente`);

--
-- Indices de la tabla `grupos`
--
ALTER TABLE `grupos`
  ADD PRIMARY KEY (`idgrupo`),
  ADD KEY `idaula` (`idaula`),
  ADD KEY `grupos_ibfk_1` (`idmateria`),
  ADD KEY `grupos_ibfk_2` (`iddocente`),
  ADD KEY `grupos_ibfk_3` (`idhorario`),
  ADD KEY `grupos_ibfk_5` (`idusuario`);

--
-- Indices de la tabla `horarios`
--
ALTER TABLE `horarios`
  ADD PRIMARY KEY (`idhorario`);

--
-- Indices de la tabla `inscripciones`
--
ALTER TABLE `inscripciones`
  ADD PRIMARY KEY (`idinscripcion`),
  ADD KEY `carnet` (`carnet`),
  ADD KEY `idgrupo` (`idgrupo`);

--
-- Indices de la tabla `materias`
--
ALTER TABLE `materias`
  ADD PRIMARY KEY (`idmateria`);

--
-- Indices de la tabla `matriculas`
--
ALTER TABLE `matriculas`
  ADD PRIMARY KEY (`carnet`),
  ADD KEY `iddepartamento` (`iddepartamento`),
  ADD KEY `idmunicipio` (`idmunicipio`);

--
-- Indices de la tabla `municipios`
--
ALTER TABLE `municipios`
  ADD PRIMARY KEY (`idmunicipio`),
  ADD KEY `iddepartamento` (`iddepartamento`);

--
-- Indices de la tabla `notas`
--
ALTER TABLE `notas`
  ADD PRIMARY KEY (`idnota`),
  ADD KEY `carnet` (`carnet`),
  ADD KEY `idgrupo` (`idgrupo`);

--
-- Indices de la tabla `tipo_docente`
--
ALTER TABLE `tipo_docente`
  ADD PRIMARY KEY (`idtipodocente`);

--
-- Indices de la tabla `tipo_usuario`
--
ALTER TABLE `tipo_usuario`
  ADD PRIMARY KEY (`idtipo`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`idusuario`),
  ADD KEY `tipo` (`tipo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `aulas`
--
ALTER TABLE `aulas`
  MODIFY `idaula` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `ciclos`
--
ALTER TABLE `ciclos`
  MODIFY `idciclo` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `departamentos`
--
ALTER TABLE `departamentos`
  MODIFY `iddepartamento` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `docentes`
--
ALTER TABLE `docentes`
  MODIFY `iddocente` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `grupos`
--
ALTER TABLE `grupos`
  MODIFY `idgrupo` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `horarios`
--
ALTER TABLE `horarios`
  MODIFY `idhorario` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `inscripciones`
--
ALTER TABLE `inscripciones`
  MODIFY `idinscripcion` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `materias`
--
ALTER TABLE `materias`
  MODIFY `idmateria` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `municipios`
--
ALTER TABLE `municipios`
  MODIFY `idmunicipio` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=263;

--
-- AUTO_INCREMENT de la tabla `notas`
--
ALTER TABLE `notas`
  MODIFY `idnota` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tipo_docente`
--
ALTER TABLE `tipo_docente`
  MODIFY `idtipodocente` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tipo_usuario`
--
ALTER TABLE `tipo_usuario`
  MODIFY `idtipo` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `idusuario` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `docentes`
--
ALTER TABLE `docentes`
  ADD CONSTRAINT `docentes_ibfk_1` FOREIGN KEY (`iddepartamento`) REFERENCES `departamentos` (`iddepartamento`),
  ADD CONSTRAINT `docentes_ibfk_2` FOREIGN KEY (`idmunicipio`) REFERENCES `municipios` (`idmunicipio`),
  ADD CONSTRAINT `docentes_ibfk_3` FOREIGN KEY (`idtipodocente`) REFERENCES `tipo_docente` (`idtipodocente`);

--
-- Filtros para la tabla `grupos`
--
ALTER TABLE `grupos`
  ADD CONSTRAINT `grupos_ibfk_1` FOREIGN KEY (`idmateria`) REFERENCES `materias` (`idmateria`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `grupos_ibfk_2` FOREIGN KEY (`iddocente`) REFERENCES `docentes` (`iddocente`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `grupos_ibfk_3` FOREIGN KEY (`idhorario`) REFERENCES `horarios` (`idhorario`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `grupos_ibfk_4` FOREIGN KEY (`idaula`) REFERENCES `aulas` (`idaula`),
  ADD CONSTRAINT `grupos_ibfk_5` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`idusuario`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Filtros para la tabla `inscripciones`
--
ALTER TABLE `inscripciones`
  ADD CONSTRAINT `inscripciones_ibfk_1` FOREIGN KEY (`carnet`) REFERENCES `matriculas` (`carnet`),
  ADD CONSTRAINT `inscripciones_ibfk_2` FOREIGN KEY (`idgrupo`) REFERENCES `grupos` (`idgrupo`);

--
-- Filtros para la tabla `matriculas`
--
ALTER TABLE `matriculas`
  ADD CONSTRAINT `matriculas_ibfk_1` FOREIGN KEY (`iddepartamento`) REFERENCES `departamentos` (`iddepartamento`),
  ADD CONSTRAINT `matriculas_ibfk_2` FOREIGN KEY (`idmunicipio`) REFERENCES `municipios` (`idmunicipio`);

--
-- Filtros para la tabla `municipios`
--
ALTER TABLE `municipios`
  ADD CONSTRAINT `municipios_ibfk_1` FOREIGN KEY (`iddepartamento`) REFERENCES `departamentos` (`iddepartamento`);

--
-- Filtros para la tabla `notas`
--
ALTER TABLE `notas`
  ADD CONSTRAINT `notas_ibfk_1` FOREIGN KEY (`carnet`) REFERENCES `matriculas` (`carnet`),
  ADD CONSTRAINT `notas_ibfk_2` FOREIGN KEY (`idgrupo`) REFERENCES `grupos` (`idgrupo`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`tipo`) REFERENCES `tipo_usuario` (`idtipo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
