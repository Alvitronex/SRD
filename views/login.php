<div class="contenedor_padre">
    <div class="contenedor_hijo">
        <?php if(isset($_GET['msj'])):?>
            <div class="alert alert-danger centrado">
                <b>
                    <?php 
                    echo  urldecode($_GET['msj']);
                    ?>
                </b>
            </div>
        <?php endif ?>
        <div class="centrado">
            <img src="./public/img/login/user.png" width="150px" alt="">
            <h4 ><b >Iniciar Sesión</b></h4>
        </div>
        <form action="./controllers/C_login.php" method="POST">
            <div class="input-group mb-3">
                <span class="input-group-text"><b>Usuario:</b></span>
                <input type="text" class="form-control" placeholder="Ingrese Usuario" name="user" required autocomplete="OFF">
            </div>
            <div class="input-group mb-3">
                <span class="input-group-text"><b>Clave:</b></span>
                <input type="password" class="form-control" placeholder="Ingrese Clave" name="clave" required autocomplete="OFF">
            </div>
            <button class="btn btn-primary" name="BtnLogin"><b>Acceder</b></button>
        </form>
    </div>
</div>