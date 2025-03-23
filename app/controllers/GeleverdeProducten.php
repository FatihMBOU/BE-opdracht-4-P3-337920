<?php
class GeleverdeProducten extends BaseController {
    private $geleverdeProductenModel;

    public function __construct() {
        $this->geleverdeProductenModel = $this->model('GeleverdeProductenModel');
    }

    public function index() {
        $startdatum = $_POST['startdatum'] ?? null;
        $einddatum = $_POST['einddatum'] ?? null;

        $data = [
            'producten' => $this->geleverdeProductenModel->getGeleverdeProducten($startdatum, $einddatum)
        ];

        $this->view('geleverdeproducten/index', $data);
    }
}