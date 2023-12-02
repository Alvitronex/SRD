<?php
@session_start();
include '../../models/conexion.php';
include '../../models/funciones.php';
include '../../controllers/funciones.php';

$idcategoria = $_POST['idcategoria'];
$categoria = $_POST['categoria'];
$estado = $_POST['estado'];

$update = CRUD("UPDATE categorias SET categoria='$categoria',estado='$estado' WHERE idcategoria='$idcategoria'", "u");

if($update){
    header("Location: ./principal.php");
}
else{
    header("Location: ./principal.php");
}
?>
