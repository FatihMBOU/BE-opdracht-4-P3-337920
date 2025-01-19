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