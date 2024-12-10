<?php

class Magazijn extends BaseController
{
    private $magazijnModel;

    public function __construct()
    {
        // Laad het model voor magazijn
        $this->magazijnModel = $this->model('MagazijnModel');
    }

    public function index()
    {
        // Initialiseer data array voor de view
        $data = [
            'title' => 'Overzicht Magazijn Jamin',
            'message' => NULL,
            'messageColor' => NULL,
            'messageVisibility' => 'none',
            'dataRows' => NULL
        ];

        try {
            // Haal alle magazijnproducten op
            $result = $this->magazijnModel->getAllMagazijnProducts();

            if (empty($result)) {
                throw new Exception("Geen resultaten gevonden");
            }

            // Zet de opgehaalde data in de data array
            $data['dataRows'] = $result;
        } catch (Exception $e) {
            // Log de fout en zet de foutmelding in de data array
            error_log($e->getMessage());
            $data['message'] = "Er is een fout opgetreden in de database: " . $e->getMessage();
            $data['messageColor'] = "danger";
            $data['messageVisibility'] = "flex";
        }

        // Laad de view met de data
        $this->view('magazijn/index', $data);
    }

    public function leveringInfo($productId)
    {
        // Initialiseer data array voor de view
        $data = [
            'title' => 'Levering Informatie',
            'leveringen' => NULL,
            'leverancier' => NULL,
            'message' => NULL
        ];

        try {
            // Haal de voorraad van het product op
            $voorraad = $this->magazijnModel->getProductVoorraad($productId);

            if ($voorraad->AantalAanwezig == 0) {
                // Zet de foutmelding en redirect na 4 seconden
                $data['message'] = "Er is van dit product op dit moment geen voorraad aanwezig, de verwachte eerstvolgende levering is: 30-04-2023";
                header("refresh:4;url=" . URLROOT . "/magazijn/index");
            } else {
                // Haal de leveringsinformatie van het product op
                $result = $this->magazijnModel->getLeveringInfoByProductId($productId);

                if (empty($result)) {
                    throw new Exception("Geen leveringsinformatie gevonden");
                }

                // Zet de opgehaalde data in de data array
                $data['leveringen'] = $result;
                $data['leverancier'] = [
                    'Naam' => $result[0]->LeverancierNaam,
                    'Contactpersoon' => $result[0]->Contactpersoon,
                    'Leveranciernummer' => $result[0]->Leveranciernummer,
                    'Mobiel' => $result[0]->Mobiel
                ];
            }
        } catch (Exception $e) {
            // Log de fout en zet de foutmelding in de data array
            error_log($e->getMessage());
            $data['message'] = "Er is een fout opgetreden in de database: " . $e->getMessage();
            $data['messageColor'] = "danger";
            $data['messageVisibility'] = "flex";
        }

        // Laad de view met de data
        $this->view('magazijn/leveringinfo', $data);
    }

    public function allergenenInfo($productId)
    {
        // Initialiseer data array voor de view
        $data = [
            'title' => 'Overzicht Allergenen',
            'allergenen' => NULL,
            'product' => NULL,
            'message' => NULL
        ];

        try {
            // Haal de productdetails op
            $productDetails = $this->magazijnModel->getProductDetails($productId);
            if (!$productDetails) {
                throw new Exception("Geen productinformatie gevonden");
            }

            // Haal de allergeneninformatie van het product op
            $result = $this->magazijnModel->getAllergenenInfoByProductId($productId);

            if (empty($result)) {
                // Zet de foutmelding als er geen allergeneninformatie is
                $data['message'] = "In dit product zitten geen stoffen die een allergische reactie kunnen veroorzaken";
            } else {
                // Zet de opgehaalde data in de data array
                $data['allergenen'] = $result;
            }

            $data['product'] = $productDetails;
        } catch (Exception $e) {
            // Log de fout en zet de foutmelding in de data array
            error_log($e->getMessage());
            $data['message'] = "Er is een fout opgetreden in de database: " . $e->getMessage();
            $data['messageColor'] = "danger";
            $data['messageVisibility'] = "flex";
        }

        // Laad de view met de data
        $this->view('magazijn/allergeneninfo', $data);
    }
}