<?php
class Allergeen extends BaseController {
    private $allergeenModel;

    public function __construct() {
        $this->allergeenModel = $this->model('AllergeenModel');
    }

    public function index() {
        $data = [
            'title' => 'Overzicht Allergenen',
            'allergenen' => NULL,
            'producten' => [],
            'message' => NULL,
            'selectedAllergeen' => NULL
        ];

        try {
            $allergenen = $this->allergeenModel->getAllergenen();

            if (empty($allergenen)) {
                throw new Exception("Geen resultaten gevonden");
            }

            $data['allergenen'] = $allergenen;
        } catch (Exception $e) {
            error_log($e->getMessage());
            $data['message'] = "Er is een fout opgetreden in de database: " . $e->getMessage();
        }

        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            $allergeenId = trim($_POST['allergeen']);
            try {
                $producten = $this->allergeenModel->getProductenMetAllergeen($allergeenId);
                $data['producten'] = $producten;

                foreach ($data['allergenen'] as $allergeen) {
                    if ($allergeen->Id == $allergeenId) {
                        $data['selectedAllergeen'] = $allergeen->Naam;
                        break;
                    }
                }

            } catch (Exception $e) {
                error_log($e->getMessage());
                $data['message'] = "Er is een fout opgetreden bij het ophalen van de producten: " . $e->getMessage();
            }
        }

        $this->view('allergenen/index', $data);
    }
}