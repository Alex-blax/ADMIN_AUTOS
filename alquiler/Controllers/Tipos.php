<?php
class Tipos extends Controller{
    public function __construct() {
        session_start();
        if (empty($_SESSION['activo'])) {
            header("location: ".base_url);
        }
        parent::__construct();
        if ($_SESSION['id_usuario'] != 1) {
            header("location: " . base_url);
        }
    }
    public function index()
    {
        $this->views->getView($this, "index");
    }
    public function listar()
    {
        $id_user = $_SESSION['id_usuario'];
        $data = $this->model->getTipos(1);
        for ($i=0; $i < count($data); $i++) {
            $data[$i]['estado'] = '<span class="badge bg-success">Activo</span>';
            $data[$i]['editar'] = '<button class="btn btn-outline-primary" type="button" onclick="btnEditarTipo(' . $data[$i]['id'] . ');"><i class="fas fa-edit"></i></button>';
            $data[$i]['eliminar'] = '<button class="btn btn-outline-danger" type="button" onclick="btnEliminarTipo(' . $data[$i]['id'] . ');"><i class="fas fa-trash-alt"></i></button>';
        }
        echo json_encode($data, JSON_UNESCAPED_UNICODE);
        die();
    }
    private function handleTipoResponse($data, $successMsg, $existMsg, $errorMsg)
    {
        if ($data == "ok" || $data == "modificado") {
            $msg = array('msg' => $successMsg, 'icono' => 'success');
        } else if($data == "existe"){
            $msg = array('msg' => $existMsg, 'icono' => 'warning');
        } else {
            $msg = array('msg' => $errorMsg, 'icono' => 'error');
        }
        echo json_encode($msg, JSON_UNESCAPED_UNICODE);
        die();
    }

    public function registrar()
    {
        $nombre = strClean($_POST['nombre']);
        $id = strClean($_POST['id']);
        if (empty($nombre)) {
            $msg = array('msg' => 'El nombre es requerido', 'icono' => 'warning');
            echo json_encode($msg, JSON_UNESCAPED_UNICODE);
            die();
        } else {
            if ($id == "") {
                $data = $this->model->registrarTipo($nombre);
                $this->handleTipoResponse($data, 'Tipo registrado con éxito', 'El tipo ya existe', 'Error al registrar');
            } else {
                $data = $this->model->modificarTipo($nombre, $id);
                $this->handleTipoResponse($data, 'Tipo modificado', '', 'Error al modificar');
            }
        }
    }

    public function editar(int $id)
    {
        $data = $this->model->editarTipo($id);
        echo json_encode($data, JSON_UNESCAPED_UNICODE);
        die();
    }
    public function eliminar(int $id)
    {
        $data = $this->model->accionTipo(0, $id);
        if ($data == 1) {
            $msg = array('msg' => 'Tipo dado de baja', 'icono' => 'success');
        }else{
            $msg = array('msg' => 'Error al eliminar', 'icono' => 'error');
        }
        echo json_encode($msg, JSON_UNESCAPED_UNICODE);
        die();
    }
    public function reingresar(int $id)
    {
        $data = $this->model->accionTipo(1, $id);
        if ($data == 1) {
            $msg = array('msg' => 'Tipo reingresado', 'icono' => 'success');
        } else {
            $msg = array('msg' => 'Error la reingresar', 'icono' => 'error');
        }
        echo json_encode($msg, JSON_UNESCAPED_UNICODE);
        die();
    }
    public function inactivos()
    {
        $data['tipos'] = $this->model->getTipos(0);
        $this->views->getView($this, "inactivos", $data);
    }
}
