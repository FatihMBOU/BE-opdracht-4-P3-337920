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

    public function wijzigenLeverancier($page = 1)
    {
        $perPage = 4; // Aantal leveranciers per pagina
        $offset = ($page - 1) * $perPage;

        // Haal het totale aantal leveranciers op
        $totalLeveranciers = $this->leverancierModel->getTotalLeveranciers();
        $totalPages = ceil($totalLeveranciers / $perPage);

        // Haal de leveranciers voor de huidige pagina op
        $leveranciers = $this->leverancierModel->getLeveranciersByPage($perPage, $offset);

        $data = [
            'title' => 'Wijzig Leverancier',
            'leveranciers' => $leveranciers,
            'currentPage' => $page,
            'totalPages' => $totalPages
        ];

        $this->view('leverancier/wijzigenLeverancier', $data);
    }

    public function wijzigLeverancier($id)
    {
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

        $this->view('leverancier/wijzigLeverancier', $data);
    }

    public function bewerkLeverancier($id)
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
                'stad_err' => '',
                'error_message' => '',
                'success_message' => ''
            ];
    
            // Check if the leverancier is "De Bron"
            if ($data['naam'] === 'De Bron') {
                // Set error message
                $data['error_message'] = 'Door een technische storing is het niet mogelijk de wijziging door te voeren. Probeer het op een later moment nog eens.';
                // Load the view with the error message
                $this->view('leverancier/bewerkLeverancier', $data);
                // Redirect to wijzigLeverancier page with delay
                echo "<script>
                        setTimeout(function(){
                            window.location.href = '" . URLROOT . "/leverancier/wijzigLeverancier/$id';
                        }, 3000);
                      </script>";
            } else {
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
                        // Set success message
                        $data['success_message'] = 'De wijzigingen zijn doorgevoerd';
                        // Load the view with the success message
                        $this->view('leverancier/wijzigLeverancier', $data);
                        // Redirect to wijzigLeverancier page with delay
                        echo "<script>
                                setTimeout(function(){
                                    window.location.href = '" . URLROOT . "/leverancier/wijzigLeverancier/$id';
                                }, 3000);
                              </script>";
                    } else {
                        // Set error message
                        $data['error_message'] = 'Door een technische storing is het niet mogelijk de wijziging door te voeren. Probeer het op een later moment nog eens.';
                        // Load the view with the error message
                        $this->view('leverancier/bewerkLeverancier', $data);
                        // Redirect to wijzigLeverancier page with delay
                        echo "<script>
                                setTimeout(function(){
                                    window.location.href = '" . URLROOT . "/leverancier/wijzigLeverancier/$id';
                                }, 3000);
                              </script>";
                    }
                } else {
                    // Load view with errors
                    $this->view('leverancier/bewerkLeverancier', $data);
                }
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
                'stad' => $leverancier->stad,
                'error_message' => '',
                'success_message' => ''
            ];
    
            $this->view('leverancier/bewerkLeverancier', $data);
        }
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
                'datum_err' => '',
            ];

            $this->view('leverancier/nieuweLevering', $data);
        }
    }
}