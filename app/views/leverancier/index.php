<?php require_once APPROOT . '/views/includes/header.php'; ?>

<div class="container">
    <div class="row mt-3">
        <div class="col-12">
            <h3>Overzicht Leverancier Gegevens</h3>
        </div>
    </div>

    <?php if ($data['message']) : ?>
        <div class="alert alert-danger" role="alert">
            <?= $data['message']; ?>
        </div>
    <?php endif; ?>

    <?php if (!empty($data['leverancier'])): ?>
        <div class="row mt-3">
            <div class="col-12">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Naam</th>
                            <th>Contactpersoon</th>
                            <th>Mobiel</th>
                            <th>Leveranciernummer</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><?= $data['leverancier']->Naam; ?></td>
                            <td><?= $data['leverancier']->Contactpersoon; ?></td>
                            <td><?= $data['leverancier']->Mobiel; ?></td>
                            <td><?= $data['leverancier']->Leveranciernummer; ?></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    <?php endif; ?>

    <div class="row mt-3">
        <div class="col-12 text-right">
            <a href="<?= URLROOT; ?>" class="btn btn-primary">Home</a>
        </div>
    </div>
</div>

<?php require_once APPROOT . '/views/includes/footer.php'; ?>