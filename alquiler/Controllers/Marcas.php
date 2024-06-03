<?php
class Marcas extends Controller
{
    public function __construct()
    {
        session_start();
        $this->redirectIfNotLoggedIn();
        parent::__construct();
        $this->redirectIfNotAdmin();
    }

    private function redirectIfNotLoggedIn()
    {
        if (empty($_SESSION['activo'])) {
            header("location: " . base_url);
        }
    }

    private function redirectIfNotAdmin()
    {
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
        $data = $this->model->getMarcas(1);
        $data = $this->formatMarcasData($data);
        echo json_encode($data, JSON_UNESCAPED_UNICODE);
        die();
    }

    private function formatMarcasData($data)
    {
        for ($i = 0; $i < count($data); $i++) {
            $data[$i]['estado'] = '<span class="badge bg-success">Activo</span>';
            $data[$i]['editar'] = $this->createButton('primary', 'edit', 'btnEditarMarca', $data[$i]['id']);
            $data[$i]['eliminar'] = $this->createButton('danger', 'trash-alt', 'btnEliminarMarca', $data[$i]['id']);
        }
        return $data;
    }

    private function createButton($color, $icon, $onclickFunction, $id)
    {
        return '<button class="btn btn-outline-' . $color . '" type="button" onclick="' . $onclickFunction . '(' . $id . ');"><i class="fas fa-' . $icon . '"></i></button>';
    }

    public function registrar()
    {
        $marca = strClean($_POST['nombre']);
        $id = strClean($_POST['id']);

        if (empty($marca)) {
            $this->sendJsonMessage('El nombre es requerido', 'warning');
        } else {
            $data = $id == "" ? $this->model->registrarMarca($marca) : $this->model->modificarMarca($marca, $id);
            $this->handleMarcaResponse($data, 'Marca registrado con éxito', 'La marca ya existe', 'Error al registrar', 'Marca modificado', 'Error al modificar');
        }
    }

    private function sendJsonMessage($msg, $icono)
    {
        echo json_encode(array('msg' => $msg, 'icono' => $icono), JSON_UNESCAPED_UNICODE);
        die();
    }

    private function handleMarcaResponse($data, $successMsg, $existMsg, $errorMsg, $modifiedMsg = '', $modifiedErrorMsg = '')
    {
        if ($data == "ok") {
            $this->sendJsonMessage($successMsg, 'success');
        } else if ($data == "modificado") {
            $this->sendJsonMessage($modifiedMsg, 'success');
        } else if ($data == "existe") {
            $this->sendJsonMessage($existMsg, 'warning');
        } else {
            $this->sendJsonMessage($data == "modificado" ? $modifiedErrorMsg : $errorMsg, 'error');
        }
    }

    public function editar(int $id)
    {
        $data = $this->model->editarMarca($id);
        echo json_encode($data, JSON_UNESCAPED_UNICODE);
        die();
    }

    public function eliminar(int $id)
    {
        $this->accionMarca($id, 0, 'Marca dado de baja', 'Error al eliminar');
    }

    public function reingresar(int $id)
    {
        $this->accionMarca($id, 1, 'Marca reingresado', 'Error la reingresar');
    }

    private function accionMarca($id, $estado, $successMsg, $errorMsg)
    {
        $data = $this->model->accionMarca($estado, $id);
        $this->sendJsonMessage($data == 1 ? $successMsg : $errorMsg, $data == 1 ? 'success' : 'error');
    }

    public function inactivos()
    {
        $data['marcas'] = $this->model->getMarcas(0);
        $this->views->getView($this, "inactivos", $data);
    }
}
