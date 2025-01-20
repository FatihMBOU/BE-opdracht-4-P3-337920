<?php
class LeveringController extends Controller {
    public function __construct() {
        $this->leveringModel = $this->model('LeveringModel');
    }

    public function nieuweLevering($id) {
        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            // Sanitize POST data
            $_POST = filter_input_array(INPUT_POST, FILTER_SANITIZE_STRING);

            $data = [
                'id' => $id,
                'aantal' => trim($_POST['aantal']),
                'datum' => trim($_POST['datum']),
                'aantal_err' => '',
                'datum_err' => ''
            ];

            // Validate data
            if (empty($data['aantal'])) {
                $data['aantal_err'] = 'Vul het aantal in';
            }

            if (empty($data['datum'])) {
                $data['datum_err'] = 'Vul de datum in';
            }

            if (empty($data['aantal_err']) && empty($data['datum_err'])) {
                // Validated
                try {
                    if ($this->leveringModel->updateProduct($data['id'], $data['aantal'], $data['datum'])) {
                        flash('levering_message', 'Product levering bijgewerkt');
                        redirect('leverancier/geleverdeProducten');
                    } else {
                        throw new Exception('Er is iets misgegaan bij het bijwerken van de productlevering.');
                    }
                } catch (Exception $e) {
                    die($e->getMessage());
                }
            } else {
                // Load view with errors
                $this->view('leverancier/nieuweLevering', $data);
            }
        } else {
            try {
                $product = $this->leveringModel->getProductById($id);

                $data = [
                    'id' => $id,
                    'aantal' => '',
                    'datum' => '',
                    'aantal_err' => '',
                    'datum_err' => ''
                ];

                $this->view('leverancier/nieuweLevering', $data);
            } catch (Exception $e) {
                die($e->getMessage());
            }
        }
    }
}