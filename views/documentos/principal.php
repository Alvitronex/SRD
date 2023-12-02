<?php
@session_start();
include '../../models/conexion.php';
include '../../models/funciones.php';
include '../../controllers/funciones.php';

$dataDocumentos = CRUD("SELECT * FROM documentos ORDER BY detalle ASC", "s");

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
    <div class="row container centrado" style="margin-top:10px">
        <div class="col-md-5">
            <div class="card">
                <div class="card-header">
                    <b>Nuevo Documento</b>
                </div>
                <div class="card-body">
                    <form action="./insert.php" method="post" enctype="multipart/form-data">
                        <div class="input-group mb-3">
                            <span class="input-group-text"><b>Detalle:</b></span>
                            <textarea class="form-control" name="detalle" required></textarea>
                        </div>
                        <div class="input-group mb-3">
                            <label class="input-group-text" for="inputGroupSelect01">
                                <b>Categoría: </b>
                            </label>

                            <select class="form-select" name="idcategoria">
                                <option disabled selected>Seleccione categoría</option>
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
                            <input type="date" class="form-control" name="fecha_registro">
                        </div>
                        <button class="centrado btn btn-primary" name="BtnSaveD">
                            <b>Guardar</b>
                        </button>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-md-7">
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
                                <th>Sexo oral</th>
                                <th>Categoría de los distintos sexos xd jajaj</th>
                                <th>maduras xvideos</th>
                                <th colspan="3">Acciones</th>
                            </tr>
                        </thead>
                        <tbody class="centrado">
                            <?php foreach ($dataDocumentos as $result) : ?>
                                <tr>
                                    <td><?php echo $contC += 1; ?></td>
                                    <td><?php echo $result['iddocumento']; ?></td>
                                    <td><?php echo $result['detalle']; ?></td>
                                    <td><?php echo buscavalor("categorias", "categoria", "idcategoria='" . $result['idcategoria'] . "'"); ?></td>
                                    <td><?php echo $result['fecha_regitro']; ?></td>
                                    <td>
                                        <form action="./pdf.php" method="POST">
                                            <input type="hidden" name="iddocumento" value="<?php echo $result['iddocumento']; ?>">
                                            <button class="btn btn-info btn-sm">
                                            <i class="fa-regular fa-file-pdf"></i>
                                            </button>
                                        </form>
                                    </td>
                                    <td>
                                        <form action="./form_update.php" method="POST">
                                            <input type="hidden" name="iddocumento" value="<?php echo $result['iddocumento']; ?>">
                                            <button class="btn btn-success btn-sm">
                                                <i class="fa-solid fa-pen-to-square"></i>
                                            </button>
                                        </form>
                                    </td>
                                    <td>
                                        <form action="./delete.php" method="POST" onsubmit="return confirmarBorrado()">
                                            <input type="hidden" name="iddocumento" value="<?php echo $result['iddocumento']; ?>">
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
    <script>
        function confirmarBorrado() {
            return confirm("¿Estás seguro de que deseas borrar?");
        }
    </script>
</body>

</html>