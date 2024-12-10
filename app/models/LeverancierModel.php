<?php

class LeverancierModel
{
    private $db;

    public function __construct()
    {
        // Initialiseer de database-verbinding
        $this->db = new PDO('mysql:host=' . DB_HOST . ';dbname=' . DB_NAME, DB_USER, DB_PASS);
        $this->db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    }

    public function getAllLeveranciers()
    {
        try {
            // SQL-query om alle leveranciers en het aantal verschillende producten dat zij leveren op te halen
            $sql = "CALL spGetAllLeveranciers()";
            $stmt = $this->db->prepare($sql);
            $stmt->execute();
            $result = $stmt->fetchAll(PDO::FETCH_OBJ);
            $stmt->closeCursor(); // Sluit de vorige resultaatset
            return $result;
        } catch (Exception $e) {
            // Log de fout en gooi een nieuwe uitzondering
            error_log("Fout in getAllLeveranciers: " . $e->getMessage());
            throw new Exception("Database query failed: " . $e->getMessage());
        }
    }

    public function getGeleverdeProducten($leverancierId)
    {
        try {
            // SQL-query om de geleverde producten van een specifieke leverancier op te halen
            $sql = "CALL spGetGeleverdeProducten(:leverancierId)";
            $stmt = $this->db->prepare($sql);
            // Bind de parameter leverancierId aan de query
            $stmt->bindParam(':leverancierId', $leverancierId, PDO::PARAM_INT);
            $stmt->execute();
            $result = $stmt->fetchAll(PDO::FETCH_OBJ);
            $stmt->closeCursor(); // Sluit de vorige resultaatset
            return $result;
        } catch (Exception $e) {
            // Log de fout en gooi een nieuwe uitzondering
            error_log("Fout in getGeleverdeProducten: " . $e->getMessage());
            throw new Exception("Database query failed: " . $e->getMessage());
        }
    }

    public function updateProduct($id, $aantal, $datum) {
        try {
            $sql = 'UPDATE Magazijn SET AantalAanwezig = AantalAanwezig + :aantal, DatumGewijzigd = :datum WHERE ProductId = :id';
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(':id', $id, PDO::PARAM_INT);
            $stmt->bindParam(':aantal', $aantal, PDO::PARAM_INT);
            $stmt->bindParam(':datum', $datum, PDO::PARAM_STR);
            $stmt->execute();

            // Update de datum van de laatste levering in de ProductPerLeverancier tabel
            $sql = 'UPDATE ProductPerLeverancier SET DatumLevering = :datum WHERE ProductId = :id';
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(':id', $id, PDO::PARAM_INT);
            $stmt->bindParam(':datum', $datum, PDO::PARAM_STR);
            return $stmt->execute();
        } catch (Exception $e) {
            // Log de fout en gooi een nieuwe uitzondering
            error_log("Fout in updateProduct: " . $e->getMessage());
            throw new Exception("Database query failed: " . $e->getMessage());
        }
    }

    public function getProductById($id) {
        try {
            $sql = 'SELECT * FROM Product WHERE Id = :id';
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(':id', $id, PDO::PARAM_INT);
            $stmt->execute();
            $result = $stmt->fetch(PDO::FETCH_OBJ);
            $stmt->closeCursor(); // Sluit de vorige resultaatset
            return $result;
        } catch (Exception $e) {
            // Log de fout en gooi een nieuwe uitzondering
            error_log("Fout in getProductById: " . $e->getMessage());
            throw new Exception("Database query failed: " . $e->getMessage());
        }
    }

    public function getLeverancierByProductId($productId) {
        try {
            $sql = '
                SELECT l.Naam, l.Contactpersoon, l.Mobiel, l.Leveranciernummer, COUNT(p.Id) AS AantalProducten, MAX(pl.DatumLevering) AS DatumEerstVolgendeLevering
                FROM Leverancier l
                JOIN ProductPerLeverancier pl ON l.Id = pl.LeverancierId
                JOIN Product p ON pl.ProductId = p.Id
                WHERE p.Id = :productId
                GROUP BY l.Naam, l.Contactpersoon, l.Mobiel, l.Leveranciernummer
            ';
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(':productId', $productId, PDO::PARAM_INT);
            $stmt->execute();
            $result = $stmt->fetch(PDO::FETCH_OBJ);
            $stmt->closeCursor(); // Sluit de vorige resultaatset
            return $result;
        } catch (Exception $e) {
            // Log de fout en gooi een nieuwe uitzondering
            error_log("Fout in getLeverancierByProductId: " . $e->getMessage());
            throw new Exception("Database query failed: " . $e->getMessage());
        }
    }

    public function getLeverancierById($leverancierId) {
        try {
            $sql = 'SELECT * FROM Leverancier WHERE Id = :leverancierId';
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(':leverancierId', $leverancierId, PDO::PARAM_INT);
            $stmt->execute();
            $result = $stmt->fetch(PDO::FETCH_OBJ);
            $stmt->closeCursor(); // Sluit de vorige resultaatset
            return $result;
        } catch (Exception $e) {
            // Log de fout en gooi een nieuwe uitzondering
            error_log("Fout in getLeverancierById: " . $e->getMessage());
            throw new Exception("Database query failed: " . $e->getMessage());
        }
    }
}