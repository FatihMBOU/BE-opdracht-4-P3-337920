<?php require_once APPROOT . '/views/includes/header.php'; ?>

<div class="container">
    <div class="row mt-3">
        <div class="col-12">
            <h3>Nieuwe Levering</h3>
        </div>
    </div>

    <div class="row mt-3">
        <div class="col-12">
            <!-- Leverancier informatie weergeven -->
            <h5>Leverancier Informatie</h5>
            <p><strong>Naam:</strong> <?= $data['leverancier']->Naam ?></p>
            <p><strong>Contactpersoon:</strong> <?= $data['leverancier']->Contactpersoon ?></p>
            <p><strong>Mobiel:</strong> <?= $data['leverancier']->Mobiel ?></p>
            <p><strong>Aantal Producten:</strong> <?= $data['leverancier']->AantalProducten ?></p>
            <p><strong>Datum Eerst Volgende Levering:</strong> <?= date('d-m-Y', strtotime($data['leverancier']->DatumEerstVolgendeLevering)) ?></p>
        </div>
    </div>

    <form action="<?= URLROOT; ?>/leverancier/nieuweLevering/<?= $data['id']; ?>" method="post">
        <div class="form-group">
            <label for="aantal">Aantal:</label>
            <input type="number" name="aantal" class="form-control <?= (!empty($data['aantal_err'])) ? 'is-invalid' : ''; ?>" value="<?= $data['aantal']; ?>">
            <span class="invalid-feedback"><?= $data['aantal_err']; ?></span>
        </div>
        <div class="form-group">
            <label for="datum">Datum:</label>
            <input type="date" name="datum" class="form-control <?= (!empty($data['datum_err'])) ? 'is-invalid' : ''; ?>" value="<?= $data['datum']; ?>">
            <span class="invalid-feedback"><?= $data['datum_err']; ?></span>
        </div>
        <div class="form-group mt-3">
            <div class="d-flex justify-content-between">
                <input type="submit" class="btn btn-success" value="Opslaan">
                <div>
                    <a href="<?= URLROOT; ?>/leverancier/geleverdeProducten/<?= $data['id']; ?>" class="btn btn-secondary">Terug</a>
                    <a href="<?= URLROOT; ?>" class="btn btn-primary">Home</a>
                </div>
            </div>
        </div>
    </form>
</div>

<?php require_once APPROOT . '/views/includes/footer.php'; ?>