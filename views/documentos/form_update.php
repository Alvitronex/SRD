<?php
@session_start();
include '../../models/conexion.php';
include '../../models/funciones.php';
include '../../controllers/funciones.php';

$iddocumento = $_POST['iddocumento'];
$ruta = buscavalor("documentos", "ruta", "iddocumento='$iddocumento'");

$dataDocumento = CRUD("SELECT * FROM documentos WHERE iddocumento='$iddocumento' ", "s");

foreach($dataDocumento AS $result){
    $detalle = $result['detalle'];
    $idcategoria = $result['idcategoria'];
    $fecha_registro = $result['fecha_registro'];
}
$categoria = buscavalor("categorias", "categoria", "idcategoria='$idcategoria'");
$dataCategorias = CRUD("SELECT * FROM categorias WHERE idcategoria !='$idcategoria' ORDER BY categoria ASC", "s");

?>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <?php if (isset($_SESSION['LoginOK'])) : ?>
        <title>System</title>
    <?php else : ?>
        <title>Login</title>
    <?php endif ?>
    <!-- CSS -->
    <link rel="stylesheet" href="../../public/css/style.css">
    <link rel="stylesheet" href="../../public/css/bootstrap.min.css">
    <!-- JS -->
    <script src="../../public/js/jquery-3.6.3.slim.min.js"></script>
    <script src="../../public/js/bootstrap.min.js"></script>
    <script src="../../public/fontawesome/fontawesome.js"></script>
</head>

<body>
    <?php include '../navbarB.php'; ?>
    <div class="container" style="margin-top:10px">
        <div class="card">
            <div class="card-header">
                <b>Editar Información Documento</b>
            </div>
            <div class="card-body">
                <form action="./update.php" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="iddocumento" value="<?php echo $iddocumento;?>">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="input-group mb-3">
                                <span class="input-group-text"><b>Detalle:</b></span>
                                <textarea class="form-control" name="detalle" required><?php echo $detalle;?></textarea>
                            </div>
                            <div class="input-group mb-3">
                                <label class="input-group-text" for="inputGroupSelect01">
                                    <b>Categoría: </b>
                                </label>

                                <select class="form-select" name="idcategoria">
                                    <option value="<?php echo $idcategoria; ?>"selected><?php echo $categoria; ?></option>
                                    <?php foreach ($dataCategorias as $result) : ?>
                                        <option value="<?php echo $result['idcategoria']; ?>"> <?php echo $result['categoria']; ?></option>
                                    <?php endforeach ?>
                                </select>
                            </div>
                            <div class="input-group mb-3">
                                <label class="input-group-text" for="inputGroupFile01"><b>Documento</b></label>
                                <input type="file" class="form-control" name="documento">
                            </div>
                            <div class="input-group mb-3">
                                <span class="input-group-text" id="basic-addon1"><b>Fecha:</b></span>
                                <input type="date" class="form-control" name="fecha_registro" value="<?php echo $fecha_registro; ?>">
                            </div>
                            <button class="btn btn-primary" name="BtnSaveD">
                                <b>Actualizar</b>
                            </button>
                        </div>
                        <div class="col-md-6">
                            <p>Documento Actual</p>
                            <div style="margin: 0 auto;">
                                <embed src="../archivos/<?php echo $ruta; ?>" type="application/pdf" width="100%" height="350px" />
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>

    </div>
</body>

</html>