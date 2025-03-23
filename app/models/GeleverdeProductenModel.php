<?php
class GeleverdeProductenModel {
    private $db;

    public function __construct() {
        $this->db = new Database;
    }

    public function getGeleverdeProducten() {
        $this->db->query('
            SELECT p.Id AS ProductId, l.Naam AS LeverancierNaam, l.Contactpersoon, p.Naam AS ProductNaam, SUM(pl.Aantal) AS TotaalGeleverd
            FROM product p
            JOIN productperleverancier pl ON p.Id = pl.ProductId
            JOIN leverancier l ON l.Id = pl.LeverancierId
            GROUP BY p.Id, l.Naam, l.Contactpersoon, p.Naam
            ORDER BY l.Naam ASC
        ');
        return $this->db->resultSet();
    }
}