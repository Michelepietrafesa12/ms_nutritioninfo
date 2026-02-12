/**
 * JavaScript back-office per il modulo ms_nutritioninfo.
 * Gestione dinamica vitamine/minerali, acidi aminici,
 * conversione kcal/kJ e toggle colonna porzione.
 */

document.addEventListener('DOMContentLoaded', function () {

    /* =========================================================================
     * Toggle colonna porzione
     * ========================================================================= */

    var porzAttivaOn = document.getElementById('nutrition_porzione_attiva_on');
    var porzAttivaOff = document.getElementById('nutrition_porzione_attiva_off');
    var porzDescWrap = document.getElementById('ms-porzione-descrizione-wrap');
    var porzCols = document.querySelectorAll('.ms-porzione-col');

    function togglePorzioneCols(show) {
        var display = show ? '' : 'none';
        if (porzDescWrap) {
            porzDescWrap.style.display = display;
        }
        for (var i = 0; i < porzCols.length; i++) {
            porzCols[i].style.display = display;
        }
    }

    if (porzAttivaOn) {
        porzAttivaOn.addEventListener('change', function () {
            if (this.checked) togglePorzioneCols(true);
        });
    }
    if (porzAttivaOff) {
        porzAttivaOff.addEventListener('change', function () {
            if (this.checked) togglePorzioneCols(false);
        });
    }

    /* =========================================================================
     * Gestione dinamica righe vitamine/minerali
     * ========================================================================= */

    var vitContainer = document.getElementById('ms-vitamine-container');
    var addVitBtn = document.getElementById('ms-add-vitamina');

    var vitTranslations = {
        placeholderNome: 'Nome (es: Vitamina C)',
        placeholderQuantita: 'Quantità',
        placeholderVnr: '%VNR',
        titleRimuovi: 'Rimuovi'
    };

    if (addVitBtn) {
        vitTranslations.placeholderNome = addVitBtn.getAttribute('data-placeholder-nome') || vitTranslations.placeholderNome;
        vitTranslations.placeholderQuantita = addVitBtn.getAttribute('data-placeholder-quantita') || vitTranslations.placeholderQuantita;
        vitTranslations.placeholderVnr = addVitBtn.getAttribute('data-placeholder-vnr') || vitTranslations.placeholderVnr;
        vitTranslations.titleRimuovi = addVitBtn.getAttribute('data-title-rimuovi') || vitTranslations.titleRimuovi;

        addVitBtn.addEventListener('click', function () {
            addVitaminaRow('', '', 'mg', '');
        });
    }

    function addVitaminaRow(nome, quantita, unita, vnr) {
        if (!vitContainer) return;

        var row = document.createElement('div');
        row.className = 'ms-vitamina-row form-group';

        row.innerHTML =
            '<div class="col-lg-3">' +
                '<input type="text" name="nutrition_vit_nome[]" class="form-control" ' +
                    'value="' + escapeHtml(nome) + '" placeholder="' + escapeHtml(vitTranslations.placeholderNome) + '" />' +
            '</div>' +
            '<div class="col-lg-2">' +
                '<input type="number" step="0.01" min="0" name="nutrition_vit_quantita[]" class="form-control" ' +
                    'value="' + escapeHtml(quantita) + '" placeholder="' + escapeHtml(vitTranslations.placeholderQuantita) + '" />' +
            '</div>' +
            '<div class="col-lg-2">' +
                '<select name="nutrition_vit_unita[]" class="form-control">' +
                    '<option value="mg"' + (unita === 'mg' ? ' selected' : '') + '>mg</option>' +
                    '<option value="µg"' + (unita === 'µg' ? ' selected' : '') + '>µg</option>' +
                    '<option value="g"' + (unita === 'g' ? ' selected' : '') + '>g</option>' +
                '</select>' +
            '</div>' +
            '<div class="col-lg-2">' +
                '<div class="input-group">' +
                    '<input type="number" step="0.01" min="0" name="nutrition_vit_vnr[]" class="form-control" ' +
                        'value="' + escapeHtml(vnr) + '" placeholder="' + escapeHtml(vitTranslations.placeholderVnr) + '" />' +
                    '<span class="input-group-addon">%</span>' +
                '</div>' +
            '</div>' +
            '<div class="col-lg-1">' +
                '<button type="button" class="btn btn-danger ms-remove-vitamina" title="' + escapeHtml(vitTranslations.titleRimuovi) + '">' +
                    '<i class="icon-trash"></i>' +
                '</button>' +
            '</div>';

        vitContainer.appendChild(row);
    }

    if (vitContainer) {
        vitContainer.addEventListener('click', function (e) {
            var btn = e.target.closest('.ms-remove-vitamina');
            if (btn) {
                var row = btn.closest('.ms-vitamina-row');
                if (row) row.parentNode.removeChild(row);
            }
        });
    }

    /* =========================================================================
     * Gestione dinamica righe acidi aminici
     * ========================================================================= */

    var aaContainer = document.getElementById('ms-aminoacidi-container');
    var addAaBtn = document.getElementById('ms-add-aminoacido');

    var aaTranslations = {
        placeholderNome: 'Nome (es: L-Leucina)',
        placeholderQuantita: 'Quantità',
        titleRimuovi: 'Rimuovi'
    };

    if (addAaBtn) {
        aaTranslations.placeholderNome = addAaBtn.getAttribute('data-placeholder-nome') || aaTranslations.placeholderNome;
        aaTranslations.placeholderQuantita = addAaBtn.getAttribute('data-placeholder-quantita') || aaTranslations.placeholderQuantita;
        aaTranslations.titleRimuovi = addAaBtn.getAttribute('data-title-rimuovi') || aaTranslations.titleRimuovi;

        addAaBtn.addEventListener('click', function () {
            addAminoacidoRow('', '', 'g');
        });
    }

    function addAminoacidoRow(nome, quantita, unita) {
        if (!aaContainer) return;

        var row = document.createElement('div');
        row.className = 'ms-aminoacido-row form-group';

        row.innerHTML =
            '<div class="col-lg-4">' +
                '<input type="text" name="nutrition_aa_nome[]" class="form-control" ' +
                    'value="' + escapeHtml(nome) + '" placeholder="' + escapeHtml(aaTranslations.placeholderNome) + '" />' +
            '</div>' +
            '<div class="col-lg-3">' +
                '<input type="number" step="0.01" min="0" name="nutrition_aa_quantita[]" class="form-control" ' +
                    'value="' + escapeHtml(quantita) + '" placeholder="' + escapeHtml(aaTranslations.placeholderQuantita) + '" />' +
            '</div>' +
            '<div class="col-lg-2">' +
                '<select name="nutrition_aa_unita[]" class="form-control">' +
                    '<option value="g"' + (unita === 'g' ? ' selected' : '') + '>g</option>' +
                    '<option value="mg"' + (unita === 'mg' ? ' selected' : '') + '>mg</option>' +
                '</select>' +
            '</div>' +
            '<div class="col-lg-1">' +
                '<button type="button" class="btn btn-danger ms-remove-aminoacido" title="' + escapeHtml(aaTranslations.titleRimuovi) + '">' +
                    '<i class="icon-trash"></i>' +
                '</button>' +
            '</div>';

        aaContainer.appendChild(row);
    }

    if (aaContainer) {
        aaContainer.addEventListener('click', function (e) {
            var btn = e.target.closest('.ms-remove-aminoacido');
            if (btn) {
                var row = btn.closest('.ms-aminoacido-row');
                if (row) row.parentNode.removeChild(row);
            }
        });
    }

    /* =========================================================================
     * Conversione automatica kcal <-> kJ
     * 1 kcal = 4.184 kJ
     * ========================================================================= */

    var kcalInput = document.getElementById('nutrition_energia_kcal');
    var kjInput = document.getElementById('nutrition_energia_kj');
    var converting = false;

    if (kcalInput && kjInput) {
        kcalInput.addEventListener('input', function () {
            if (converting) return;
            converting = true;

            var kcal = parseFloat(this.value);
            if (!isNaN(kcal) && kcal >= 0) {
                kjInput.value = (kcal * 4.184).toFixed(2);
            } else if (this.value === '') {
                kjInput.value = '';
            }

            converting = false;
        });

        kjInput.addEventListener('input', function () {
            if (converting) return;
            converting = true;

            var kj = parseFloat(this.value);
            if (!isNaN(kj) && kj >= 0) {
                kcalInput.value = (kj / 4.184).toFixed(2);
            } else if (this.value === '') {
                kcalInput.value = '';
            }

            converting = false;
        });
    }

    /* =========================================================================
     * Validazione lato client: no valori negativi
     * ========================================================================= */

    var nutritionPanel = document.getElementById('ms-nutrition-panel');

    if (nutritionPanel) {
        var numInputs = nutritionPanel.querySelectorAll('input[type="number"]');

        for (var i = 0; i < numInputs.length; i++) {
            numInputs[i].addEventListener('change', function () {
                var val = parseFloat(this.value);
                if (!isNaN(val) && val < 0) {
                    this.value = 0;
                }
            });
        }
    }

    /* =========================================================================
     * Utility
     * ========================================================================= */

    function escapeHtml(str) {
        if (!str) return '';
        var div = document.createElement('div');
        div.appendChild(document.createTextNode(str));
        return div.innerHTML;
    }
});
