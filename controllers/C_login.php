<?php 
    @session_start();
    include "../models/conexion.php"; 
    include "../models/funciones.php";
    include "../controllers/funciones.php";

    if(isset($_POST['BtnLogin']))
    {
        $user = $_POST['user'];
        $passw = $_POST['clave'];
        AccessLogin($user,$passw);
    }else{
        header("Location: ../index.php");
    }
?>
