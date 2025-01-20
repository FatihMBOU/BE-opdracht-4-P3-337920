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
            $sql = "SELECT id, Naam, Contactpersoon, Leveranciernummer, Mobiel FROM leverancier";
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
                GROUP BY l.Id';
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

    public function getLeverancierById($id)
    {
        try {
            // SQL-query om een specifieke leverancier en bijbehorende contactgegevens op te halen
            $sql = "SELECT l.id, l.naam, l.contactpersoon, l.leveranciernummer, l.mobiel, c.Straat AS straatnaam, c.Huisnummer AS huisnummer, c.Postcode AS postcode, c.Stad AS stad
                    FROM leverancier l
                    LEFT JOIN contact c ON l.id = c.id
                    WHERE l.id = :id";
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(':id', $id, PDO::PARAM_INT);
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

    public function updateLeverancier($data)
    {
        try {
            // Begin een transactiesessie
            $this->db->beginTransaction();

            // SQL-query om de leveranciergegevens bij te werken
            $sql1 = "UPDATE leverancier SET naam = :naam, contactpersoon = :contactpersoon, leveranciernummer = :leveranciernummer, mobiel = :mobiel WHERE id = :id";
            $stmt1 = $this->db->prepare($sql1);
            $stmt1->bindParam(':id', $data['id'], PDO::PARAM_INT);
            $stmt1->bindParam(':naam', $data['naam'], PDO::PARAM_STR);
            $stmt1->bindParam(':contactpersoon', $data['contactpersoon'], PDO::PARAM_STR);
            $stmt1->bindParam(':leveranciernummer', $data['leveranciernummer'], PDO::PARAM_STR);
            $stmt1->bindParam(':mobiel', $data['mobiel'], PDO::PARAM_STR);
            $stmt1->execute();

            // SQL-query om de contactgegevens bij te werken
            $sql2 = "UPDATE contact SET Straat = :straatnaam, Huisnummer = :huisnummer, Postcode = :postcode, Stad = :stad WHERE id = :id";
            $stmt2 = $this->db->prepare($sql2);
            $stmt2->bindParam(':id', $data['id'], PDO::PARAM_INT);
            $stmt2->bindParam(':straatnaam', $data['straatnaam'], PDO::PARAM_STR);
            $stmt2->bindParam(':huisnummer', $data['huisnummer'], PDO::PARAM_STR);
            $stmt2->bindParam(':postcode', $data['postcode'], PDO::PARAM_STR);
            $stmt2->bindParam(':stad', $data['stad'], PDO::PARAM_STR);
            $stmt2->execute();

            // Commit de transactiesessie
            $this->db->commit();

            return true;
        } catch (Exception $e) {
            // Rollback de transactiesessie bij een fout
            $this->db->rollBack();
            // Log de fout en gooi een nieuwe uitzondering
            error_log("Fout in updateLeverancier: " . $e->getMessage());
            throw new Exception("Database query failed: " . $e->getMessage());
        }
    }

    public function getTotalLeveranciers()
    {
        try {
            $sql = "SELECT COUNT(*) as total FROM leverancier";
            $stmt = $this->db->prepare($sql);
            $stmt->execute();
            $result = $stmt->fetch(PDO::FETCH_OBJ);
            return $result->total;
        } catch (Exception $e) {
            error_log("Fout in getTotalLeveranciers: " . $e->getMessage());
            throw new Exception("Database query failed: " . $e->getMessage());
        }
    }

    public function getLeveranciersByPage($perPage, $offset)
    {
        try {
            $sql = "SELECT id, naam, contactpersoon, leveranciernummer, mobiel FROM leverancier LIMIT :perPage OFFSET :offset";
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(':perPage', $perPage, PDO::PARAM_INT);
            $stmt->bindParam(':offset', $offset, PDO::PARAM_INT);
            $stmt->execute();
            return $stmt->fetchAll(PDO::FETCH_OBJ);
        } catch (Exception $e) {
            error_log("Fout in getLeveranciersByPage: " . $e->getMessage());
            throw new Exception("Database query failed: " . $e->getMessage());
        }
    }
}