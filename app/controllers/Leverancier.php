<?php

class Leverancier extends BaseController
{
    private $leverancierModel;

    public function __construct()
    {
        // Laad het model voor leverancier
        $this->leverancierModel = $this->model('LeverancierModel');
    }

    public function index()
    {
        // Initialiseer data array voor de view
        $data = [
            'title' => 'Overzicht Leveranciers',
            'leveranciers' => NULL,
            'message' => NULL
        ];

        try {
            // Haal alle leveranciers en het aantal verschillende producten dat zij leveren op
            $result = $this->leverancierModel->getAllLeveranciers();

            if (empty($result)) {
                throw new Exception("Geen resultaten gevonden");
            }

            // Zet de opgehaalde data in de data array
            $data['leveranciers'] = $result;
        } catch (Exception $e) {
            // Log de fout en zet de foutmelding in de data array
            error_log($e->getMessage());
            $data['message'] = "Er is een fout opgetreden in de database: " . $e->getMessage();
        }

        // Laad de view met de data
        $this->view('leverancier/index', $data);
    }

    public function geleverdeProducten($leverancierId)
    {
        // Initialiseer data array voor de view
        $data = [
            'title' => 'Geleverde Producten',
            'producten' => NULL,
            'leverancier' => NULL,
            'message' => NULL
        ];

        try {
            // Haal de geleverde producten van de specifieke leverancier op
            $result = $this->leverancierModel->getGeleverdeProducten($leverancierId);

            // Haal de gegevens van de leverancier op
            $leverancier = $this->leverancierModel->getLeverancierById($leverancierId);

            if (empty($result)) {
                // Zet de foutmelding
                $data['message'] = "Dit bedrijf heeft tot nu toe geen producten geleverd aan Jamin";
            } else {
                // Zet de opgehaalde data in de data array
                $data['producten'] = $result;
            }
            $data['leverancier'] = $leverancier;
        } catch (Exception $e) {
            // Log de fout en zet de foutmelding in de data array
            error_log($e->getMessage());
            $data['message'] = "Er is een fout opgetreden in de database: " . $e->getMessage();
            $data['leverancier'] = $this->leverancierModel->getLeverancierById($leverancierId);
        }

        // Laad de view met de data
        $this->view('leverancier/geleverdeProducten', $data);
    }

    public function nieuweLevering($id)
    {
        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            // Sanitize POST data
            $_POST = filter_input_array(INPUT_POST, FILTER_SANITIZE_FULL_SPECIAL_CHARS);

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
            } elseif (strtotime($data['datum']) < strtotime(date('Y-m-d'))) {
                $data['datum_err'] = 'Deze datum ligt in het verleden, graag een nieuwe datum invoeren';
            }

            if (empty($data['aantal_err']) && empty($data['datum_err'])) {
                // Validated
                if ($this->leverancierModel->updateProduct($data['id'], $data['aantal'], $data['datum'])) {
                    $this->setFlash('levering_message', 'Product levering bijgewerkt');
                    $this->redirect('leverancier/geleverdeProducten/' . $id);
                } else {
                    die('Er is iets misgegaan');
                }
            } else {
                // Haal de gegevens van de leverancier op
                $leverancier = $this->leverancierModel->getLeverancierByProductId($id);
                $data['leverancier'] = $leverancier;

                // Load view with errors
                $this->view('leverancier/nieuweLevering', $data);
            }
        } else {
            $product = $this->leverancierModel->getProductById($id);
            $leverancier = $this->leverancierModel->getLeverancierByProductId($id);

            $data = [
                'id' => $id,
                'aantal' => '',
                'datum' => '',
                'aantal_err' => '',
                'datum_err' => '',
                'leverancier' => $leverancier
            ];

            $this->view('leverancier/nieuweLevering', $data);
        }
    }

    private function setFlash($name, $message)
    {
        if (!isset($_SESSION)) {
            session_start();
        }
        $_SESSION[$name] = $message;
    }

    private function redirect($url)
    {
        header('Location: ' . URLROOT . '/' . $url);
        exit();
    }
}