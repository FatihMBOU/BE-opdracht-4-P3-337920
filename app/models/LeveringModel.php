<?php
class LeveringModel {
    private $db;

    public function __construct() {
        $this->db = new Database;
    }

    public function getProductById($id) {
        $this->db->query('SELECT * FROM Product WHERE Id = :id');
        $this->db->bind(':id', $id);
        return $this->db->single();
    }

    public function updateProduct($id, $aantal, $datum) {
        $this->db->query('UPDATE Magazijn SET AantalAanwezig = AantalAanwezig + :aantal, DatumGewijzigd = :datum WHERE ProductId = :id');
        $this->db->bind(':id', $id);
        $this->db->bind(':aantal', $aantal);
        $this->db->bind(':datum', $datum);
        return $this->db->execute();
    }
}