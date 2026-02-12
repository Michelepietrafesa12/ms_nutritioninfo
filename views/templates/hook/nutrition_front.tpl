
{**
 * Template front-end: tabella nutrizionale stile etichetta EU.
 * @author Michele Pietrafesa
 *}

<div class="ms-nutrition-table-wrapper">
    <table class="ms-nutrition-table">
        {* Header *}
        <thead>
            <tr>
                <th colspan="2" class="ms-nutrition-header">
                    {l s='VALORI NUTRIZIONALI' mod='ms_nutritioninfo'}
                </th>
            </tr>
            <tr>
                <td colspan="2" class="ms-nutrition-porzione">
                    {l s='Per porzione:' mod='ms_nutritioninfo'} {$nutrition->porzione|escape:'htmlall':'UTF-8'}
                </td>
            </tr>
        </thead>

        <tbody>
            {* Energia *}
            {if $nutrition->energia_kcal !== null || $nutrition->energia_kj !== null}
                <tr class="ms-nutrition-row ms-nutrition-separator">
                    <td class="ms-nutrition-label">{l s='Energia' mod='ms_nutritioninfo'}</td>
                    <td class="ms-nutrition-value">
                        {if $nutrition->energia_kcal !== null}{$nutrition->energia_kcal|string_format:"%.2f"|replace:'.':','} kcal{/if}
                        {if $nutrition->energia_kcal !== null && $nutrition->energia_kj !== null} / {/if}
                        {if $nutrition->energia_kj !== null}{$nutrition->energia_kj|string_format:"%.2f"|replace:'.':','} kJ{/if}
                    </td>
                </tr>
            {/if}

            {* Grassi *}
            {if $nutrition->grassi !== null}
                <tr class="ms-nutrition-row ms-nutrition-separator">
                    <td class="ms-nutrition-label">{l s='Grassi' mod='ms_nutritioninfo'}</td>
                    <td class="ms-nutrition-value">{$nutrition->grassi|string_format:"%.1f"|replace:'.':','} g</td>
                </tr>
            {/if}

            {if $nutrition->grassi_saturi !== null}
                <tr class="ms-nutrition-row ms-nutrition-sub-row">
                    <td class="ms-nutrition-label ms-nutrition-indent">{l s='di cui acidi grassi saturi' mod='ms_nutritioninfo'}</td>
                    <td class="ms-nutrition-value">{$nutrition->grassi_saturi|string_format:"%.1f"|replace:'.':','} g</td>
                </tr>
            {/if}

            {if $nutrition->grassi_monoinsaturi !== null && $nutrition->grassi_monoinsaturi > 0}
                <tr class="ms-nutrition-row ms-nutrition-sub-row">
                    <td class="ms-nutrition-label ms-nutrition-indent">{l s='di cui acidi grassi monoinsaturi' mod='ms_nutritioninfo'}</td>
                    <td class="ms-nutrition-value">{$nutrition->grassi_monoinsaturi|string_format:"%.1f"|replace:'.':','} g</td>
                </tr>
            {/if}

            {if $nutrition->grassi_polinsaturi !== null && $nutrition->grassi_polinsaturi > 0}
                <tr class="ms-nutrition-row ms-nutrition-sub-row">
                    <td class="ms-nutrition-label ms-nutrition-indent">{l s='di cui acidi grassi polinsaturi' mod='ms_nutritioninfo'}</td>
                    <td class="ms-nutrition-value">{$nutrition->grassi_polinsaturi|string_format:"%.1f"|replace:'.':','} g</td>
                </tr>
            {/if}

            {* Carboidrati *}
            {if $nutrition->carboidrati !== null}
                <tr class="ms-nutrition-row ms-nutrition-separator">
                    <td class="ms-nutrition-label">{l s='Carboidrati' mod='ms_nutritioninfo'}</td>
                    <td class="ms-nutrition-value">{$nutrition->carboidrati|string_format:"%.1f"|replace:'.':','} g</td>
                </tr>
            {/if}

            {if $nutrition->zuccheri !== null}
                <tr class="ms-nutrition-row ms-nutrition-sub-row">
                    <td class="ms-nutrition-label ms-nutrition-indent">{l s='di cui zuccheri' mod='ms_nutritioninfo'}</td>
                    <td class="ms-nutrition-value">{$nutrition->zuccheri|string_format:"%.1f"|replace:'.':','} g</td>
                </tr>
            {/if}

            {if $nutrition->polialcoli !== null && $nutrition->polialcoli > 0}
                <tr class="ms-nutrition-row ms-nutrition-sub-row">
                    <td class="ms-nutrition-label ms-nutrition-indent">{l s='di cui polialcoli' mod='ms_nutritioninfo'}</td>
                    <td class="ms-nutrition-value">{$nutrition->polialcoli|string_format:"%.1f"|replace:'.':','} g</td>
                </tr>
            {/if}

            {if $nutrition->amido !== null && $nutrition->amido > 0}
                <tr class="ms-nutrition-row ms-nutrition-sub-row">
                    <td class="ms-nutrition-label ms-nutrition-indent">{l s='di cui amido' mod='ms_nutritioninfo'}</td>
                    <td class="ms-nutrition-value">{$nutrition->amido|string_format:"%.1f"|replace:'.':','} g</td>
                </tr>
            {/if}

            {* Fibre *}
            {if $nutrition->fibre !== null}
                <tr class="ms-nutrition-row ms-nutrition-separator">
                    <td class="ms-nutrition-label">{l s='Fibre' mod='ms_nutritioninfo'}</td>
                    <td class="ms-nutrition-value">{$nutrition->fibre|string_format:"%.1f"|replace:'.':','} g</td>
                </tr>
            {/if}

            {* Proteine *}
            {if $nutrition->proteine !== null}
                <tr class="ms-nutrition-row ms-nutrition-separator">
                    <td class="ms-nutrition-label">{l s='Proteine' mod='ms_nutritioninfo'}</td>
                    <td class="ms-nutrition-value">{$nutrition->proteine|string_format:"%.1f"|replace:'.':','} g</td>
                </tr>
            {/if}

            {* Sale *}
            {if $nutrition->sale !== null}
                <tr class="ms-nutrition-row ms-nutrition-separator">
                    <td class="ms-nutrition-label">{l s='Sale' mod='ms_nutritioninfo'}</td>
                    <td class="ms-nutrition-value">{$nutrition->sale|string_format:"%.2f"|replace:'.':','} g</td>
                </tr>
            {/if}

            {* Vitamine e Minerali *}
            {if $vitamine_minerali && count($vitamine_minerali) > 0}
                <tr class="ms-nutrition-row ms-nutrition-separator">
                    <td colspan="2" class="ms-nutrition-label ms-nutrition-section-title">
                        {l s='VITAMINE E MINERALI' mod='ms_nutritioninfo'}
                    </td>
                </tr>
                {foreach $vitamine_minerali as $vit}
                    <tr class="ms-nutrition-row ms-nutrition-vitamin-row">
                        <td class="ms-nutrition-label">{$vit.nome|escape:'htmlall':'UTF-8'}</td>
                        <td class="ms-nutrition-value">
                            {$vit.quantita|escape:'htmlall':'UTF-8'} {$vit.unita|escape:'htmlall':'UTF-8'}
                            {if $has_vnr && $vit.vnr != ''}
                                <span class="ms-nutrition-vnr">({$vit.vnr|escape:'htmlall':'UTF-8'}% {l s='VNR' mod='ms_nutritioninfo'})</span>
                            {/if}
                        </td>
                    </tr>
                {/foreach}
            {/if}

            {* Ingredienti *}
            {if $safe_ingredienti != ''}
                <tr class="ms-nutrition-row ms-nutrition-separator">
                    <td colspan="2" class="ms-nutrition-text-section">
                        <strong>{l s='INGREDIENTI:' mod='ms_nutritioninfo'}</strong><br />
                        {$safe_ingredienti nofilter}
                    </td>
                </tr>
            {/if}

            {* Allergeni *}
            {if $safe_allergeni != ''}
                <tr class="ms-nutrition-row ms-nutrition-separator">
                    <td colspan="2" class="ms-nutrition-text-section">
                        <strong>{l s='ALLERGENI:' mod='ms_nutritioninfo'}</strong>
                        {$safe_allergeni nofilter}
                    </td>
                </tr>
            {/if}

            {* Note *}
            {if $nutrition->note && $nutrition->note != ''}
                <tr class="ms-nutrition-row">
                    <td colspan="2" class="ms-nutrition-text-section ms-nutrition-note">
                        {$nutrition->note|escape:'htmlall':'UTF-8'}
                    </td>
                </tr>
            {/if}
        </tbody>
    </table>
</div>
