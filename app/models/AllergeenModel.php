<?php
class AllergeenModel {
    private $db;

    public function __construct() {
        $this->db = new Database;
    }

    public function getAllergenen() {
        $this->db->query('SELECT * FROM allergeen ORDER BY naam');
        return $this->db->resultSet();
    }

    public function getProductenMetAllergeen($allergeen) {
        $this->db->query('SELECT naam, beschrijving FROM producten WHERE allergenen LIKE :allergeen ORDER BY naam');
        $this->db->bind(':allergeen', '%' . $allergeen . '%');
        return $this->db->resultSet();
    }
}