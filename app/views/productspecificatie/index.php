<?php require_once APPROOT . '/views/includes/header.php'; ?>

<div class="container">
    <div class="row mt-3">
        <div class="col-12">
            <h3>Specificatie Geleverde Producten</h3>
        </div>
    </div>

    <form action="<?= URLROOT; ?>/productspecificatie/index/<?= $data['specificaties'][0]->ProductId; ?>" method="post">
        <div class="row mt-3">
            <div class="col-6">
                <label for="startdatum">Startdatum:</label>
                <input type="date" id="startdatum" name="startdatum" class="form-control" required>
            </div>
            <div class="col-6">
                <label for="einddatum">Einddatum:</label>
                <input type="date" id="einddatum" name="einddatum" class="form-control" required>
            </div>
        </div>
        <div class="row mt-3">
            <div class="col-12 text-right">
                <button type="submit" class="btn btn-primary">Maak selectie</button>
            </div>
        </div>
    </form>

    <?php if (!empty($data['specificaties'])): ?>
        <div class="row mt-3">
            <div class="col-12">
                <h5>Allergenen:</h5>
                <p>
                    <?php 
                    $allergenen = array_unique(array_map(function($specificatie) {
                        return $specificatie->AllergeenNaam;
                    }, $data['specificaties']));
                    echo implode(', ', $allergenen);
                    ?>
                </p>
            </div>
        </div>
        <div class="row mt-3">
            <div class="col-12">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Productnaam</th>
                            <th>Datum Levering</th>
                            <th>Aantal</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($data['specificaties'] as $specificatie): ?>
                            <tr>
                                <td><?= $specificatie->ProductNaam; ?></td>
                                <td><?= $specificatie->DatumLevering; ?></td>
                                <td><?= $specificatie->Aantal; ?></td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        </div>
    <?php else: ?>
        <div class="row mt-3">
            <div class="col-12">
                <p>Er zijn geen specificaties gevonden voor dit product.</p>
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
