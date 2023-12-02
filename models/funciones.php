<?php
    class Procesos{
        public function DataUser($user){
            $row = NULL;
            $modelo = new ConexionBD();
            $conexion = $modelo->get_conexion();

            $sql = "SELECT * FROM usuarios WHERE usuario=:usuario";

            $stm = $conexion->prepare($sql);
            $stm->bindParam(':usuario',$user);
            $stm->execute();

            while($result = $stm->fetch()){
                $row[] = $result;
            }
            return $row;
        }

        /* Busca un valor de X tabla */
        public function BuscaValor($tabla,$campo,$condicion){
            $row = NULL;
            $modelo = new ConexionBD();
            $conexion = $modelo->get_conexion();

            $sql = "SELECT $campo FROM $tabla WHERE $condicion";

            $stm = $conexion->query($sql);

            while($result = $stm->fetch()){
                $row[] = $result;
            }
            return $row;
        }

         /* CRUD */
        public function isdu($query,$tipo){
            $row = NULL;
            $modelo = new ConexionBD();
            $conexion = $modelo->get_conexion();
            $stm = $conexion->prepare($query);

            if($tipo == "s"){
                $stm->execute();
                while($result = $stm->fetch()){
                    $row[] = $result;
                }
                return $row;
            }else{
                if(!$stm){
                    return 0;
                }else{
                    $stm->execute();
                    return 1;
                }
            }
        }
    }
