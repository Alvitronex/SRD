<?php 
    if(isset($_POST['off'])){
        @session_start();
        $_SESSION = array();
        session_destroy();
        
    }else{
        @session_start();
    }
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <?php if(isset($_SESSION['LoginOK'])):?>
        <title>System</title>
    <?php else:?>
        <title>Login</title>
    <?php endif ?>
    <!-- CSS -->
    <link rel="stylesheet" href="./public/css/style.css">
    <link rel="stylesheet" href="./public/css/bootstrap.min.css">
    <!-- JS -->
    <script src="./public/js/jquery-3.6.3.slim.min.js"></script>
    <script src="./public/js/bootstrap.min.js"></script>
    <script src="./public/fontawesome/fontawesome.js"></script>
</head>
<body>
<?php if(isset($_SESSION['LoginOK'])):?>
        <?php include './views/principal.php';?>
    <?php else:?>
        <?php include './views/login.php';?>
    <?php endif ?>
</body>
</html>