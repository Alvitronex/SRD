<?php 
    require './controllers/C_index.php';
    $mvc = new Index();
    $mvc->base();
    echo "<br>";
    //echo password_hash('1234',PASSWORD_DEFAULT);
?>