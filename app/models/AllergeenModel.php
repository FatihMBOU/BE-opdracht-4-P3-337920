<?php
class AllergeenModel {
    private $db;

    public function __construct() {
        $this->db = new Database;
    }

    public function getAllergenen() {
        $this->db->query('SELECT * FROM allergeen ORDER BY Naam');
        return $this->db->resultSet();
    }

    public function getProductenMetAllergeen($allergeenId) {
        $this->db->query('
            SELECT p.Id AS productId, p.Naam AS productNaam, a.Naam AS allergeenNaam, a.Omschrijving, m.AantalAanwezig 
            FROM product p
            JOIN productperallergeen ppa ON p.Id = ppa.ProductId
            JOIN allergeen a ON a.Id = ppa.AllergeenId
            JOIN magazijn m ON p.Id = m.ProductId
            WHERE ppa.AllergeenId = :allergeenId
            ORDER BY p.Naam
        ');
        $this->db->bind(':allergeenId', $allergeenId);
        return $this->db->resultSet();
    }
}
