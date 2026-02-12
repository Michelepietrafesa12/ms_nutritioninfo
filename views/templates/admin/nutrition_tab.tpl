
{**
 * Template back-office: form per i valori nutrizionali nel product editor.
 * @author Michele Pietrafesa
 *}

<div id="ms-nutrition-panel" class="product-tab-content">
    <div class="panel">
        <h3><i class="icon-heartbeat"></i> {l s='Valori Nutrizionali' mod='ms_nutritioninfo'}</h3>

        {* === Sezione 1: Informazioni generali === *}
        <div class="ms-nutrition-section">
            <h4>{l s='Informazioni generali' mod='ms_nutritioninfo'}</h4>

            <div class="form-group">
                <label class="control-label col-lg-3">
                    {l s='Attiva valori nutrizionali' mod='ms_nutritioninfo'}
                </label>
                <div class="col-lg-9">
                    <span class="switch prestashop-switch fixed-width-lg">
                        <input type="radio" name="nutrition_active" id="nutrition_active_on" value="1"
                            {if $nutrition && $nutrition->active}checked="checked"{/if} />
                        <label for="nutrition_active_on">{l s='Sì' mod='ms_nutritioninfo'}</label>
                        <input type="radio" name="nutrition_active" id="nutrition_active_off" value="0"
                            {if !$nutrition || !$nutrition->active}checked="checked"{/if} />
                        <label for="nutrition_active_off">{l s='No' mod='ms_nutritioninfo'}</label>
                        <a class="slide-button btn"></a>
                    </span>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-lg-3" for="nutrition_porzione">
                    {l s='Porzione di riferimento (dose)' mod='ms_nutritioninfo'}
                </label>
                <div class="col-lg-4">
                    <input type="text" name="nutrition_porzione" id="nutrition_porzione"
                        class="form-control"
                        value="{if $nutrition}{$nutrition->porzione|escape:'htmlall':'UTF-8'}{else}100g{/if}"
                        placeholder="{l s='es: 100g, 1 porzione (30g)' mod='ms_nutritioninfo'}" />
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-lg-3">
                    {l s='Mostra colonna per porzione' mod='ms_nutritioninfo'}
                </label>
                <div class="col-lg-9">
                    <span class="switch prestashop-switch fixed-width-lg">
                        <input type="radio" name="nutrition_porzione_attiva" id="nutrition_porzione_attiva_on" value="1"
                            {if $nutrition && $nutrition->porzione_attiva}checked="checked"{/if} />
                        <label for="nutrition_porzione_attiva_on">{l s='Sì' mod='ms_nutritioninfo'}</label>
                        <input type="radio" name="nutrition_porzione_attiva" id="nutrition_porzione_attiva_off" value="0"
                            {if !$nutrition || !$nutrition->porzione_attiva}checked="checked"{/if} />
                        <label for="nutrition_porzione_attiva_off">{l s='No' mod='ms_nutritioninfo'}</label>
                        <a class="slide-button btn"></a>
                    </span>
                </div>
            </div>

            <div class="form-group" id="ms-porzione-descrizione-wrap" {if !$nutrition || !$nutrition->porzione_attiva}style="display:none"{/if}>
                <label class="control-label col-lg-3" for="nutrition_porzione_descrizione">
                    {l s='Descrizione porzione' mod='ms_nutritioninfo'}
                </label>
                <div class="col-lg-4">
                    <input type="text" name="nutrition_porzione_descrizione" id="nutrition_porzione_descrizione"
                        class="form-control"
                        value="{if $nutrition && $nutrition->porzione_descrizione}{$nutrition->porzione_descrizione|escape:'htmlall':'UTF-8'}{/if}"
                        placeholder="{l s='es: 27,5 g' mod='ms_nutritioninfo'}" />
                    <p class="help-block">{l s='Testo visualizzato nell\'intestazione della colonna per porzione.' mod='ms_nutritioninfo'}</p>
                </div>
            </div>
        </div>

        {* === Sezione 2: Valori nutrizionali principali === *}
        <div class="ms-nutrition-section">
            <h4>{l s='Valori nutrizionali principali' mod='ms_nutritioninfo'}</h4>

            {* Header colonne *}
            <div class="form-group ms-nutrition-columns-header">
                <label class="control-label col-lg-3"></label>
                <div class="col-lg-3 text-center"><strong>{l s='Per 100 g' mod='ms_nutritioninfo'}</strong></div>
                <div class="col-lg-3 text-center ms-porzione-col" {if !$nutrition || !$nutrition->porzione_attiva}style="display:none"{/if}>
                    <strong>{l s='Per porzione' mod='ms_nutritioninfo'}</strong>
                </div>
            </div>

            {* Energia kcal / kJ *}
            <div class="form-group">
                <label class="control-label col-lg-3">
                    {l s='Energia' mod='ms_nutritioninfo'}
                </label>
                <div class="col-lg-9">
                    <div class="row">
                        <div class="col-sm-3">
                            <div class="input-group">
                                <input type="number" step="0.01" min="0" name="nutrition_energia_kcal"
                                    id="nutrition_energia_kcal" class="form-control"
                                    value="{if $nutrition && $nutrition->energia_kcal !== null}{$nutrition->energia_kcal|escape:'htmlall':'UTF-8'}{/if}"
                                    placeholder="kcal" />
                                <span class="input-group-addon">kcal</span>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="input-group">
                                <input type="number" step="0.01" min="0" name="nutrition_energia_kj"
                                    id="nutrition_energia_kj" class="form-control"
                                    value="{if $nutrition && $nutrition->energia_kj !== null}{$nutrition->energia_kj|escape:'htmlall':'UTF-8'}{/if}"
                                    placeholder="kJ" />
                                <span class="input-group-addon">kJ</span>
                            </div>
                        </div>
                        <div class="col-sm-3 ms-porzione-col" {if !$nutrition || !$nutrition->porzione_attiva}style="display:none"{/if}>
                            <div class="input-group">
                                <input type="number" step="0.01" min="0" name="nutrition_energia_kcal_porzione"
                                    class="form-control"
                                    value="{if $nutrition && $nutrition->energia_kcal_porzione !== null}{$nutrition->energia_kcal_porzione|escape:'htmlall':'UTF-8'}{/if}"
                                    placeholder="kcal" />
                                <span class="input-group-addon">kcal</span>
                            </div>
                        </div>
                        <div class="col-sm-3 ms-porzione-col" {if !$nutrition || !$nutrition->porzione_attiva}style="display:none"{/if}>
                            <div class="input-group">
                                <input type="number" step="0.01" min="0" name="nutrition_energia_kj_porzione"
                                    class="form-control"
                                    value="{if $nutrition && $nutrition->energia_kj_porzione !== null}{$nutrition->energia_kj_porzione|escape:'htmlall':'UTF-8'}{/if}"
                                    placeholder="kJ" />
                                <span class="input-group-addon">kJ</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            {* Macro helper: campo numerico con colonna porzione *}
            {assign var='macro_fields' value=[
                ['name' => 'grassi', 'label' => {l s='Grassi' mod='ms_nutritioninfo'}, 'sub' => false, 'optional' => false],
                ['name' => 'grassi_saturi', 'label' => {l s='di cui acidi grassi saturi' mod='ms_nutritioninfo'}, 'sub' => true, 'optional' => false],
                ['name' => 'grassi_monoinsaturi', 'label' => {l s='di cui acidi grassi monoinsaturi' mod='ms_nutritioninfo'}, 'sub' => true, 'optional' => true],
                ['name' => 'grassi_polinsaturi', 'label' => {l s='di cui acidi grassi polinsaturi' mod='ms_nutritioninfo'}, 'sub' => true, 'optional' => true],
                ['name' => 'carboidrati', 'label' => {l s='Carboidrati' mod='ms_nutritioninfo'}, 'sub' => false, 'optional' => false],
                ['name' => 'zuccheri', 'label' => {l s='di cui zuccheri' mod='ms_nutritioninfo'}, 'sub' => true, 'optional' => false],
                ['name' => 'polialcoli', 'label' => {l s='di cui polialcoli' mod='ms_nutritioninfo'}, 'sub' => true, 'optional' => true],
                ['name' => 'amido', 'label' => {l s='di cui amido' mod='ms_nutritioninfo'}, 'sub' => true, 'optional' => true],
                ['name' => 'fibre', 'label' => {l s='Fibre' mod='ms_nutritioninfo'}, 'sub' => false, 'optional' => false],
                ['name' => 'proteine', 'label' => {l s='Proteine' mod='ms_nutritioninfo'}, 'sub' => false, 'optional' => false],
                ['name' => 'sale', 'label' => {l s='Sale' mod='ms_nutritioninfo'}, 'sub' => false, 'optional' => false]
            ]}

            {foreach $macro_fields as $mf}
                <div class="form-group {if $mf.sub}ms-nutrition-sub{/if} {if $mf.optional}ms-nutrition-optional{/if}">
                    <label class="control-label col-lg-3">
                        {$mf.label}
                        {if $mf.optional}<span class="ms-optional-badge">{l s='opzionale' mod='ms_nutritioninfo'}</span>{/if}
                    </label>
                    <div class="col-lg-3">
                        <div class="input-group">
                            <input type="number" step="0.01" min="0" name="nutrition_{$mf.name}"
                                class="form-control"
                                value="{if $nutrition && $nutrition->{$mf.name} !== null}{$nutrition->{$mf.name}|escape:'htmlall':'UTF-8'}{/if}" />
                            <span class="input-group-addon">g</span>
                        </div>
                    </div>
                    <div class="col-lg-3 ms-porzione-col" {if !$nutrition || !$nutrition->porzione_attiva}style="display:none"{/if}>
                        <div class="input-group">
                            <input type="number" step="0.01" min="0" name="nutrition_{$mf.name}_porzione"
                                class="form-control"
                                value="{if $nutrition && $nutrition->{$mf.name|cat:'_porzione'} !== null}{$nutrition->{$mf.name|cat:'_porzione'}|escape:'htmlall':'UTF-8'}{/if}" />
                            <span class="input-group-addon">g</span>
                        </div>
                    </div>
                </div>
            {/foreach}
        </div>

        {* === Sezione 3: Vitamine e Minerali === *}
        <div class="ms-nutrition-section">
            <h4>{l s='Vitamine e Minerali' mod='ms_nutritioninfo'}</h4>

            <div id="ms-vitamine-container">
                {if $vitamine_minerali && count($vitamine_minerali) > 0}
                    {foreach $vitamine_minerali as $index => $vit}
                        <div class="ms-vitamina-row form-group">
                            <div class="col-lg-3">
                                <input type="text" name="nutrition_vit_nome[]"
                                    class="form-control"
                                    value="{$vit.nome|escape:'htmlall':'UTF-8'}"
                                    placeholder="{l s='Nome (es: Vitamina C)' mod='ms_nutritioninfo'}" />
                            </div>
                            <div class="col-lg-2">
                                <input type="number" step="0.01" min="0" name="nutrition_vit_quantita[]"
                                    class="form-control"
                                    value="{$vit.quantita|escape:'htmlall':'UTF-8'}"
                                    placeholder="{l s='Quantità' mod='ms_nutritioninfo'}" />
                            </div>
                            <div class="col-lg-2">
                                <select name="nutrition_vit_unita[]" class="form-control">
                                    <option value="mg" {if $vit.unita == 'mg'}selected{/if}>mg</option>
                                    <option value="µg" {if $vit.unita == 'µg'}selected{/if}>µg</option>
                                    <option value="g" {if $vit.unita == 'g'}selected{/if}>g</option>
                                </select>
                            </div>
                            <div class="col-lg-2">
                                <div class="input-group">
                                    <input type="number" step="0.01" min="0" name="nutrition_vit_vnr[]"
                                        class="form-control"
                                        value="{$vit.vnr|escape:'htmlall':'UTF-8'}"
                                        placeholder="{l s='%VNR' mod='ms_nutritioninfo'}" />
                                    <span class="input-group-addon">%</span>
                                </div>
                            </div>
                            <div class="col-lg-1">
                                <button type="button" class="btn btn-danger ms-remove-vitamina" title="{l s='Rimuovi' mod='ms_nutritioninfo'}">
                                    <i class="icon-trash"></i>
                                </button>
                            </div>
                        </div>
                    {/foreach}
                {/if}
            </div>

            <div class="form-group">
                <div class="col-lg-offset-0 col-lg-12">
                    <button type="button" id="ms-add-vitamina" class="btn btn-default"
                        data-placeholder-nome="{l s='Nome (es: Vitamina C)' mod='ms_nutritioninfo'}"
                        data-placeholder-quantita="{l s='Quantità' mod='ms_nutritioninfo'}"
                        data-placeholder-vnr="{l s='%VNR' mod='ms_nutritioninfo'}"
                        data-title-rimuovi="{l s='Rimuovi' mod='ms_nutritioninfo'}">
                        <i class="icon-plus"></i> {l s='Aggiungi vitamina/minerale' mod='ms_nutritioninfo'}
                    </button>
                </div>
            </div>
        </div>

        {* === Sezione 3b: Acidi Aminici === *}
        <div class="ms-nutrition-section">
            <h4>{l s='Acidi Aminici' mod='ms_nutritioninfo'}</h4>

            <div id="ms-aminoacidi-container">
                {if $acidi_aminici && count($acidi_aminici) > 0}
                    {foreach $acidi_aminici as $index => $aa}
                        <div class="ms-aminoacido-row form-group">
                            <div class="col-lg-4">
                                <input type="text" name="nutrition_aa_nome[]"
                                    class="form-control"
                                    value="{$aa.nome|escape:'htmlall':'UTF-8'}"
                                    placeholder="{l s='Nome (es: L-Leucina)' mod='ms_nutritioninfo'}" />
                            </div>
                            <div class="col-lg-3">
                                <input type="number" step="0.01" min="0" name="nutrition_aa_quantita[]"
                                    class="form-control"
                                    value="{$aa.quantita|escape:'htmlall':'UTF-8'}"
                                    placeholder="{l s='Quantità' mod='ms_nutritioninfo'}" />
                            </div>
                            <div class="col-lg-2">
                                <select name="nutrition_aa_unita[]" class="form-control">
                                    <option value="g" {if $aa.unita == 'g'}selected{/if}>g</option>
                                    <option value="mg" {if $aa.unita == 'mg'}selected{/if}>mg</option>
                                </select>
                            </div>
                            <div class="col-lg-1">
                                <button type="button" class="btn btn-danger ms-remove-aminoacido" title="{l s='Rimuovi' mod='ms_nutritioninfo'}">
                                    <i class="icon-trash"></i>
                                </button>
                            </div>
                        </div>
                    {/foreach}
                {/if}
            </div>

            <div class="form-group">
                <div class="col-lg-offset-0 col-lg-12">
                    <button type="button" id="ms-add-aminoacido" class="btn btn-default"
                        data-placeholder-nome="{l s='Nome (es: L-Leucina)' mod='ms_nutritioninfo'}"
                        data-placeholder-quantita="{l s='Quantità' mod='ms_nutritioninfo'}"
                        data-title-rimuovi="{l s='Rimuovi' mod='ms_nutritioninfo'}">
                        <i class="icon-plus"></i> {l s='Aggiungi acido aminico' mod='ms_nutritioninfo'}
                    </button>
                </div>
            </div>
        </div>

        {* === Sezione 4: Ingredienti e Allergeni === *}
        <div class="ms-nutrition-section">
            <h4>{l s='Ingredienti e Allergeni' mod='ms_nutritioninfo'}</h4>

            <div class="form-group">
                <label class="control-label col-lg-3" for="nutrition_ingredienti">
                    {l s='Ingredienti' mod='ms_nutritioninfo'}
                </label>
                <div class="col-lg-9">
                    <textarea name="nutrition_ingredienti" id="nutrition_ingredienti"
                        class="form-control ms-nutrition-textarea autoload_rte"
                        rows="4">{if $nutrition}{$nutrition->ingredienti nofilter}{/if}</textarea>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-lg-3" for="nutrition_allergeni">
                    {l s='Allergeni' mod='ms_nutritioninfo'}
                </label>
                <div class="col-lg-9">
                    <textarea name="nutrition_allergeni" id="nutrition_allergeni"
                        class="form-control ms-nutrition-textarea autoload_rte"
                        rows="3">{if $nutrition}{$nutrition->allergeni nofilter}{/if}</textarea>
                    <p class="help-block">
                        {l s='Usa il grassetto per evidenziare gli allergeni come da normativa EU.' mod='ms_nutritioninfo'}
                    </p>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-lg-3" for="nutrition_note">
                    {l s='Note aggiuntive' mod='ms_nutritioninfo'}
                </label>
                <div class="col-lg-9">
                    <textarea name="nutrition_note" id="nutrition_note"
                        class="form-control"
                        rows="3">{if $nutrition}{$nutrition->note|escape:'htmlall':'UTF-8'}{/if}</textarea>
                </div>
            </div>
        </div>

    </div>
</div>
