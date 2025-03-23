<?php
class ProductSpecificatie extends BaseController {
    private $productSpecificatieModel;

    public function __construct() {
        $this->productSpecificatieModel = $this->model('ProductSpecificatieModel');
    }

    public function index($productId) {
        $startdatum = $_POST['startdatum'] ?? null;
        $einddatum = $_POST['einddatum'] ?? null;

        $data = [
            'specificaties' => $this->productSpecificatieModel->getProductSpecificaties($productId, $startdatum, $einddatum)
        ];

        $this->view('productspecificatie/index', $data);
    }
}