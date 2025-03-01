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
            <form action="<?= URLROOT; ?>/allergeen/index" method="post">
                <div class="form-group">
                    <label for="allergeen">Selecteer een allergeen:</label>
                    <select name="allergeen" class="form-control">
                        <?php foreach ($data['allergenen'] as $allergeen): ?>
                            <option value="<?= $allergeen->naam; ?>"><?= $allergeen->naam; ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group mt-3">
                    <input type="submit" class="btn btn-primary" value="Maak selectie">
                </div>
            </form>
        </div>
    </div>

    <?php if (!empty($data['producten'])): ?>
        <div class="row mt-3">
            <div class="col-12">
                <h5>Producten met geselecteerde allergeen:</h5>
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Naam</th>
                            <th>Beschrijving</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($data['producten'] as $product): ?>
                            <tr>
                                <td><?= $product->naam; ?></td>
                                <td><?= $product->beschrijving; ?></td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        </div>
    <?php endif; ?>
</div>

<?php require_once APPROOT . '/views/includes/footer.php'; ?>