
{**
 * Template front-end: tabella nutrizionale stile etichetta EU.
 * Supporta layout a 2 colonne (per 100g) o 3 colonne (per 100g + per porzione).
 * @author Michele Pietrafesa
 *}

<div class="ms-nutrition-table-wrapper{if $show_porzione} ms-nutrition-3col{/if}">
    <table class="ms-nutrition-table">
        {* Header *}
        <thead>
            <tr>
                <th colspan="{$colspan}" class="ms-nutrition-header">
                    {l s='VALORI NUTRIZIONALI' mod='ms_nutritioninfo'}
                </th>
            </tr>
            <tr class="ms-nutrition-col-headers">
                <td class="ms-nutrition-porzione">&nbsp;</td>
                <td class="ms-nutrition-porzione ms-nutrition-col-label">
                    {l s='Per' mod='ms_nutritioninfo'} {$nutrition->porzione|escape:'htmlall':'UTF-8'}
                </td>
                {if $show_porzione}
                    <td class="ms-nutrition-porzione ms-nutrition-col-label">
                        {l s='Per porzione' mod='ms_nutritioninfo'}
                        {if $nutrition->porzione_descrizione}
                            ({$nutrition->porzione_descrizione|escape:'htmlall':'UTF-8'})
                        {/if}
                    </td>
                {/if}
            </tr>
        </thead>

        <tbody>
            {* Energia *}
            {if $nutrition->energia_kcal !== null || $nutrition->energia_kj !== null}
                <tr class="ms-nutrition-row ms-nutrition-separator">
                    <td class="ms-nutrition-label">{l s='Energia' mod='ms_nutritioninfo'}</td>
                    <td class="ms-nutrition-value">
                        {if $nutrition->energia_kcal !== null}{$nutrition->energia_kcal|string_format:"%.2f"|replace:'.':$decimal_separator} kcal{/if}
                        {if $nutrition->energia_kcal !== null && $nutrition->energia_kj !== null} / {/if}
                        {if $nutrition->energia_kj !== null}{$nutrition->energia_kj|string_format:"%.2f"|replace:'.':$decimal_separator} kJ{/if}
                    </td>
                    {if $show_porzione}
                        <td class="ms-nutrition-value">
                            {if $nutrition->energia_kcal_porzione !== null}{$nutrition->energia_kcal_porzione|string_format:"%.2f"|replace:'.':$decimal_separator} kcal{/if}
                            {if $nutrition->energia_kcal_porzione !== null && $nutrition->energia_kj_porzione !== null} / {/if}
                            {if $nutrition->energia_kj_porzione !== null}{$nutrition->energia_kj_porzione|string_format:"%.2f"|replace:'.':$decimal_separator} kJ{/if}
                        </td>
                    {/if}
                </tr>
            {/if}

            {* Grassi *}
            {if $nutrition->grassi !== null}
                <tr class="ms-nutrition-row ms-nutrition-separator">
                    <td class="ms-nutrition-label">{l s='Grassi' mod='ms_nutritioninfo'}</td>
                    <td class="ms-nutrition-value">{$nutrition->grassi|string_format:"%.1f"|replace:'.':$decimal_separator} g</td>
                    {if $show_porzione}
                        <td class="ms-nutrition-value">{if $nutrition->grassi_porzione !== null}{$nutrition->grassi_porzione|string_format:"%.1f"|replace:'.':$decimal_separator} g{/if}</td>
                    {/if}
                </tr>
            {/if}

            {if $nutrition->grassi_saturi !== null}
                <tr class="ms-nutrition-row ms-nutrition-sub-row">
                    <td class="ms-nutrition-label ms-nutrition-indent">{l s='di cui acidi grassi saturi' mod='ms_nutritioninfo'}</td>
                    <td class="ms-nutrition-value">{$nutrition->grassi_saturi|string_format:"%.1f"|replace:'.':$decimal_separator} g</td>
                    {if $show_porzione}
                        <td class="ms-nutrition-value">{if $nutrition->grassi_saturi_porzione !== null}{$nutrition->grassi_saturi_porzione|string_format:"%.1f"|replace:'.':$decimal_separator} g{/if}</td>
                    {/if}
                </tr>
            {/if}

            {if $nutrition->grassi_monoinsaturi !== null && $nutrition->grassi_monoinsaturi > 0}
                <tr class="ms-nutrition-row ms-nutrition-sub-row">
                    <td class="ms-nutrition-label ms-nutrition-indent">{l s='di cui acidi grassi monoinsaturi' mod='ms_nutritioninfo'}</td>
                    <td class="ms-nutrition-value">{$nutrition->grassi_monoinsaturi|string_format:"%.1f"|replace:'.':$decimal_separator} g</td>
                    {if $show_porzione}
                        <td class="ms-nutrition-value">{if $nutrition->grassi_monoinsaturi_porzione !== null}{$nutrition->grassi_monoinsaturi_porzione|string_format:"%.1f"|replace:'.':$decimal_separator} g{/if}</td>
                    {/if}
                </tr>
            {/if}

            {if $nutrition->grassi_polinsaturi !== null && $nutrition->grassi_polinsaturi > 0}
                <tr class="ms-nutrition-row ms-nutrition-sub-row">
                    <td class="ms-nutrition-label ms-nutrition-indent">{l s='di cui acidi grassi polinsaturi' mod='ms_nutritioninfo'}</td>
                    <td class="ms-nutrition-value">{$nutrition->grassi_polinsaturi|string_format:"%.1f"|replace:'.':$decimal_separator} g</td>
                    {if $show_porzione}
                        <td class="ms-nutrition-value">{if $nutrition->grassi_polinsaturi_porzione !== null}{$nutrition->grassi_polinsaturi_porzione|string_format:"%.1f"|replace:'.':$decimal_separator} g{/if}</td>
                    {/if}
                </tr>
            {/if}

            {* Carboidrati *}
            {if $nutrition->carboidrati !== null}
                <tr class="ms-nutrition-row ms-nutrition-separator">
                    <td class="ms-nutrition-label">{l s='Carboidrati' mod='ms_nutritioninfo'}</td>
                    <td class="ms-nutrition-value">{$nutrition->carboidrati|string_format:"%.1f"|replace:'.':$decimal_separator} g</td>
                    {if $show_porzione}
                        <td class="ms-nutrition-value">{if $nutrition->carboidrati_porzione !== null}{$nutrition->carboidrati_porzione|string_format:"%.1f"|replace:'.':$decimal_separator} g{/if}</td>
                    {/if}
                </tr>
            {/if}

            {if $nutrition->zuccheri !== null}
                <tr class="ms-nutrition-row ms-nutrition-sub-row">
                    <td class="ms-nutrition-label ms-nutrition-indent">{l s='di cui zuccheri' mod='ms_nutritioninfo'}</td>
                    <td class="ms-nutrition-value">{$nutrition->zuccheri|string_format:"%.1f"|replace:'.':$decimal_separator} g</td>
                    {if $show_porzione}
                        <td class="ms-nutrition-value">{if $nutrition->zuccheri_porzione !== null}{$nutrition->zuccheri_porzione|string_format:"%.1f"|replace:'.':$decimal_separator} g{/if}</td>
                    {/if}
                </tr>
            {/if}

            {if $nutrition->polialcoli !== null && $nutrition->polialcoli > 0}
                <tr class="ms-nutrition-row ms-nutrition-sub-row">
                    <td class="ms-nutrition-label ms-nutrition-indent">{l s='di cui polialcoli' mod='ms_nutritioninfo'}</td>
                    <td class="ms-nutrition-value">{$nutrition->polialcoli|string_format:"%.1f"|replace:'.':$decimal_separator} g</td>
                    {if $show_porzione}
                        <td class="ms-nutrition-value">{if $nutrition->polialcoli_porzione !== null}{$nutrition->polialcoli_porzione|string_format:"%.1f"|replace:'.':$decimal_separator} g{/if}</td>
                    {/if}
                </tr>
            {/if}

            {if $nutrition->amido !== null && $nutrition->amido > 0}
                <tr class="ms-nutrition-row ms-nutrition-sub-row">
                    <td class="ms-nutrition-label ms-nutrition-indent">{l s='di cui amido' mod='ms_nutritioninfo'}</td>
                    <td class="ms-nutrition-value">{$nutrition->amido|string_format:"%.1f"|replace:'.':$decimal_separator} g</td>
                    {if $show_porzione}
                        <td class="ms-nutrition-value">{if $nutrition->amido_porzione !== null}{$nutrition->amido_porzione|string_format:"%.1f"|replace:'.':$decimal_separator} g{/if}</td>
                    {/if}
                </tr>
            {/if}

            {* Fibre *}
            {if $nutrition->fibre !== null}
                <tr class="ms-nutrition-row ms-nutrition-separator">
                    <td class="ms-nutrition-label">{l s='Fibre' mod='ms_nutritioninfo'}</td>
                    <td class="ms-nutrition-value">{$nutrition->fibre|string_format:"%.1f"|replace:'.':$decimal_separator} g</td>
                    {if $show_porzione}
                        <td class="ms-nutrition-value">{if $nutrition->fibre_porzione !== null}{$nutrition->fibre_porzione|string_format:"%.1f"|replace:'.':$decimal_separator} g{/if}</td>
                    {/if}
                </tr>
            {/if}

            {* Proteine *}
            {if $nutrition->proteine !== null}
                <tr class="ms-nutrition-row ms-nutrition-separator">
                    <td class="ms-nutrition-label">{l s='Proteine' mod='ms_nutritioninfo'}</td>
                    <td class="ms-nutrition-value">{$nutrition->proteine|string_format:"%.1f"|replace:'.':$decimal_separator} g</td>
                    {if $show_porzione}
                        <td class="ms-nutrition-value">{if $nutrition->proteine_porzione !== null}{$nutrition->proteine_porzione|string_format:"%.1f"|replace:'.':$decimal_separator} g{/if}</td>
                    {/if}
                </tr>
            {/if}

            {* Sale *}
            {if $nutrition->sale !== null}
                <tr class="ms-nutrition-row ms-nutrition-separator">
                    <td class="ms-nutrition-label">{l s='Sale' mod='ms_nutritioninfo'}</td>
                    <td class="ms-nutrition-value">{$nutrition->sale|string_format:"%.2f"|replace:'.':$decimal_separator} g</td>
                    {if $show_porzione}
                        <td class="ms-nutrition-value">{if $nutrition->sale_porzione !== null}{$nutrition->sale_porzione|string_format:"%.2f"|replace:'.':$decimal_separator} g{/if}</td>
                    {/if}
                </tr>
            {/if}

            {* Vitamine e Minerali *}
            {if $vitamine_minerali && count($vitamine_minerali) > 0}
                <tr class="ms-nutrition-row ms-nutrition-separator">
                    <td colspan="{$colspan}" class="ms-nutrition-label ms-nutrition-section-title">
                        {l s='VITAMINE E MINERALI' mod='ms_nutritioninfo'}
                    </td>
                </tr>
                {foreach $vitamine_minerali as $vit}
                    <tr class="ms-nutrition-row ms-nutrition-vitamin-row">
                        <td class="ms-nutrition-label">{$vit.nome|escape:'htmlall':'UTF-8'}</td>
                        <td class="ms-nutrition-value" {if $show_porzione}colspan="2"{/if}>
                            {$vit.quantita|escape:'htmlall':'UTF-8'} {$vit.unita|escape:'htmlall':'UTF-8'}
                            {if $has_vnr && $vit.vnr != ''}
                                <span class="ms-nutrition-vnr">({$vit.vnr|escape:'htmlall':'UTF-8'}% {l s='VNR' mod='ms_nutritioninfo'})</span>
                            {/if}
                        </td>
                    </tr>
                {/foreach}
            {/if}

            {* Acidi Aminici *}
            {if $acidi_aminici && count($acidi_aminici) > 0}
                <tr class="ms-nutrition-row ms-nutrition-separator">
                    <td colspan="{$colspan}" class="ms-nutrition-label ms-nutrition-section-title">
                        {l s='ACIDI AMINICI' mod='ms_nutritioninfo'}
                    </td>
                </tr>
                {foreach $acidi_aminici as $aa}
                    <tr class="ms-nutrition-row ms-nutrition-amino-row">
                        <td class="ms-nutrition-label">{$aa.nome|escape:'htmlall':'UTF-8'}</td>
                        <td class="ms-nutrition-value" {if $show_porzione}colspan="2"{/if}>
                            {$aa.quantita|escape:'htmlall':'UTF-8'} {$aa.unita|escape:'htmlall':'UTF-8'}
                        </td>
                    </tr>
                {/foreach}
            {/if}

            {* Ingredienti *}
            {if $safe_ingredienti != ''}
                <tr class="ms-nutrition-row ms-nutrition-separator">
                    <td colspan="{$colspan}" class="ms-nutrition-text-section">
                        <strong>{l s='INGREDIENTI:' mod='ms_nutritioninfo'}</strong><br />
                        {$safe_ingredienti nofilter}
                    </td>
                </tr>
            {/if}

            {* Allergeni *}
            {if $safe_allergeni != ''}
                <tr class="ms-nutrition-row ms-nutrition-separator">
                    <td colspan="{$colspan}" class="ms-nutrition-text-section">
                        <strong>{l s='ALLERGENI:' mod='ms_nutritioninfo'}</strong>
                        {$safe_allergeni nofilter}
                    </td>
                </tr>
            {/if}

            {* Note *}
            {if $nutrition->note && $nutrition->note != ''}
                <tr class="ms-nutrition-row">
                    <td colspan="{$colspan}" class="ms-nutrition-text-section ms-nutrition-note">
                        {$nutrition->note|escape:'htmlall':'UTF-8'}
                    </td>
                </tr>
            {/if}
        </tbody>
    </table>
</div>
