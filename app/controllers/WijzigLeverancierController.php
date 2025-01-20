<?php

class WijzigLeverancierController extends BaseController
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
            'title' => 'Wijzig Leverancier',
            'leveranciers' => NULL,
            'message' => NULL
        ];

        try {
            // Haal alle leveranciers op
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
        $this->view('wijzigLeverancier/index', $data);
    }

    public function wijzig($id)
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

            // Validate inputs
            if (empty($data['naam'])) {
                $data['naam_err'] = 'Vul een naam in';
            }
            if (empty($data['contactpersoon'])) {
                $data['contactpersoon_err'] = 'Vul een contactpersoon in';
            }
            if (empty($data['leveranciernummer'])) {
                $data['leveranciernummer_err'] = 'Vul een leveranciernummer in';
            }
            if (empty($data['mobiel'])) {
                $data['mobiel_err'] = 'Vul een mobiel nummer in';
            }
            if (empty($data['straatnaam'])) {
                $data['straatnaam_err'] = 'Vul een straatnaam in';
            }
            if (empty($data['huisnummer'])) {
                $data['huisnummer_err'] = 'Vul een huisnummer in';
            }
            if (empty($data['postcode'])) {
                $data['postcode_err'] = 'Vul een postcode in';
            }
            if (empty($data['stad'])) {
                $data['stad_err'] = 'Vul een stad in';
            }

            // Check if all errors are empty
            if (empty($data['naam_err']) && empty($data['contactpersoon_err']) && empty($data['leveranciernummer_err']) && empty($data['mobiel_err']) && empty($data['straatnaam_err']) && empty($data['huisnummer_err']) && empty($data['postcode_err']) && empty($data['stad_err'])) {
                // Update leverancier
                if ($this->leverancierModel->updateLeverancier($data)) {
                    // Redirect to leverancier details page
                    flash('leverancier_message', 'De wijzigingen zijn doorgevoerd');
                    redirect('leverancier/details/' . $id);
                } else {
                    die('Er is iets misgegaan');
                }
            } else {
                // Load view with errors
                $this->view('wijzigLeverancier/wijzig', $data);
            }
        } else {
            // Get existing leverancier from model
            $leverancier = $this->leverancierModel->getLeverancierById($id);

            $data = [
                'id' => $id,
                'naam' => $leverancier->naam,
                'contactpersoon' => $leverancier->contactpersoon,
                'leveranciernummer' => $leverancier->leveranciernummer,
                'mobiel' => $leverancier->mobiel,
                'straatnaam' => $leverancier->straatnaam,
                'huisnummer' => $leverancier->huisnummer,
                'postcode' => $leverancier->postcode,
                'stad' => $leverancier->stad
            ];

            $this->view('wijzigLeverancier/wijzig', $data);
        }
    }
}