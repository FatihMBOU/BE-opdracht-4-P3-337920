<?php require_once APPROOT . '/views/includes/header.php'; ?>
<style>
    .text-right {
    display: flex;
    justify-content: flex-end; /* Zorgt ervoor dat de inhoud naar rechts uitgelijnd wordt */
    gap: 10px; /* Ruimte tussen de knoppen */
}
</style>
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
                <!-- Tabel met leveranciers -->
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Naam</th>
                            <th>Contactpersoon</th>
                            <th>Leveranciernummer</th>
                            <th>Mobiel</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if (is_null($data['leveranciers'])) { ?>
                            <tr>
                                <td colspan='6' class='text-center'>Geen leveranciers beschikbaar</td>
                            </tr>
                        <?php } else {                              
                            foreach ($data['leveranciers'] as $leverancier) { ?>
                                <tr>
                                    <td><?= $leverancier->Naam ?></td>
                                    <td><?= $leverancier->Contactpersoon ?></td>
                                    <td><?= $leverancier->Leveranciernummer ?></td>
                                    <td><?= $leverancier->Mobiel ?></td>
                                    </td>            
                                </tr>
                            <?php } 
                        } ?>
                    </tbody>
                </table>
            </div>
        </div>
    <?php } ?>