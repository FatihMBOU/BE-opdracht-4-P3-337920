<?php require_once APPROOT . '/views/includes/header.php'; ?>

<!-- Voor het centreren van de container gebruiken we het bootstrap grid -->
<div class="container">
    <div class="row mt-3">
        <div class="col-2"></div>
        <div class="col-8">
            <h3><?php echo $data['title']; ?></h3>

            <!-- Links naar verschillende pagina's -->
            <a href="<?= URLROOT; ?>/magazijn/index">Overzicht magazijn Jamin</a> |
            <a href="<?= URLROOT; ?>/leverancier/index">Overzicht leveranciers</a> |
            <a href="<?= URLROOT; ?>/leverancier/wijzigenLeverancier">Wijzigen Leverancier</a>

        </div>
        <div class="col-2"></div>
    </div>
</div>

<?php require_once APPROOT . '/views/includes/footer.php'; ?>