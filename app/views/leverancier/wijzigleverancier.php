<?php require_once APPROOT . '/views/includes/header.php'; ?>
<div class="container">
    <div class="row mt-3">
        <div class="col-12">
            <h3>Wijzig Leverancier</h3>
            <form action="<?= URLROOT; ?>/leverancier/wijzigLeverancier/<?= $data['id']; ?>" method="post">
                <div class="form-group">
                    <label for="naam">Naam: <sup>*</sup></label>
                    <input type="text" name="naam" class="form-control form-control-lg <?= (!empty($data['naam_err'])) ? 'is-invalid' : ''; ?>" value="<?= $data['naam']; ?>">
                    <span class="invalid-feedback"><?= $data['naam_err']; ?></span>
                </div>
                <div class="form-group">
                    <label for="contactpersoon">Contactpersoon: <sup>*</sup></label>
                    <input type="text" name="contactpersoon" class="form-control form-control-lg <?= (!empty($data['contactpersoon_err'])) ? 'is-invalid' : ''; ?>" value="<?= $data['contactpersoon']; ?>">
                    <span class="invalid-feedback"><?= $data['contactpersoon_err']; ?></span>
                </div>
                <div class="form-group">
                    <label for="leveranciernummer">Leveranciernummer: <sup>*</sup></label>
                    <input type="text" name="leveranciernummer" class="form-control form-control-lg <?= (!empty($data['leveranciernummer_err'])) ? 'is-invalid' : ''; ?>" value="<?= $data['leveranciernummer']; ?>">
                    <span class="invalid-feedback"><?= $data['leveranciernummer_err']; ?></span>
                </div>
                <div class="form-group">
                    <label for="mobiel">Mobiel: <sup>*</sup></label>
                    <input type="text" name="mobiel" class="form-control form-control-lg <?= (!empty($data['mobiel_err'])) ? 'is-invalid' : ''; ?>" value="<?= $data['mobiel']; ?>">
                    <span class="invalid-feedback"><?= $data['mobiel_err']; ?></span>
                </div>
                <div class="form-group">
                    <label for="straatnaam">Straatnaam: <sup>*</sup></label>
                    <input type="text" name="straatnaam" class="form-control form-control-lg <?= (!empty($data['straatnaam_err'])) ? 'is-invalid' : ''; ?>" value="<?= $data['straatnaam']; ?>">
                    <span class="invalid-feedback"><?= $data['straatnaam_err']; ?></span>
                </div>
                <div class="form-group">
                    <label for="huisnummer">Huisnummer: <sup>*</sup></label>
                    <input type="text" name="huisnummer" class="form-control form-control-lg <?= (!empty($data['huisnummer_err'])) ? 'is-invalid' : ''; ?>" value="<?= $data['huisnummer']; ?>">
                    <span class="invalid-feedback"><?= $data['huisnummer_err']; ?></span>
                </div>
                <div class="form-group">
                    <label for="postcode">Postcode: <sup>*</sup></label>
                    <input type="text" name="postcode" class="form-control form-control-lg <?= (!empty($data['postcode_err'])) ? 'is-invalid' : ''; ?>" value="<?= $data['postcode']; ?>">
                    <span class="invalid-feedback"><?= $data['postcode_err']; ?></span>
                </div>
                <div class="form-group">
                    <label for="stad">Stad: <sup>*</sup></label>
                    <input type="text" name="stad" class="form-control form-control-lg <?= (!empty($data['stad_err'])) ? 'is-invalid' : ''; ?>" value="<?= $data['stad']; ?>">
                    <span class="invalid-feedback"><?= $data['stad_err']; ?></span>
                </div>
                <div class="form-group">
                    <input type="submit" class="btn btn-success" value="Wijzig Leverancier">
                </div>
            </form>
        </div>
    </div>
</div>
<?php require_once APPROOT . '/views/includes/footer.php'; ?>