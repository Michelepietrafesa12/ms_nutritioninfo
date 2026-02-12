<?php
/**
 * Modulo PrestaShop per la gestione dei Valori Nutrizionali dei prodotti.
 *
 * Aggiunge una tab nel back-office per inserire i dati nutrizionali
 * e una tabella stile etichetta EU nel front-end della scheda prodotto.
 *
 * @author    Michele Pietrafesa
 * @license   MIT
 */

if (!defined('_PS_VERSION_')) {
    exit;
}

require_once dirname(__FILE__) . '/classes/ProductNutrition.php';

class Ms_NutritionInfo extends Module
{
    public function __construct()
    {
        $this->name = 'ms_nutritioninfo';
        $this->tab = 'front_office_features';
        $this->version = '1.0.0';
        $this->author = 'Michele Pietrafesa';
        $this->need_instance = 0;
        $this->ps_versions_compliancy = array('min' => '1.7.6.0', 'max' => _PS_VERSION_);
        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->l('Valori Nutrizionali Prodotto');
        $this->description = $this->l('Gestisci e visualizza i valori nutrizionali dei prodotti con tabella stile etichetta EU.');
        $this->confirmUninstall = $this->l('Sei sicuro di voler disinstallare il modulo? Tutti i dati nutrizionali verranno eliminati.');
    }

    /**
     * Installazione del modulo: crea tabelle e registra hooks.
     *
     * @return bool
     */
    public function install()
    {
        return parent::install()
            && $this->executeSqlFile('install')
            && $this->registerHook('displayAdminProductsExtra')
            && $this->registerHook('actionProductUpdate')
            && $this->registerHook('actionProductDelete')
            && $this->registerHook('displayProductExtraContent')
            && $this->registerHook('displayHeader')
            && $this->registerHook('displayBackOfficeHeader');
    }

    /**
     * Disinstallazione del modulo: rimuove tabelle.
     *
     * @return bool
     */
    public function uninstall()
    {
        return $this->executeSqlFile('uninstall')
            && parent::uninstall();
    }

    /**
     * Esegue un file SQL dalla cartella sql/.
     *
     * @param string $filename Nome del file senza estensione
     * @return bool
     */
    private function executeSqlFile($filename)
    {
        $filePath = dirname(__FILE__) . '/sql/' . $filename . '.sql';

        if (!file_exists($filePath)) {
            return false;
        }

        $sql = Tools::file_get_contents($filePath);
        $sql = str_replace('PREFIX_', _DB_PREFIX_, $sql);
        $queries = preg_split('/;\s*[\r\n]+/', $sql);

        foreach ($queries as $query) {
            $query = trim($query);
            if (!empty($query)) {
                if (!Db::getInstance()->execute($query)) {
                    return false;
                }
            }
        }

        return true;
    }

    /* =========================================================================
     * HOOK: displayBackOfficeHeader
     * Carica CSS e JS nell'admin (solo nell'editor prodotto)
     * ========================================================================= */

    public function hookDisplayBackOfficeHeader($params)
    {
        $controller = Tools::getValue('controller');

        if ($controller === 'AdminProducts') {
            $this->context->controller->addCSS($this->_path . 'views/css/admin.css');
            $this->context->controller->addJS($this->_path . 'views/js/admin.js');
        }
    }

    /* =========================================================================
     * HOOK: displayHeader
     * Carica CSS nel front-end (solo nella pagina prodotto)
     * ========================================================================= */

    public function hookDisplayHeader($params)
    {
        $controller = Tools::getValue('controller');

        if ($controller === 'product') {
            $this->context->controller->registerStylesheet(
                'ms-nutritioninfo-front',
                'modules/' . $this->name . '/views/css/front.css',
                array('media' => 'all', 'priority' => 150)
            );
        }
    }

    /* =========================================================================
     * HOOK: displayAdminProductsExtra
     * Aggiunge la tab "Valori Nutrizionali" nell'editor prodotto
     * ========================================================================= */

    public function hookDisplayAdminProductsExtra($params)
    {
        $id_product = (int) $params['id_product'];
        $nutrition = ProductNutrition::getByProductId($id_product);

        $vitamine_minerali = array();
        if ($nutrition && !empty($nutrition->vitamine_minerali)) {
            $decoded = json_decode($nutrition->vitamine_minerali, true);
            if (is_array($decoded)) {
                $vitamine_minerali = $decoded;
            }
        }

        $this->context->smarty->assign(array(
            'nutrition' => $nutrition,
            'vitamine_minerali' => $vitamine_minerali,
            'id_product' => $id_product,
            'module_dir' => $this->_path,
        ));

        return $this->display(__FILE__, 'views/templates/admin/nutrition_tab.tpl');
    }

    /* =========================================================================
     * HOOK: actionProductUpdate
     * Salva i dati nutrizionali quando il prodotto viene aggiornato
     * ========================================================================= */

    public function hookActionProductUpdate($params)
    {
        $id_product = (int) $params['id_product'];

        if (!Tools::getIsset('nutrition_active')) {
            return;
        }

        $nutrition = ProductNutrition::getByProductId($id_product);
        $isNew = false;

        if (!$nutrition) {
            $nutrition = new ProductNutrition();
            $nutrition->id_product = $id_product;
            $isNew = true;
        }

        $nutrition->active = (int) Tools::getValue('nutrition_active', 0);
        $nutrition->porzione = Tools::getValue('nutrition_porzione', '100g');

        // Campi numerici
        $numericFields = array(
            'energia_kcal', 'energia_kj', 'grassi', 'grassi_saturi',
            'grassi_monoinsaturi', 'grassi_polinsaturi', 'carboidrati',
            'zuccheri', 'polialcoli', 'amido', 'fibre', 'proteine', 'sale',
        );

        foreach ($numericFields as $field) {
            $value = Tools::getValue('nutrition_' . $field, '');
            if ($value !== '' && $value !== null) {
                $value = str_replace(',', '.', $value);
                $floatVal = (float) $value;
                $nutrition->{$field} = $floatVal >= 0 ? $floatVal : null;
            } else {
                $nutrition->{$field} = null;
            }
        }

        // Vitamine e minerali (JSON)
        $vitNomi = Tools::getValue('nutrition_vit_nome', array());
        $vitQuantita = Tools::getValue('nutrition_vit_quantita', array());
        $vitUnita = Tools::getValue('nutrition_vit_unita', array());
        $vitVnr = Tools::getValue('nutrition_vit_vnr', array());

        $vitamine = array();
        if (is_array($vitNomi)) {
            foreach ($vitNomi as $i => $nome) {
                $nome = trim($nome);
                if (!empty($nome)) {
                    $allowedUnits = array('mg', 'µg', 'g');
                    $unita = isset($vitUnita[$i]) && in_array($vitUnita[$i], $allowedUnits) ? $vitUnita[$i] : 'mg';
                    $vitamine[] = array(
                        'nome' => $nome,
                        'quantita' => isset($vitQuantita[$i]) ? (string) (float) str_replace(',', '.', $vitQuantita[$i]) : '',
                        'unita' => $unita,
                        'vnr' => isset($vitVnr[$i]) && $vitVnr[$i] !== '' ? (string) (float) str_replace(',', '.', $vitVnr[$i]) : '',
                    );
                }
            }
        }
        $nutrition->vitamine_minerali = !empty($vitamine) ? json_encode($vitamine) : null;

        // Campi testo
        $nutrition->ingredienti = Tools::getValue('nutrition_ingredienti', '');
        $nutrition->allergeni = Tools::getValue('nutrition_allergeni', '');
        $nutrition->note = Tools::getValue('nutrition_note', '');

        if ($isNew) {
            $nutrition->date_add = date('Y-m-d H:i:s');
        }
        $nutrition->date_upd = date('Y-m-d H:i:s');

        $nutrition->save();
    }

    /* =========================================================================
     * HOOK: actionProductDelete
     * Cancella i dati nutrizionali quando il prodotto viene eliminato
     * ========================================================================= */

    public function hookActionProductDelete($params)
    {
        $id_product = (int) $params['id_product'];
        ProductNutrition::deleteByProductId($id_product);
    }

    /* =========================================================================
     * HOOK: displayProductExtraContent
     * Mostra la tab con la tabella nutrizionale nel front-end
     * ========================================================================= */

    public function hookDisplayProductExtraContent($params)
    {
        $id_product = (int) $params['product']->id;
        $nutrition = ProductNutrition::getByProductId($id_product);

        if (!$nutrition || !$nutrition->active || !$nutrition->hasNutritionalData()) {
            return array();
        }

        // Decodifica vitamine
        $vitamine_minerali = array();
        $hasVnr = false;
        if (!empty($nutrition->vitamine_minerali)) {
            $decoded = json_decode($nutrition->vitamine_minerali, true);
            if (is_array($decoded) && !empty($decoded)) {
                $vitamine_minerali = $decoded;
                foreach ($vitamine_minerali as $vit) {
                    if (!empty($vit['vnr'])) {
                        $hasVnr = true;
                        break;
                    }
                }
            }
        }

        // Sanitizza HTML di ingredienti e allergeni: consenti solo tag di formattazione base
        $allowedTags = '<b><strong><i><em><br><p><ul><ol><li><span>';
        $safeIngredienti = !empty($nutrition->ingredienti) ? strip_tags($nutrition->ingredienti, $allowedTags) : '';
        $safeAllergeni = !empty($nutrition->allergeni) ? strip_tags($nutrition->allergeni, $allowedTags) : '';

        $this->context->smarty->assign(array(
            'nutrition' => $nutrition,
            'vitamine_minerali' => $vitamine_minerali,
            'has_vnr' => $hasVnr,
            'safe_ingredienti' => $safeIngredienti,
            'safe_allergeni' => $safeAllergeni,
        ));

        $content = $this->display(__FILE__, 'views/templates/hook/nutrition_front.tpl');

        $tab = new PrestaShop\PrestaShop\Core\Product\ProductExtraContent();
        $tab->setTitle($this->l('Valori Nutrizionali'));
        $tab->setContent($content);

        return array($tab);
    }
}
