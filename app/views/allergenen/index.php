<?php require_once APPROOT . '/views/includes/header.php'; ?>

<div class="container">
    <div class="row mt-3">
        <div class="col-12">
            <h3><?= $data['title']; ?></h3>
        </div>
    </div>

    <?php if ($data['message']) : ?>
        <div class="alert alert-danger" role="alert">
            <?= $data['message']; ?>
        </div>
    <?php endif; ?>

    <div class="row mt-3">
        <div class="col-12">
            <form action="<?= URLROOT; ?>/allergeen/index" method="post" class="form-inline">
                <div class="form-group mr-2">
                    <label for="allergeen" class="mr-2">Allergeen:</label>
                    <select name="allergeen" class="form-control">
                        <?php foreach ($data['allergenen'] as $allergeen): ?>
                            <option value="<?= $allergeen->Id; ?>" <?= $data['selectedAllergeen'] == $allergeen->Naam ? 'selected' : ''; ?>><?= $allergeen->Naam; ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <input type="submit" class="btn btn-primary" value="Maak selectie">
                </div>
            </form>
        </div>
    </div>

    <?php if (!empty($data['producten'])): ?>
        <div class="row mt-3">
            <div class="col-12">
                <h5>Producten met geselecteerde allergeen: <?= $data['selectedAllergeen']; ?></h5>
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Naam product</th>
                            <th>Naam allergeen</th>
                            <th>Omschrijving</th>
                            <th>Aantal aanwezig</th>
                            <th>Info</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($data['producten'] as $product): ?>
                            <tr>
                                <td><?= $product->productNaam; ?></td>
                                <td><?= $product->allergeenNaam; ?></td>
                                <td><?= $product->Omschrijving; ?></td>
                                <td><?= $product->AantalAanwezig; ?></td>
                                <td><a href="<?= URLROOT; ?>/leverancier/overzicht/<?= $product->productId; ?>"><button>?</button></a></td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        </div>
    <?php endif; ?>

    <div class="row mt-3">
        <div class="col-12">
            <a href="<?= URLROOT; ?>" class="btn btn-secondary">Terug naar homepage</a>
        </div>
    </div>
</div>

<?php require_once APPROOT . '/views/includes/footer.php'; ?>
