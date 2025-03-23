<?php
class ProductSpecificatieModel {
    private $db;

    public function __construct() {
        $this->db = new Database;
    }

    public function getProductSpecificaties($productId, $startdatum = null, $einddatum = null) {
        $query = '
            SELECT p.Id AS ProductId, p.Naam AS ProductNaam, a.Naam AS AllergeenNaam, pl.DatumLevering, pl.Aantal
            FROM product p
            JOIN productperleverancier pl ON p.Id = pl.ProductId
            LEFT JOIN productperallergeen pa ON p.Id = pa.ProductId
            LEFT JOIN allergeen a ON pa.AllergeenId = a.Id
            WHERE p.Id = :productId
        ';

        if ($startdatum && $einddatum) {
            $query .= ' AND pl.DatumLevering BETWEEN :startdatum AND :einddatum';
        }

        $query .= ' ORDER BY pl.DatumLevering ASC';

        $this->db->query($query);
        $this->db->bind(':productId', $productId);

        if ($startdatum && $einddatum) {
            $this->db->bind(':startdatum', $startdatum);
            $this->db->bind(':einddatum', $einddatum);
        }

        return $this->db->resultSet();
    }
}