<?php
@session_start();
include './models/conexion.php';
include './models/funciones.php';
include './controllers/funciones.php';

$user = buscavalor("usuarios", "usuario", "idusuario='" . $_SESSION['idusuario'] . "'");

include './views/navbar.php';
?>
<div class="container-fluid" style="margin-bottom: 10px;margin-top:10px;">
    <div class="card">
        <div class="card-header" style="background-color: #11145D;color:white">
            <b> Panel Principal</b>
            <b style="float:right">Bienvenido/a: <?php echo $user; ?></b>
        </div>
        <div class="card-body centrado">
            <h3><b>Sistema de Repositorio de Documentos (SRD)</b></h3>
            <hr>
            <?php if ($_POST['Pcategoria']) : ?>
                <?php include './views/categorias/principal.php';?>
            <?php elseif ($_POST['Pdocumentos']) : ?>
                <?php include './views/documentos/principal.php';?>
            <?php else : ?>
                <div class="row">
                    <div class="col-md-6">
                        <!--form action="./index.php" method="POST">
                            <input type="hidden" name="Pcategoria" value="1" -->
                            <a href="./views/categorias/principal.php" class="btn btn-success btn-sm">
                                <b>Categorías</b>
                            </a>
                        <!-- /form -->
                    </div>
                    <div class="col-md-6">
                         <!--form action="./index.php" method="POST">
                            <input type="hidden" name="Pcategoria" value="1" -->
                            <a href="./views/documentos/principal.php" class="btn btn-success btn-sm">
                                <b>Documentos</b>
                            </a>
                        <!-- /form -->
                    </div>
                </div>
            <?php endif ?>
        </div>
    </div>
</div>