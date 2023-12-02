<?php
@session_start();
include '../../models/conexion.php';
include '../../models/funciones.php';
include '../../controllers/funciones.php';

$categoria = $_POST['categoria'];

$insert = CRUD("INSERT INTO categorias(categoria,estado) VALUES('$categoria',1)", "i");

if($insert){
    header("Location: ./principal.php");
}
else{
    header("Location: ./principal.php");
}
?>
