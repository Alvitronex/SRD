<?php
function AccessLogin($user, $passw)
{
    $consultas = new Procesos();
    $data = $consultas->DataUser($user);

    if ($data) {
        foreach ($data as $result) {
            $idusuario = $result['idusuario'];
            $hash = $result['passw'];
            $estado = $result['estado'];
        }
        if ($estado == 1) {
            if (password_verify($passw,$hash)) {
                $_SESSION['LoginOK'] = 1;
                $_SESSION['idusuario'] = $idusuario;
                header("Location: ../index.php");
            } else {
                header("Location: ../index.php?msj=" . urlencode("Contraseña incorrecta"));
            }
        } else {
            header("Location: ../index.php?msj=" . urlencode("Usuario sin acceso"));
        }
    } else {
        header("Location: ../index.php?msj=" . urlencode("Usuario no existe"));
    }
}

function buscavalor($tabla,$campo,$condicion){
    $valor = NULL;
    $consultas = new Procesos();
    $data = $consultas->BuscaValor($tabla,$campo,$condicion);

    foreach($data AS $result){
        $valor = $result[0];
    }
    return $valor;
}

function CRUD($query,$tipo){
    $consultas = new Procesos();
    $data = $consultas->isdu($query,$tipo);
    return $data;
}

function CargaDocumento($tmp_dir,$newName,$path){
    if(!is_dir($path)){
        mkdir($path,0777, true);
        chmod($path,0777);
    }else{
        chmod($path,0777);
    }

    if(is_uploaded_file($tmp_dir)){
        copy($tmp_dir,$path.$newName);
        chmod($path.$newName,0777);
        return true;
    }else{
        return false;
    }
}
