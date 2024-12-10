<?php require_once APPROOT . '/views/includes/header.php'; ?>

<div class="container">
    <div class="row mt-3 text-center" style="display:<?= $data['messageVisibility']; ?>">
        <div class="col-2"></div>
        <div class="col-8">
            <!-- Foutmelding weergeven -->
            <div class="alert alert-<?= $data['messageColor']; ?>" role="alert">
                <?= $data['message']; ?>
            </div>
        </div>
        <div class="col-2"></div>
    </div>

    <div class="row mt-3">
        <div class="col-2"></div>
        <div class="col-8">
            <!-- Titel van de pagina -->
            <h3><?php echo $data['title']; ?></h3>
        </div>
        <div class="col-2"></div>
    </div>

    <div class="row mt-3">
        <div class="col-2"></div>
        <div class="col-8">
            <!-- Tabel met magazijnproducten -->
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>Barcode</th>
                        <th>Naam</th>
                        <th>Verpakkingseenheid</th>
                        <th>Aantal aanwezig</th>
                        <th>Allergenen Info</th>
                        <th>Leverantie Info</th>
                    </tr>
                </thead>
                <tbody>
                    <?php if (is_null($data['dataRows'])) { ?>
                        <tr>
                            <td colspan='6' class='text-center'>Door een storing kunnen we op dit moment geen producten tonen uit het magazijn</td>
                        </tr>
                    <?php } else {                              
                        foreach ($data['dataRows'] as $product) { ?>
                            <tr>
                                <td><?= $product->Barcode ?></td>
                                <td><?= $product->Naam ?></td>
                                <td><?= $product->Verpakkingseenheid ?></td>
                                <td><?= $product->AantalAanwezig ?></td>
                                <td class='text-center'>
                                    <!-- Link naar allergeneninformatie -->
                                    <a href='<?= URLROOT . "/Magazijn/allergenenInfo/$product->ProductId" ?>' class='text-danger'>
                                        <i class='bi bi-x-lg redcross'></i>
                                    </a>
                                </td>
                                <td class='text-center'>
                                    <!-- Link naar leveringsinformatie -->
                                    <a href='<?= URLROOT . "/Magazijn/leveringInfo/$product->ProductId" ?>'>
                                        <i class='bi bi-question-lg darkbluequestionmark'></i>
                                    </a>
                                </td>            
                            </tr>
                        <?php } 
                    } ?>
                </tbody>
            </table>
            <a href="<?= URLROOT; ?>/homepages/index">Homepage</a>
        </div>
        <div class="col-2"></div>
    </div>
</div>

<?php require_once APPROOT . '/views/includes/footer.php'; ?>