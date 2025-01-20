<?php require_once APPROOT . '/views/includes/header.php'; ?>

<div class="container">
    <div class="row mt-3">
        <div class="col-12">
            <h3>Wijzig Leverancier</h3>
            <?php if (!empty($data['message'])): ?>
                <div class="alert alert-danger">
                    <?= $data['message']; ?>
                </div>
            <?php endif; ?>
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>Naam</th>
                        <th>Contactpersoon</th>
                        <th>Leveranciernummer</th>
                        <th>Mobiel</th>
                        <th>Acties</th>
                    </tr>
                </thead>
                <tbody>
                    <?php if (is_null($data['leveranciers'])): ?>
                        <tr>
                            <td colspan='6' class='text-center'>Geen leveranciers beschikbaar</td>
                        </tr>
                    <?php else: ?>
                        <?php foreach ($data['leveranciers'] as $leverancier): ?>
                            <tr>
                                <td><?= $leverancier->naam ?></td>
                                <td><?= $leverancier->contactpersoon ?></td>
                                <td><?= $leverancier->leveranciernummer ?></td>
                                <td><?= $leverancier->mobiel ?></td>
                                <td>
                                    <a href="<?= URLROOT; ?>/leverancier/wijzigLeverancier/<?= $leverancier->id ?>" class="btn btn-warning">
                                        <i class="fas fa-pencil-alt"></i> <!-- Potloodicoon -->
                                    </a>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    <?php endif; ?>
                </tbody>
            </table>
            <!-- Paginering -->
            <div class="d-flex justify-content-between">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <?php if ($data['currentPage'] > 1): ?>
                            <li class="page-item">
                                <a class="page-link" href="<?= URLROOT; ?>/leverancier/wijzigenLeverancier/<?= $data['currentPage'] - 1 ?>" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        <?php endif; ?>
                        <?php for ($i = 1; $i <= $data['totalPages']; $i++): ?>
                            <li class="page-item <?= ($i == $data['currentPage']) ? 'active' : ''; ?>">
                                <a class="page-link" href="<?= URLROOT; ?>/leverancier/wijzigenLeverancier/<?= $i ?>"><?= $i ?></a>
                            </li>
                        <?php endfor; ?>
                        <?php if ($data['currentPage'] < $data['totalPages']): ?>
                            <li class="page-item">
                                <a class="page-link" href="<?= URLROOT; ?>/leverancier/wijzigenLeverancier/<?= $data['currentPage'] + 1 ?>" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        <?php endif; ?>
                    </ul>
                </nav>
                <a href="<?= URLROOT; ?>" class="btn btn-primary">Home</a>
            </div>
        </div>
    </div>
</div>

<?php require_once APPROOT . '/views/includes/footer.php'; ?>