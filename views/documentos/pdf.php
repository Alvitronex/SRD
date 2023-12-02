<?php
@session_start();
include '../../models/conexion.php';
include '../../models/funciones.php';
include '../../controllers/funciones.php';

$iddocumento = $_POST['iddocumento'];
$ruta = buscavalor("documentos", "ruta", "iddocumento='$iddocumento'");
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
                <b>Vista Documento</b>
            </div>
            <div class="card-body">
                <div style="margin: 0 auto;">
                    <embed src="../archivos/<?php echo $ruta; ?>" type="application/pdf" width="100%" height="500px" />
                </div>
            </div>
        </div>

    </div>
</body>

</html>