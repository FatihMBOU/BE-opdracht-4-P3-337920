<?php require_once APPROOT . '/views/includes/header.php'; ?>

<div class="container">
    <div class="row mt-3">
        <div class="col-12">
            <!-- Titel van de pagina -->
            <h3><?php echo $data['title']; ?></h3>
        </div>
    </div>

    <?php if ($data['message']) { ?>
        <div class="row mt-3">
            <div class="col-12">
                <!-- Foutmelding weergeven -->
                <div class="alert alert-danger" role="alert">
                    <?= $data['message']; ?>
                </div>
            </div>
        </div>
    <?php } else { ?>
        <div class="row mt-3">
            <div class="col-12">
                <!-- Leverancier informatie weergeven -->
                <h5>Leverancier Informatie</h5>
                <p><strong>Naam:</strong> <?= $data['leverancier']['Naam'] ?></p>
                <p><strong>Contactpersoon:</strong> <?= $data['leverancier']['Contactpersoon'] ?></p>
                <p><strong>Leveranciernummer:</strong> <?= $data['leverancier']['Leveranciernummer'] ?></p>
                <p><strong>Mobiel:</strong> <?= $data['leverancier']['Mobiel'] ?></p>
            </div>
        </div>

        <div class="row mt-3">
            <div class="col-12">
                <!-- Tabel met leveringsinformatie -->
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Datum Laatste Levering</th>
                            <th>Verwachte Volgende Levering</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if (is_null($data['leveringen'])) { ?>
                            <tr>
                                <td colspan='2' class='text-center'>Geen leveringsinformatie beschikbaar</td>
                            </tr>
                        <?php } else {                              
                            foreach ($data['leveringen'] as $levering) { ?>
                                <tr>
                                    <td><?= $levering->DatumLaatsteLevering ?></td>
                                    <td><?= $levering->DatumEerstVolgendeLevering ?></td>
                                </tr>
                            <?php } 
                        } ?>
                    </tbody>
                </table>
                <a href="<?= URLROOT; ?>/magazijn/index">Terug naar overzicht</a>
            </div>
        </div>
    <?php } ?>
</div>

<?php require_once APPROOT . '/views/includes/footer.php'; ?>