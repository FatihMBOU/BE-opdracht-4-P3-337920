<?php require_once APPROOT . '/views/includes/header.php'; ?>

<style>
    .text-right {
        display: flex;
        justify-content: flex-end; /* Align content to the right */
        gap: 10px; /* Space between buttons */
    }
</style>

<div class="container">
    <div class="row mt-3">
        <div class="col-12">
            <!-- Page title -->
            <h3><?php echo $data['title']; ?></h3>
        </div>
    </div>

    <?php if ($data['message']) { ?>
        <div class="row mt-3">
            <div class="col-12">
                <!-- Error message -->
                <div class="alert alert-danger" role="alert">
                    <?= $data['message']; ?>
                </div>
            </div>
        </div>
    <?php } else { ?>
        <div class="row mt-3">
            <div class="col-12">
                <!-- Table with suppliers -->
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Naam</th>
                            <th>Contactpersoon</th>
                            <th>Leveranciernummer</th>
                            <th>Mobiel</th>
                            <th>Aantal Producten</th>
                            <th>Toon Producten</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if (empty($data['leveranciers'])) { ?>
                            <tr>
                                <td colspan='6' class='text-center'>Geen leveranciers beschikbaar</td>
                            </tr>
                        <?php } else {                              
                            foreach ($data['leveranciers'] as $leverancier) { ?>
                                <tr>
                                    <td><?= isset($leverancier->Naam) ? $leverancier->Naam : 'N/A' ?></td>
                                    <td><?= isset($leverancier->Contactpersoon) ? $leverancier->Contactpersoon : 'N/A' ?></td>
                                    <td><?= isset($leverancier->Leveranciernummer) ? $leverancier->Leveranciernummer : 'N/A' ?></td>
                                    <td><?= isset($leverancier->Mobiel) ? $leverancier->Mobiel : 'N/A' ?></td>
                                    <td><?= isset($leverancier->AantalProducten) ? $leverancier->AantalProducten : '0' ?></td>
                                    <td class='text-center'>
                                        <!-- Link to delivered products -->
                                        <a href='<?= URLROOT . "/leverancier/geleverdeProducten/$leverancier->Id" ?>' class='btn btn-info'>
                                            <i class='bi bi-box-seam'></i>
                                        </a>
                                    </td>            
                                </tr>
                            <?php } 
                        } ?>
                    </tbody>
                </table>
            </div>
        </div>
    <?php } ?>

    <div class="row mt-3">
        <div class="col-12 text-right">
            <a href="<?= URLROOT; ?>" class="btn btn-primary">Home</a>
        </div>
    </div>
</div>

<?php require_once APPROOT . '/views/includes/footer.php'; ?>
                        