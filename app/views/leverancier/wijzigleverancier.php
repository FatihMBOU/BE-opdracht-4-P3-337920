<?php require_once APPROOT . '/views/includes/header.php'; ?>

<div class="container">
    <div class="row mt-3">
        <div class="col-12">
            <h3>Leverancier Details</h3>
            <table class="table">
                <tr>
                    <td><label for="naam">Naam:</label></td>
                    <td>
                        <input type="text" name="naam" class="form-control form-control-lg" value="<?= $data['naam']; ?>" readonly>
                    </td>
                </tr>
                <tr>
                    <td><label for="contactpersoon">Contactpersoon:</label></td>
                    <td>
                        <input type="text" name="contactpersoon" class="form-control form-control-lg" value="<?= $data['contactpersoon']; ?>" readonly>
                    </td>
                </tr>
                <tr>
                    <td><label for="leveranciernummer">Leveranciernummer:</label></td>
                    <td>
                        <input type="text" name="leveranciernummer" class="form-control form-control-lg" value="<?= $data['leveranciernummer']; ?>" readonly>
                    </td>
                </tr>
                <tr>
                    <td><label for="mobiel">Mobiel:</label></td>
                    <td>
                        <input type="text" name="mobiel" class="form-control form-control-lg" value="<?= $data['mobiel']; ?>" readonly>
                    </td>
                </tr>
                <tr>
                    <td><label for="straatnaam">Straatnaam:</label></td>
                    <td>
                        <input type="text" name="straatnaam" class="form-control form-control-lg" value="<?= $data['straatnaam']; ?>" readonly>
                    </td>
                </tr>
                <tr>
                    <td><label for="huisnummer">Huisnummer:</label></td>
                    <td>
                        <input type="text" name="huisnummer" class="form-control form-control-lg" value="<?= $data['huisnummer']; ?>" readonly>
                    </td>
                </tr>
                <tr>
                    <td><label for="postcode">Postcode:</label></td>
                    <td>
                        <input type="text" name="postcode" class="form-control form-control-lg" value="<?= $data['postcode']; ?>" readonly>
                    </td>
                </tr>
                <tr>
                    <td><label for="stad">Stad:</label></td>
                    <td>
                        <input type="text" name="stad" class="form-control form-control-lg" value="<?= $data['stad']; ?>" readonly>
                    </td>
                </tr>
                <tr>
                    <td>
                        <a href="<?= URLROOT; ?>/leverancier/bewerkLeverancier/<?= $data['id']; ?>" class="btn btn-warning">Wijzig</a>
                    </td>
                    <td class="text-right">
                        <a href="<?= URLROOT; ?>/leverancier/wijzigenLeverancier" class="btn btn-secondary">Terug naar overzicht Leverancier</a>
                        <a href="<?= URLROOT; ?>" class="btn btn-primary">Home</a>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>

<?php require_once APPROOT . '/views/includes/footer.php'; ?>