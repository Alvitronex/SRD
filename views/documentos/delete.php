<?php
@session_start();
include '../../models/conexion.php';
include '../../models/funciones.php';
include '../../controllers/funciones.php';

$iddocumento = $_POST['iddocumento'];

$ruta = buscavalor("documentos","ruta","iddocumento='$iddocumento'");
// Ruta del archivo a eliminar
$rutaArchivo = '../archivos/'.$ruta;

// Intenta eliminar el archivo
unlink($rutaArchivo);

$delete = CRUD("DELETE FROM documentos WHERE iddocumento='$iddocumento'", "d");

if($delete){
    header("Location: ./principal.php");
}
else{
    header("Location: ./principal.php");
}
?>
