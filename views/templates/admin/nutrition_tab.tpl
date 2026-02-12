
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
                    {l s='Porzione di riferimento' mod='ms_nutritioninfo'}
                </label>
                <div class="col-lg-4">
                    <input type="text" name="nutrition_porzione" id="nutrition_porzione"
                        class="form-control"
                        value="{if $nutrition}{$nutrition->porzione|escape:'htmlall':'UTF-8'}{else}100g{/if}"
                        placeholder="{l s='es: 100g, 1 porzione (30g)' mod='ms_nutritioninfo'}" />
                </div>
            </div>
        </div>

        {* === Sezione 2: Valori nutrizionali principali === *}
        <div class="ms-nutrition-section">
            <h4>{l s='Valori nutrizionali principali' mod='ms_nutritioninfo'}</h4>

            {* Energia kcal / kJ *}
            <div class="form-group">
                <label class="control-label col-lg-3">
                    {l s='Energia' mod='ms_nutritioninfo'}
                </label>
                <div class="col-lg-9">
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="input-group">
                                <input type="number" step="0.01" min="0" name="nutrition_energia_kcal"
                                    id="nutrition_energia_kcal" class="form-control"
                                    value="{if $nutrition && $nutrition->energia_kcal !== null}{$nutrition->energia_kcal|escape:'htmlall':'UTF-8'}{/if}"
                                    placeholder="kcal" />
                                <span class="input-group-addon">kcal</span>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="input-group">
                                <input type="number" step="0.01" min="0" name="nutrition_energia_kj"
                                    id="nutrition_energia_kj" class="form-control"
                                    value="{if $nutrition && $nutrition->energia_kj !== null}{$nutrition->energia_kj|escape:'htmlall':'UTF-8'}{/if}"
                                    placeholder="kJ" />
                                <span class="input-group-addon">kJ</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            {* Grassi *}
            <div class="form-group">
                <label class="control-label col-lg-3">
                    {l s='Grassi' mod='ms_nutritioninfo'}
                </label>
                <div class="col-lg-3">
                    <div class="input-group">
                        <input type="number" step="0.01" min="0" name="nutrition_grassi"
                            class="form-control"
                            value="{if $nutrition && $nutrition->grassi !== null}{$nutrition->grassi|escape:'htmlall':'UTF-8'}{/if}" />
                        <span class="input-group-addon">g</span>
                    </div>
                </div>
            </div>

            <div class="form-group ms-nutrition-sub">
                <label class="control-label col-lg-3">
                    {l s='di cui acidi grassi saturi' mod='ms_nutritioninfo'}
                </label>
                <div class="col-lg-3">
                    <div class="input-group">
                        <input type="number" step="0.01" min="0" name="nutrition_grassi_saturi"
                            class="form-control"
                            value="{if $nutrition && $nutrition->grassi_saturi !== null}{$nutrition->grassi_saturi|escape:'htmlall':'UTF-8'}{/if}" />
                        <span class="input-group-addon">g</span>
                    </div>
                </div>
            </div>

            <div class="form-group ms-nutrition-sub ms-nutrition-optional">
                <label class="control-label col-lg-3">
                    {l s='di cui acidi grassi monoinsaturi' mod='ms_nutritioninfo'}
                    <span class="ms-optional-badge">{l s='opzionale' mod='ms_nutritioninfo'}</span>
                </label>
                <div class="col-lg-3">
                    <div class="input-group">
                        <input type="number" step="0.01" min="0" name="nutrition_grassi_monoinsaturi"
                            class="form-control"
                            value="{if $nutrition && $nutrition->grassi_monoinsaturi !== null}{$nutrition->grassi_monoinsaturi|escape:'htmlall':'UTF-8'}{/if}" />
                        <span class="input-group-addon">g</span>
                    </div>
                </div>
            </div>

            <div class="form-group ms-nutrition-sub ms-nutrition-optional">
                <label class="control-label col-lg-3">
                    {l s='di cui acidi grassi polinsaturi' mod='ms_nutritioninfo'}
                    <span class="ms-optional-badge">{l s='opzionale' mod='ms_nutritioninfo'}</span>
                </label>
                <div class="col-lg-3">
                    <div class="input-group">
                        <input type="number" step="0.01" min="0" name="nutrition_grassi_polinsaturi"
                            class="form-control"
                            value="{if $nutrition && $nutrition->grassi_polinsaturi !== null}{$nutrition->grassi_polinsaturi|escape:'htmlall':'UTF-8'}{/if}" />
                        <span class="input-group-addon">g</span>
                    </div>
                </div>
            </div>

            {* Carboidrati *}
            <div class="form-group">
                <label class="control-label col-lg-3">
                    {l s='Carboidrati' mod='ms_nutritioninfo'}
                </label>
                <div class="col-lg-3">
                    <div class="input-group">
                        <input type="number" step="0.01" min="0" name="nutrition_carboidrati"
                            class="form-control"
                            value="{if $nutrition && $nutrition->carboidrati !== null}{$nutrition->carboidrati|escape:'htmlall':'UTF-8'}{/if}" />
                        <span class="input-group-addon">g</span>
                    </div>
                </div>
            </div>

            <div class="form-group ms-nutrition-sub">
                <label class="control-label col-lg-3">
                    {l s='di cui zuccheri' mod='ms_nutritioninfo'}
                </label>
                <div class="col-lg-3">
                    <div class="input-group">
                        <input type="number" step="0.01" min="0" name="nutrition_zuccheri"
                            class="form-control"
                            value="{if $nutrition && $nutrition->zuccheri !== null}{$nutrition->zuccheri|escape:'htmlall':'UTF-8'}{/if}" />
                        <span class="input-group-addon">g</span>
                    </div>
                </div>
            </div>

            <div class="form-group ms-nutrition-sub ms-nutrition-optional">
                <label class="control-label col-lg-3">
                    {l s='di cui polialcoli' mod='ms_nutritioninfo'}
                    <span class="ms-optional-badge">{l s='opzionale' mod='ms_nutritioninfo'}</span>
                </label>
                <div class="col-lg-3">
                    <div class="input-group">
                        <input type="number" step="0.01" min="0" name="nutrition_polialcoli"
                            class="form-control"
                            value="{if $nutrition && $nutrition->polialcoli !== null}{$nutrition->polialcoli|escape:'htmlall':'UTF-8'}{/if}" />
                        <span class="input-group-addon">g</span>
                    </div>
                </div>
            </div>

            <div class="form-group ms-nutrition-sub ms-nutrition-optional">
                <label class="control-label col-lg-3">
                    {l s='di cui amido' mod='ms_nutritioninfo'}
                    <span class="ms-optional-badge">{l s='opzionale' mod='ms_nutritioninfo'}</span>
                </label>
                <div class="col-lg-3">
                    <div class="input-group">
                        <input type="number" step="0.01" min="0" name="nutrition_amido"
                            class="form-control"
                            value="{if $nutrition && $nutrition->amido !== null}{$nutrition->amido|escape:'htmlall':'UTF-8'}{/if}" />
                        <span class="input-group-addon">g</span>
                    </div>
                </div>
            </div>

            {* Fibre *}
            <div class="form-group">
                <label class="control-label col-lg-3">
                    {l s='Fibre' mod='ms_nutritioninfo'}
                </label>
                <div class="col-lg-3">
                    <div class="input-group">
                        <input type="number" step="0.01" min="0" name="nutrition_fibre"
                            class="form-control"
                            value="{if $nutrition && $nutrition->fibre !== null}{$nutrition->fibre|escape:'htmlall':'UTF-8'}{/if}" />
                        <span class="input-group-addon">g</span>
                    </div>
                </div>
            </div>

            {* Proteine *}
            <div class="form-group">
                <label class="control-label col-lg-3">
                    {l s='Proteine' mod='ms_nutritioninfo'}
                </label>
                <div class="col-lg-3">
                    <div class="input-group">
                        <input type="number" step="0.01" min="0" name="nutrition_proteine"
                            class="form-control"
                            value="{if $nutrition && $nutrition->proteine !== null}{$nutrition->proteine|escape:'htmlall':'UTF-8'}{/if}" />
                        <span class="input-group-addon">g</span>
                    </div>
                </div>
            </div>

            {* Sale *}
            <div class="form-group">
                <label class="control-label col-lg-3">
                    {l s='Sale' mod='ms_nutritioninfo'}
                </label>
                <div class="col-lg-3">
                    <div class="input-group">
                        <input type="number" step="0.01" min="0" name="nutrition_sale"
                            class="form-control"
                            value="{if $nutrition && $nutrition->sale !== null}{$nutrition->sale|escape:'htmlall':'UTF-8'}{/if}" />
                        <span class="input-group-addon">g</span>
                    </div>
                </div>
            </div>
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
