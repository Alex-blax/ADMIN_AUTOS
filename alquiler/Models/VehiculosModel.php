<?php
class VehiculosModel extends Query
{
    public function __construct()
    {
        parent::__construct();
    }

    // Método reutilizable para obtener datos basados en una consulta SQL
    private function getData($sql, $params = [])
    {
        return empty($params) ? $this->selectAll($sql) : $this->select($sql, $params);
    }

    // Método reutilizable para ejecutar consultas de modificación
    private function modifyData($sql, $params = [])
    {
        return $this->save($sql, $params);
    }

    public function getDatos(string $table)
    {
        $sql = "SELECT * FROM $table WHERE estado = 1";
        return $this->getData($sql);
    }

    private function getVehiculosQuery($estadoCondition)
    {
        return "SELECT v.*, m.id AS id_marca, m.marca, t.id AS id_tipo, t.tipo 
                FROM vehiculos v 
                INNER JOIN marcas m ON v.id_marca = m.id 
                INNER JOIN tipos t ON v.id_tipo = t.id 
                WHERE $estadoCondition";
    }

    public function getVehiculos(int $estado)
    {
        $sql = $this->getVehiculosQuery("v.estado = ?");
        return $this->getData($sql, [$estado]);
    }

    public function vehiculos()
    {
        $sql = $this->getVehiculosQuery("v.estado = 1 OR v.estado = 2");
        return $this->getData($sql);
    }

    public function registrarVehiculo(string $placa, int $marca, int $tipo, string $modelo, string $img)
    {
        $vericar = "SELECT * FROM vehiculos WHERE placa = ?";
        $existe = $this->getData($vericar, [$placa]);

        if (empty($existe)) {
            $sql = "INSERT INTO vehiculos(placa, id_marca, id_tipo, modelo, foto) VALUES (?,?,?,?,?)";
            $data = $this->modifyData($sql, [$placa, $marca, $tipo, $modelo, $img]);
            return $data == 1 ? "ok" : "error";
        } else {
            return "existe";
        }
    }

    public function modificarVehiculo(string $placa, int $marca, int $tipo, string $modelo, string $img, int $id)
    {
        $sql = "UPDATE vehiculos SET placa=?, id_marca=?, id_tipo=?, modelo=?, foto=? WHERE id=?";
        $data = $this->modifyData($sql, [$placa, $marca, $tipo, $modelo, $img, $id]);
        return $data == 1 ? "modificado" : "error";
    }

    public function editarVeh(int $id)
    {
        $sql = "SELECT * FROM vehiculos WHERE id = ?";
        return $this->getData($sql, [$id]);
    }

    public function accionVeh(int $estado, int $id)
    {
        $sql = "UPDATE vehiculos SET estado = ? WHERE id = ?";
        return $this->modifyData($sql, [$estado, $id]);
    }

    public function buscarVehiculo(string $valor)
    {
        $sql = "SELECT v.*, t.id AS id_tipo, t.tipo, m.id AS id_marca, m.marca 
                FROM vehiculos v 
                INNER JOIN tipos t ON t.id = v.id_tipo 
                INNER JOIN marcas m ON m.id = v.id_marca 
                WHERE (v.placa LIKE ? OR t.tipo LIKE ? OR m.marca LIKE ?) 
                AND v.estado = 1";
        $likeValor = "%$valor%";
        return $this->getData($sql, [$likeValor, $likeValor, $likeValor]);
    }
}
