<?php 
    class ConexionBD{
        public function get_conexion(){
            $user = "root";
            $pass = "";
            $host = "localhost";
            $db = "bd_poo";

            $conexion = new PDO("mysql:host=$host;dbname=$db;",$user, $pass, array(PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8"));
            return $conexion;
        }
    }
?>