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

            // Validatie van de data
            if (empty($data['aantal'])) {
                $data['aantal_err'] = 'Vul het aantal in';
            }

            if (empty($data['datum'])) {
                $data['datum_err'] = 'Vul de datum in';
            } elseif (strtotime($data['datum']) < strtotime(date('Y-m-d'))) {
                $data['datum_err'] = 'Deze datum ligt in het verleden, graag een nieuwe datum invoeren';
            }

            if (empty($data['aantal_err']) && empty($data['datum_err'])) {
                //  Validated
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

                //  Laden van view met errors
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

    public function wijzigLeverancier($id)
{
    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        // Sanitize POST data
        $_POST = filter_input_array(INPUT_POST, FILTER_SANITIZE_FULL_SPECIAL_CHARS);
        $data = [
            'id' => $id,
            'naam' => trim($_POST['naam']),
            'contactpersoon' => trim($_POST['contactpersoon']),
            'leveranciernummer' => trim($_POST['leveranciernummer']),
            'mobiel' => trim($_POST['mobiel']),
            'straatnaam' => trim($_POST['straatnaam']),
            'huisnummer' => trim($_POST['huisnummer']),
            'postcode' => trim($_POST['postcode']),
            'stad' => trim($_POST['stad']),
            'naam_err' => '',
            'contactpersoon_err' => '',
            'leveranciernummer_err' => '',
            'mobiel_err' => '',
            'straatnaam_err' => '',
            'huisnummer_err' => '',
            'postcode_err' => '',
            'stad_err' => ''
        ];

        // Validatie van de data
        if (empty($data['naam'])) {
            $data['naam_err'] = 'Vul de naam in';
        }
        if (empty($data['contactpersoon'])) {
            $data['contactpersoon_err'] = 'Vul de contactpersoon in';
        }
        if (empty($data['leveranciernummer'])) {
            $data['leveranciernummer_err'] = 'Vul het leveranciernummer in';
        }
        if (empty($data['mobiel'])) {
            $data['mobiel_err'] = 'Vul het mobiele nummer in';
        }
        if (empty($data['straatnaam'])) {
            $data['straatnaam_err'] = 'Vul de straatnaam in';
        }
        if (empty($data['huisnummer'])) {
            $data['huisnummer_err'] = 'Vul het huisnummer in';
        }
        if (empty($data['postcode'])) {
            $data['postcode_err'] = 'Vul de postcode in';
        }
        if (empty($data['stad'])) {
            $data['stad_err'] = 'Vul de stad in';
        }
        

        if (empty($data['naam_err']) && empty($data['contactpersoon_err']) && empty($data['leveranciernummer_err']) && empty($data['mobiel_err']) && empty($data['straatnaam_err']) && empty($data['huisnummer_err']) && empty($data['postcode_err']) && empty($data['stad_err'])) {
            // gevalideerd
            if ($this->leverancierModel->updateLeverancier($data)) {
                $this->setFlash('leverancier_message', 'Leverancier bijgewerkt');
                $this->redirect('leverancier/wijzigenLeverancier');
            } else {
                die('Er is iets misgegaan');
            }
        } else {
            // Laden van view met errors
            $this->view('leverancier/wijzigLeverancier', $data);
        }
    } else {
        // Haal de gegevens van de leverancier op
        $leverancier = $this->leverancierModel->getLeverancierById($id);
        $data = [
            'id' => $id,
            'naam' => $leverancier->Naam,
            'contactpersoon' => $leverancier->Contactpersoon,
            'leveranciernummer' => $leverancier->Leveranciernummer,
            'mobiel' => $leverancier->Mobiel,
            'straatnaam' => $leverancier->Straatnaam,
            'huisnummer' => $leverancier->Huisnummer,
            'postcode' => $leverancier->Postcode,
            'stad' => $leverancier->Stad,
            'naam_err' => '',
            'contactpersoon_err' => '',
            'leveranciernummer_err' => '',
            'mobiel_err' => '',
            'straatnaam_err' => '',
            'huisnummer_err' => '',
            'postcode_err' => '',
            'stad_err' => ''
        ];
        $this->view('leverancier/wijzigLeverancier', $data);
    }
    }
}