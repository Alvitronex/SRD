<?php
@session_start();
include '../../models/conexion.php';
include '../../models/funciones.php';
include '../../controllers/funciones.php';

$idcategoria = $_POST['idcategoria'];
$dataCategoria = CRUD("SELECT * FROM categorias WHERE idcategoria='$idcategoria'", "s");

foreach ($dataCategoria as $result) {
    $categoria = $result['categoria'];
    $estado = $result['estado'];
}
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
    <div class="container">
        <div class="row">
            <div class="col-md-4"></div>
            <div class="col-md-4">
                <form action="./update.php" method="post">
                    <input type="hidden" name="idcategoria" value="<?php echo $idcategoria; ?>">
                    <div class="input-group mb-3">
                        <span class="input-group-text"><b>Categoría:</b></span>
                        <textarea class="form-control" name="categoria" required><?php echo $categoria; ?></textarea>
                    </div>
                    <div class="input-group mb-3">
                        <label class="input-group-text" for="inputGroupSelect01"><b>Estado:</b></label>
                        <select class="form-select" name="estado">
                            <option value="<?php echo $estado; ?>" selected>
                                <?php
                                echo ($estado == NULL || $estado == 0) ? 'No disponible' : 'Disponible';
                                ?>
                            </option>
                            <?php if ($estado == NULL || $estado == 0) : ?>
                                <option value="1">Disponible</option>
                            <?php else : ?>
                                <option value="0">No disponible</option>
                            <?php endif ?>
                        </select>
                    </div>
                    <button class="btn btn-primary" name="BtnUpdateC">
                        <b>Actualizar</b>
                    </button>
                </form>
            </div>
            <div class="col-md-4"></div>
        </div>
    </div>
</body>

</html>