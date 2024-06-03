<?php
class Clientes extends Controller{
    public function __construct() {
        session_start();
        if (empty($_SESSION['activo'])) {
            header("location: ".base_url);
        }
        parent::__construct();
    }
    public function index()
    {
        $this->views->getView($this, "index");
    }
    public function listar()
    {
        $data = $this->model->getClientes(1);
        for ($i=0; $i < count($data); $i++) { 
            $data[$i]['estado'] = '<span class="badge bg-success">Activo</span>';
            $data[$i]['editar'] = '<button class="btn btn-outline-primary" type="button" onclick="btnEditarCli(' . $data[$i]['id'] . ');"><i class="fas fa-edit"></i></button>';
            $data[$i]['eliminar'] = '<button class="btn btn-outline-danger" type="button" onclick="btnEliminarCli(' . $data[$i]['id'] . ');"><i class="fas fa-trash-alt"></i></button>';
        }
        echo json_encode($data, JSON_UNESCAPED_UNICODE);
        die();
    }
    public function registrar()
{
    $dni = strClean($_POST['dni']);
    $nombre = strClean($_POST['nombre']);
    $telefono = strClean($_POST['telefono']);
    $direccion = strClean($_POST['direccion']);
    $id = strClean($_POST['id']);

    if (empty($dni) || empty($nombre) || empty($telefono) || empty($direccion)) {
        $msg = array('msg' => 'Todo los campos son obligatorios', 'icono' => 'warning');
    } else {
        $data = $id == "" ? $this->model->registrarCliente($dni, $nombre, $telefono, $direccion) : $this->model->modificarCliente($dni, $nombre, $telefono, $direccion, $id);
        $msg = $this->handleResponse($data);
    }

    echo json_encode($msg, JSON_UNESCAPED_UNICODE);
    die();
}

private function handleResponse($data)
{
    switch ($data) {
        case "ok":
            return array('msg' => 'Cliente registrado con éxito', 'icono' => 'success');
        case "existe":
            return array('msg' => 'El cliente ya existe', 'icono' => 'warning');
        case "modificado":
            return array('msg' => 'Cliente modificado', 'icono' => 'success');
        default:
            return array('msg' => 'Error al registrar/modificar el cliente', 'icono' => 'error');
    }
}
    public function editar(int $id)
    {
        $data = $this->model->editarCli($id);
        echo json_encode($data, JSON_UNESCAPED_UNICODE);
        die();
    }
    public function eliminar(int $id)
{
    $data = $this->model->accionCli(0, $id);
    $msg = $this->handleActionResponse($data, 'Cliente dado de baja', 'Error al eliminar el cliente');
    $this->sendResponse($msg);
}

public function reingresar(int $id)
{
    $data = $this->model->accionCli(1, $id);
    $msg = $this->handleActionResponse($data, 'Cliente reingresado', 'Error al reingresar el cliente');
    $this->sendResponse($msg);
}

private function handleActionResponse($data, $successMsg, $errorMsg)
{
    if ($data == 1) {
        return array('msg' => $successMsg, 'icono' => 'success');
    } else {
        return array('msg' => $errorMsg, 'icono' => 'error');
    }
}

private function sendResponse($msg)
{
    echo json_encode($msg, JSON_UNESCAPED_UNICODE);
    die();
}
    public function buscarCliente()
    {
        if (isset($_GET['cli'])) {
            $data = $this->model->buscarCliente($_GET['cli']);
            $datos = array();
            foreach ($data as $row) {
                $data['id'] = $row['id'];
                $data['label'] = $row['nombre'] . ' - ' . $row['direccion'];
                $data['value'] = $row['nombre'];
                array_push($datos, $data);
            }
            echo json_encode($datos, JSON_UNESCAPED_UNICODE);
            die();
        }
    }
    public function inactivos()
    {
        $data['clientes'] = $this->model->getClientes(0);
        $this->views->getView($this, "inactivos", $data);
    }
}
