<?php
@session_start();
include '../../models/conexion.php';
include '../../models/funciones.php';
include '../../controllers/funciones.php';

$detalle = $_POST['detalle'];
$idcategoria = $_POST['idcategoria'];
$fecha_registro = $_POST['fecha_registro'];

/* Data del documento */
$file = $_FILES['documento']['name'];
$tmp_dir = $_FILES['documento']['tmp_name'];
$fileSize = $_FILES['documento']['size'];

$path = "../archivos/";
$imgExt = strtolower(pathinfo($file, PATHINFO_EXTENSION));
$newName = $detalle.".".$imgExt;

$carga_file = CargaDocumento($tmp_dir,$newName,$path);

$insert = CRUD("INSERT INTO documentos (detalle,idcategoria,fecha_registro,ruta) VALUES('$detalle','$idcategoria','$fecha_registro','$newName')","i");

if($insert){
    header("Location: ./principal.php");
}
else{
    header("Location: ./principal.php");
}


