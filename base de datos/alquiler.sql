-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 02-09-2022 a las 18:29:08
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `alquiler`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alquiler`
--

CREATE TABLE `alquiler` (
  `id` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_vehiculo` int(11) NOT NULL,
  `num_dias` int(11) NOT NULL,
  `precio_dia` decimal(10,2) NOT NULL,
  `abono` decimal(10,2) NOT NULL,
  `fecha_prestamo` date NOT NULL,
  `hora` time NOT NULL,
  `fecha_devolucion` date NOT NULL,
  `id_doc` int(11) NOT NULL,
  `observacion` text DEFAULT NULL,
  `estado` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `alquiler`
--

INSERT INTO `alquiler` (`id`, `id_cliente`, `id_vehiculo`, `num_dias`, `precio_dia`, `abono`, `fecha_prestamo`, `hora`, `fecha_devolucion`, `id_doc`, `observacion`, `estado`) VALUES
(1, 1, 1, 2, '20.00', '10.00', '2021-11-22', '16:32:26', '2021-11-24', 1, '', 0),
(2, 3, 2, 3, '50.00', '60.00', '2021-11-22', '16:44:31', '2021-11-25', 2, '', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` int(11) NOT NULL,
  `dni` varchar(10) DEFAULT NULL,
  `nombre` varchar(100) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `direccion` text NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `estado` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `dni`, `nombre`, `telefono`, `direccion`, `fecha`, `estado`) VALUES
(1, '978798789', 'ALEX ROMERO', '97899789', 'BOLIVIA', '2022-09-02 13:58:44', 1),
(2, '123456789', 'LEOPOLDO CAMPERO', '798461378', 'TARIJA ', '2022-09-02 13:58:44', 1),
(3, '1234567', 'CARLOS MONTES', '925491523', 'ARGENTINA', '2022-09-02 13:58:44', 1),
(4, '15687', 'JOSE CAMPERO', '4698877', 'C/MENDEZ', '2022-09-02 16:18:07', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion`
--

CREATE TABLE `configuracion` (
  `id` int(11) NOT NULL,
  `ruc` varchar(20) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `direccion` varchar(200) NOT NULL,
  `mensaje` text NOT NULL,
  `logo` varchar(10) NOT NULL,
  `moneda` int(11) NOT NULL,
  `impuesto` int(11) NOT NULL,
  `cant_factura` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `configuracion`
--

INSERT INTO `configuracion` (`id`, `ruc`, `nombre`, `telefono`, `correo`, `direccion`, `mensaje`, `logo`, `moneda`, `impuesto`, `cant_factura`) VALUES
(1, '12345678910', 'ALQUILER MOVILES', '963852147', 'alexromerojuarez5@gmail.com', 'BOLIVIA', 'GRACIAS POR SU ELECCION', 'logo.png', 2, 18, 1000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documentos`
--

CREATE TABLE `documentos` (
  `id` int(11) NOT NULL,
  `documento` varchar(20) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `documentos`
--

INSERT INTO `documentos` (`id`, `documento`, `estado`, `fecha`) VALUES
(1, 'DNI', 1, '2021-11-11 16:43:11'),
(2, 'PASAPORTE', 1, '2021-11-12 14:02:04'),
(3, 'CI', 1, '2022-09-02 14:00:26'),
(4, 'VISA', 1, '2022-09-02 16:18:43');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marcas`
--

CREATE TABLE `marcas` (
  `id` int(11) NOT NULL,
  `marca` varchar(50) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `marcas`
--

INSERT INTO `marcas` (`id`, `marca`, `estado`, `fecha`) VALUES
(1, 'FERRARI', 1, '2021-11-11 18:45:57'),
(2, 'HONDA', 1, '2021-11-11 18:46:06'),
(3, 'NISAN', 1, '2021-11-11 18:46:19'),
(4, 'TOYOTA', 1, '2021-11-11 18:46:28'),
(5, 'VOLVO', 1, '2021-11-11 18:46:38'),
(6, 'SUZUKI', 1, '2021-11-11 18:46:53'),
(7, 'MORGAN', 1, '2021-11-11 18:47:22'),
(8, 'TESLA', 0, '2022-09-02 16:15:06'),
(9, 'HIUNDAY', 1, '2022-09-02 16:15:21');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `moneda`
--

CREATE TABLE `moneda` (
  `id` int(11) NOT NULL,
  `simbolo` varchar(10) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `estado` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `moneda`
--

INSERT INTO `moneda` (`id`, `simbolo`, `nombre`, `fecha`, `estado`) VALUES
(1, 'PEN', 'NUEVO SOLES', '2021-10-22 16:06:22', 1),
(2, 'BS', 'BOLIVIANOS', '2022-09-02 14:01:14', 1),
(3, '$', 'DOLAR', '2022-09-02 14:01:14', 1),
(4, '%', 'EURO', '2022-09-02 16:14:07', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipos`
--

CREATE TABLE `tipos` (
  `id` int(11) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tipos`
--

INSERT INTO `tipos` (`id`, `tipo`, `estado`, `fecha`) VALUES
(1, 'CAMIONETA', 1, '2021-11-11 14:44:50'),
(2, 'MINI BAN', 1, '2021-11-11 14:46:20'),
(3, 'MOTOCICLETA', 1, '2021-11-11 18:48:32'),
(4, 'MOTO CARRO', 1, '2021-11-11 18:48:55'),
(5, 'TURISMO', 1, '2021-11-11 18:49:13'),
(6, 'CAMION', 1, '2021-11-11 18:49:21'),
(7, 'Furgón', 1, '2021-11-11 18:49:54'),
(8, 'BICICLETA', 0, '2022-09-02 16:15:58');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `usuario` varchar(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) DEFAULT NULL,
  `correo` varchar(80) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `perfil` varchar(50) NOT NULL DEFAULT 'avatar.svg',
  `clave` varchar(100) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `estado` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `usuario`, `nombre`, `apellido`, `correo`, `telefono`, `direccion`, `perfil`, `clave`, `fecha`, `estado`) VALUES
(1, 'ADMIN', 'ALEX', 'ROMERO', 'alexromerojuarez5@gmail.com', '925491523', 'AV. AMERICAS', '20220902160534.jpg', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '2022-09-02 15:11:01', 1),
(2, 'ANGEL', 'ANGEL SIFUENTES', '', 'angel@gmail.com', '797987897', 'Calle Santa Cruz', 'avatar.svg', '519ba91a5a5b4afb9dc66f8805ce8c442b6576316c19c6896af2fa9bda6aff71', '2022-09-02 14:04:34', 1),
(3, 'LEOPOLDO', 'LEOPOLDO', 'CAMPERO', 'leopoldo@gmail.com', '879797977997', 'Av. Octavio', 'avatar.svg', '94aec9fbed989ece189a7e172c9cf41669050495152bc4c1dbf2a38d7fd85627', '2022-09-02 14:04:34', 1),
(4, 'GERMAN', 'GERMAN', NULL, 'prueba@gmail.com', '4235', NULL, 'avatar.svg', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', '2022-09-02 16:04:33', 1),
(5, 'GERO', 'GERO', NULL, 'PRUEBA3@GAMIL.COM', '52345', NULL, 'avatar.svg', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '2022-09-02 16:13:40', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehiculos`
--

CREATE TABLE `vehiculos` (
  `id` int(11) NOT NULL,
  `placa` varchar(50) NOT NULL,
  `id_marca` int(11) NOT NULL,
  `id_tipo` int(11) NOT NULL,
  `modelo` varchar(50) NOT NULL,
  `foto` varchar(50) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `vehiculos`
--

INSERT INTO `vehiculos` (`id`, `placa`, `id_marca`, `id_tipo`, `modelo`, `foto`, `estado`, `fecha`) VALUES
(1, '79798987', 1, 1, 'X-47', '20211111102853.jpg', 1, '2022-09-02 14:12:57'),
(2, '7987798', 2, 4, '46564CFR', '20220902161226.jpg', 1, '2022-09-02 14:12:26'),
(3, '78979', 4, 5, 'KI78', '20220902161144.jpg', 1, '2022-09-02 14:11:44'),
(4, 'RTG3243', 1, 3, '223R', '20220902181652.jpg', 1, '2022-09-02 16:16:52');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alquiler`
--
ALTER TABLE `alquiler`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_vehiculo` (`id_vehiculo`),
  ADD KEY `id_doc` (`id_doc`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `moneda` (`moneda`);

--
-- Indices de la tabla `documentos`
--
ALTER TABLE `documentos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `marcas`
--
ALTER TABLE `marcas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `moneda`
--
ALTER TABLE `moneda`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipos`
--
ALTER TABLE `tipos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `vehiculos`
--
ALTER TABLE `vehiculos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_marca` (`id_marca`),
  ADD KEY `id_tipo` (`id_tipo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alquiler`
--
ALTER TABLE `alquiler`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `documentos`
--
ALTER TABLE `documentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `marcas`
--
ALTER TABLE `marcas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `moneda`
--
ALTER TABLE `moneda`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tipos`
--
ALTER TABLE `tipos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `vehiculos`
--
ALTER TABLE `vehiculos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `alquiler`
--
ALTER TABLE `alquiler`
  ADD CONSTRAINT `alquiler_ibfk_1` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `alquiler_ibfk_2` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `alquiler_ibfk_3` FOREIGN KEY (`id_doc`) REFERENCES `documentos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `configuracion`
--
ALTER TABLE `configuracion`
  ADD CONSTRAINT `configuracion_ibfk_1` FOREIGN KEY (`moneda`) REFERENCES `moneda` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `vehiculos`
--
ALTER TABLE `vehiculos`
  ADD CONSTRAINT `vehiculos_ibfk_1` FOREIGN KEY (`id_tipo`) REFERENCES `tipos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `vehiculos_ibfk_2` FOREIGN KEY (`id_marca`) REFERENCES `marcas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
