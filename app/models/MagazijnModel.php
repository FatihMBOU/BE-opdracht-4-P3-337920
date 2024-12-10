<?php

class MagazijnModel
{
    private $db;

    public function __construct()
    {
        // Initialiseer de database-verbinding
        $this->db = new Database();
    }

    public function getAllMagazijnProducts()
    {
        try {
            // SQL-query om alle producten uit het magazijn op te halen
            $sql = "CALL spReadMagazijnProduct()";
            $this->db->query($sql);
            // Voer de query uit en retourneer het resultaat
            return $this->db->resultSet();
        } catch (Exception $e) {
            // Log de fout en gooi een nieuwe uitzondering
            error_log("Fout in getAllMagazijnProducts: " . $e->getMessage());
            throw new Exception("Database query failed: " . $e->getMessage());
        }
    }

    public function getLeveringInfoByProductId($productId)
    {
        try {
            // SQL-query om leveringsinformatie voor een specifiek product op te halen
            $sql = "SELECT l.*, lv.Naam AS LeverancierNaam, lv.Contactpersoon, lv.Leveranciernummer, lv.Mobiel 
                    FROM ProductPerLeverancier l
                    JOIN Leverancier lv ON l.LeverancierId = lv.Id
                    WHERE l.ProductId = :productId
                    ORDER BY l.DatumLevering ASC";
            $this->db->query($sql);
            // Bind de parameter productId aan de query
            $this->db->bind(':productId', $productId);
            // Voer de query uit en retourneer het resultaat
            return $this->db->resultSet();
        } catch (Exception $e) {
            // Log de fout en gooi een nieuwe uitzondering
            error_log("Fout in getLeveringInfoByProductId: " . $e->getMessage());
            throw new Exception("Database query failed: " . $e->getMessage());
        }
    }

    public function getProductVoorraad($productId)
    {
        try {
            // SQL-query om de voorraad van een specifiek product op te halen
            $sql = "SELECT AantalAanwezig FROM Magazijn WHERE ProductId = :productId";
            $this->db->query($sql);
            // Bind de parameter productId aan de query
            $this->db->bind(':productId', $productId);
            // Voer de query uit en retourneer een enkele rij
            return $this->db->single();
        } catch (Exception $e) {
            // Log de fout en gooi een nieuwe uitzondering
            error_log("Fout in getProductVoorraad: " . $e->getMessage());
            throw new Exception("Database query failed: " . $e->getMessage());
        }
    }

    public function getAllergenenInfoByProductId($productId)
    {
        try {
            // SQL-query om allergeneninformatie voor een specifiek product op te halen
            $sql = "SELECT a.* 
                    FROM Allergeen a
                    JOIN ProductPerAllergeen pa ON a.Id = pa.AllergeenId
                    WHERE pa.ProductId = :productId
                    ORDER BY a.Naam ASC";
            $this->db->query($sql);
            // Bind de parameter productId aan de query
            $this->db->bind(':productId', $productId);
            // Voer de query uit en retourneer het resultaat
            return $this->db->resultSet();
        } catch (Exception $e) {
            // Log de fout en gooi een nieuwe uitzondering
            error_log("Fout in getAllergenenInfoByProductId: " . $e->getMessage());
            throw new Exception("Database query failed: " . $e->getMessage());
        }
    }

    public function getProductDetails($productId)
    {
        try {
            // SQL-query om de details van een specifiek product op te halen
            $sql = "SELECT Naam, Barcode FROM Product WHERE Id = :productId";
            $this->db->query($sql);
            // Bind de parameter productId aan de query
            $this->db->bind(':productId', $productId);
            // Voer de query uit en retourneer een enkele rij
            return $this->db->single();
        } catch (Exception $e) {
            // Log de fout en gooi een nieuwe uitzondering
            error_log("Fout in getProductDetails: " . $e->getMessage());
            throw new Exception("Database query failed: " . $e->getMessage());
        }
    }
}