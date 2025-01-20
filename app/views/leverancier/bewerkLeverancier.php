<?php require_once APPROOT . '/views/includes/header.php'; ?>

<div class="container">
    <div class="row mt-3">
        <div class="col-12">
            <h3>Bewerk Leverancier</h3>
            <?php if (!empty($data['error_message'])): ?>
                <div class="alert alert-danger">
                    <?= $data['error_message']; ?>
                </div>
            <?php endif; ?>
            <?php if (!empty($data['success_message'])): ?>
                <div class="alert alert-success">
                    <?= $data['success_message']; ?>
                </div>
            <?php endif; ?>
            <form action="<?= URLROOT; ?>/leverancier/bewerkLeverancier/<?= $data['id']; ?>" method="post">
                <table class="table">
                    <tr>
                        <td><label for="naam">Naam: <sup>*</sup></label></td>
                        <td>
                            <input type="text" name="naam" class="form-control form-control-lg <?= (!empty($data['naam_err'])) ? 'is-invalid' : ''; ?>" value="<?= $data['naam']; ?>" <?= ($data['naam'] === 'de Bron') ? 'readonly' : ''; ?>>
                            <span class="invalid-feedback"><?= $data['naam_err']; ?></span>
                        </td>
                    </tr>
                    <tr>
                        <td><label for="contactpersoon">Contactpersoon: <sup>*</sup></label></td>
                        <td>
                            <input type="text" name="contactpersoon" class="form-control form-control-lg <?= (!empty($data['contactpersoon_err'])) ? 'is-invalid' : ''; ?>" value="<?= $data['contactpersoon']; ?>" <?= ($data['naam'] === 'de Bron') ? 'readonly' : ''; ?>>
                            <span class="invalid-feedback"><?= $data['contactpersoon_err']; ?></span>
                        </td>
                    </tr>
                    <tr>
                        <td><label for="leveranciernummer">Leveranciernummer: <sup>*</sup></label></td>
                        <td>
                            <input type="text" name="leveranciernummer" class="form-control form-control-lg <?= (!empty($data['leveranciernummer_err'])) ? 'is-invalid' : ''; ?>" value="<?= $data['leveranciernummer']; ?>" <?= ($data['naam'] === 'de Bron') ? 'readonly' : ''; ?>>
                            <span class="invalid-feedback"><?= $data['leveranciernummer_err']; ?></span>
                        </td>
                    </tr>
                    <tr>
                        <td><label for="mobiel">Mobiel: <sup>*</sup></label></td>
                        <td>
                            <input type="text" name="mobiel" class="form-control form-control-lg <?= (!empty($data['mobiel_err'])) ? 'is-invalid' : ''; ?>" value="<?= $data['mobiel']; ?>" <?= ($data['naam'] === 'de Bron') ? 'readonly' : ''; ?>>
                            <span class="invalid-feedback"><?= $data['mobiel_err']; ?></span>
                        </td>
                    </tr>
                    <tr>
                        <td><label for="straatnaam">Straatnaam: <sup>*</sup></label></td>
                        <td>
                            <input type="text" name="straatnaam" class="form-control form-control-lg <?= (!empty($data['straatnaam_err'])) ? 'is-invalid' : ''; ?>" value="<?= $data['straatnaam']; ?>" <?= ($data['naam'] === 'de Bron') ? 'readonly' : ''; ?>>
                            <span class="invalid-feedback"><?= $data['straatnaam_err']; ?></span>
                        </td>
                    </tr>
                    <tr>
                        <td><label for="huisnummer">Huisnummer: <sup>*</sup></label></td>
                        <td>
                            <input type="text" name="huisnummer" class="form-control form-control-lg <?= (!empty($data['huisnummer_err'])) ? 'is-invalid' : ''; ?>" value="<?= $data['huisnummer']; ?>" <?= ($data['naam'] === 'de Bron') ? 'readonly' : ''; ?>>
                            <span class="invalid-feedback"><?= $data['huisnummer_err']; ?></span>
                        </td>
                    </tr>
                    <tr>
                        <td><label for="postcode">Postcode: <sup>*</sup></label></td>
                        <td>
                            <input type="text" name="postcode" class="form-control form-control-lg <?= (!empty($data['postcode_err'])) ? 'is-invalid' : ''; ?>" value="<?= $data['postcode']; ?>" <?= ($data['naam'] === 'de Bron') ? 'readonly' : ''; ?>>
                            <span class="invalid-feedback"><?= $data['postcode_err']; ?></span>
                        </td>
                    </tr>
                    <tr>
                        <td><label for="stad">Stad: <sup>*</sup></label></td>
                        <td>
                            <input type="text" name="stad" class="form-control form-control-lg <?= (!empty($data['stad_err'])) ? 'is-invalid' : ''; ?>" value="<?= $data['stad']; ?>" <?= ($data['naam'] === 'de Bron') ? 'readonly' : ''; ?>>
                            <span class="invalid-feedback"><?= $data['stad_err']; ?></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="submit" class="btn btn-success" value="Update Leverancier" <?= ($data['naam'] === 'de Bron') ? 'disabled' : ''; ?>>
                        </td>
                        <td class="text-right">
                            <a href="<?= URLROOT; ?>/leverancier/wijzigenLeverancier" class="btn btn-secondary">Terug naar Wijzigen Leverancier</a>
                            <a href="<?= URLROOT; ?>" class="btn btn-primary">Home</a>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>

<?php require_once APPROOT . '/views/includes/footer.php'; ?>