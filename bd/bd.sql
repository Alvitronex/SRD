-- Active: 1701534432111@@127.0.0.1@3306@bd_poo
CREATE DATABASE bd_poo;

USE bd_poo;

CREATE TABLE usuarios(
    idusuario INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    usuario VARCHAR(50),
    passw TEXT,
    estado INT
); 

CREATE TABLE categorias(
    idcategoria INT PRIMARY KEY auto_increment,
    categoria TEXT,
    estado INT
);

CREATE TABLE documentos(
    iddocumento INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    detalle TEXT,
    idcategoria INT,
    fecha_registro DATE,
    ruta TEXT
);