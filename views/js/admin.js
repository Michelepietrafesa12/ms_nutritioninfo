/**
 * JavaScript back-office per il modulo ms_nutritioninfo.
 * Gestione dinamica delle vitamine/minerali e conversione kcal/kJ.
 */

document.addEventListener('DOMContentLoaded', function () {

    /* =========================================================================
     * Gestione dinamica righe vitamine/minerali
     * ========================================================================= */

    var container = document.getElementById('ms-vitamine-container');
    var addBtn = document.getElementById('ms-add-vitamina');

    // Stringhe traducibili lette dai data-attributes del pulsante
    var translations = {
        placeholderNome: 'Nome (es: Vitamina C)',
        placeholderQuantita: 'Quantità',
        placeholderVnr: '%VNR',
        titleRimuovi: 'Rimuovi'
    };

    if (addBtn) {
        translations.placeholderNome = addBtn.getAttribute('data-placeholder-nome') || translations.placeholderNome;
        translations.placeholderQuantita = addBtn.getAttribute('data-placeholder-quantita') || translations.placeholderQuantita;
        translations.placeholderVnr = addBtn.getAttribute('data-placeholder-vnr') || translations.placeholderVnr;
        translations.titleRimuovi = addBtn.getAttribute('data-title-rimuovi') || translations.titleRimuovi;

        addBtn.addEventListener('click', function () {
            addVitaminaRow('', '', 'mg', '');
        });
    }

    /**
     * Aggiunge una nuova riga per vitamina/minerale.
     */
    function addVitaminaRow(nome, quantita, unita, vnr) {
        if (!container) {
            return;
        }

        var row = document.createElement('div');
        row.className = 'ms-vitamina-row form-group';

        row.innerHTML =
            '<div class="col-lg-3">' +
                '<input type="text" name="nutrition_vit_nome[]" class="form-control" ' +
                    'value="' + escapeHtml(nome) + '" placeholder="' + escapeHtml(translations.placeholderNome) + '" />' +
            '</div>' +
            '<div class="col-lg-2">' +
                '<input type="number" step="0.01" min="0" name="nutrition_vit_quantita[]" class="form-control" ' +
                    'value="' + escapeHtml(quantita) + '" placeholder="' + escapeHtml(translations.placeholderQuantita) + '" />' +
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
                        'value="' + escapeHtml(vnr) + '" placeholder="' + escapeHtml(translations.placeholderVnr) + '" />' +
                    '<span class="input-group-addon">%</span>' +
                '</div>' +
            '</div>' +
            '<div class="col-lg-1">' +
                '<button type="button" class="btn btn-danger ms-remove-vitamina" title="' + escapeHtml(translations.titleRimuovi) + '">' +
                    '<i class="icon-trash"></i>' +
                '</button>' +
            '</div>';

        container.appendChild(row);
    }

    /**
     * Event delegation per rimuovere righe vitamine.
     */
    if (container) {
        container.addEventListener('click', function (e) {
            var btn = e.target.closest('.ms-remove-vitamina');
            if (btn) {
                var row = btn.closest('.ms-vitamina-row');
                if (row) {
                    row.parentNode.removeChild(row);
                }
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

    /**
     * Escape HTML per prevenire XSS nell'inserimento dinamico.
     */
    function escapeHtml(str) {
        if (!str) return '';
        var div = document.createElement('div');
        div.appendChild(document.createTextNode(str));
        return div.innerHTML;
    }
});
