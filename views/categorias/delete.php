<?php
@session_start();
include '../../models/conexion.php';
include '../../models/funciones.php';
include '../../controllers/funciones.php';

$idcategoria = $_POST['idcategoria'];

$delete = CRUD("DELETE FROM categorias WHERE idcategoria='$idcategoria'", "d");

if($delete){
    header("Location: ./principal.php");
}
else{
    header("Location: ./principal.php");
}
?>
