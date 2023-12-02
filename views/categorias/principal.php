<?php
@session_start();
include '../../models/conexion.php';
include '../../models/funciones.php';
include '../../controllers/funciones.php';

$dataCategorias = CRUD("SELECT * FROM categorias ORDER BY categoria ASC", "s");

$contC = 0;
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
    <div class="row container" style="margin-top:10px">
        <div class="col-md-4">
            <div class="card">
                <div class="card-header">
                    <b>Nueva Categoría</b>
                </div>
                <div class="card-body">
                    <form action="./insert.php" method="post">
                        <div class="input-group mb-3">
                            <span class="input-group-text"><b>Categoría:</b></span>
                            <textarea class="form-control" name="categoria" required></textarea>
                        </div>
                        <button class="btn btn-primary" name="BtnSaveC">
                            <b>Guardar</b>
                        </button>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">
                    <b>Lista Categorías</b>
                </div>
                <div class="card-body">
                    <table class="table table-bordeless">
                        <thead class="centrado">
                            <tr>
                                <th>N°</th>
                                <th>Código</th>
                                <th>Categoría</th>
                                <th>Estado</th>
                                <th colspan="2">Acciones</th>
                            </tr>
                        </thead>
                        <tbody class="centrado">
                            <?php foreach ($dataCategorias as $result) : ?>
                                <tr>
                                    <td><?php echo $contC += 1; ?></td>
                                    <td>
                                        <?php
                                        echo $result['idcategoria'];
                                        ?>
                                    </td>
                                    <td>
                                        <?php
                                        echo $result['categoria'];
                                        ?>
                                    </td>
                                    <td>
                                        <?php
                                        echo ($result['estado'] == 1) ? 'Disponible' : 'No disponible';
                                        ?>
                                    </td>
                                    <td>
                                        <form action="./form_update.php" method="POST">
                                            <input type="hidden" name="idcategoria" value="<?php echo $result['idcategoria']; ?>">
                                            <button class="btn btn-success btn-sm">
                                                <i class="fa-solid fa-pen-to-square"></i>
                                            </button>
                                        </form>
                                    </td>
                                    <td>
                                        <form action="./delete.php" method="POST">
                                            <input type="hidden" name="idcategoria" value="<?php echo $result['idcategoria']; ?>">
                                            <button class="btn btn-danger btn-sm">
                                                <i class="fa-solid fa-trash"></i>
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            <?php endforeach ?>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>
</body>

</html>