<?php require_once APPROOT . '/views/includes/header.php'; ?>

<div class="container">
    <div class="row mt-3 align-items-center">
        <div class="col-md-4">
            <h3>Overzicht Geleverde Producten</h3>
        </div>
        <div class="col-md-8 text-right">
            <form action="<?= URLROOT; ?>/geleverdeproducten/index" method="post" class="form-inline justify-content-end">
                <div class="form-group mr-2">
                    <label for="startdatum" class="mr-2">Startdatum:</label>
                    <input type="date" id="startdatum" name="startdatum" class="form-control" required>
                </div>
                <div class="form-group mr-2">
                    <label for="einddatum" class="mr-2">Einddatum:</label>
                    <input type="date" id="einddatum" name="einddatum" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-primary">Maak selectie</button>
            </form>
        </div>
    </div>

    <?php if (!empty($data['producten'])): ?>
        <div class="row mt-3">
            <div class="col-12">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Leverancier</th>
                            <th>Contactpersoon</th>
                            <th>Productnaam</th>
                            <th>Totaal Geleverd</th>
                            <th>Specificatie</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($data['producten'] as $product): ?>
                            <tr>
                                <td><?= $product->LeverancierNaam; ?></td>
                                <td><?= $product->Contactpersoon; ?></td>
                                <td><?= $product->ProductNaam; ?></td>
                                <td><?= $product->TotaalGeleverd; ?></td>
                                <td><a href="<?= URLROOT; ?>/productspecificatie/index/<?= $product->ProductId; ?>"><img src="<?= URLROOT; ?>/img/questionmark.png" alt="Info" style="width: 20px; height: 20px;"></a></td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        </div>
    <?php else: ?>
        <div class="row mt-3">
            <div class="col-12">
                <p>Er zijn geen geleverde producten gevonden.</p>
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
