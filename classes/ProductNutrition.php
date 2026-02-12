<?php
/**
 * ProductNutrition ObjectModel
 *
 * Gestisce i dati nutrizionali associati ai prodotti.
 *
 * @author    Michele Pietrafesa
 * @license   MIT
 */

if (!defined('_PS_VERSION_')) {
    exit;
}

class ProductNutrition extends ObjectModel
{
    /** @var int */
    public $id_nutrition;

    /** @var int */
    public $id_product;

    /** @var string */
    public $porzione = '100g';

    /** @var float */
    public $energia_kcal;

    /** @var float */
    public $energia_kj;

    /** @var float */
    public $grassi;

    /** @var float */
    public $grassi_saturi;

    /** @var float */
    public $grassi_monoinsaturi;

    /** @var float */
    public $grassi_polinsaturi;

    /** @var float */
    public $carboidrati;

    /** @var float */
    public $zuccheri;

    /** @var float */
    public $polialcoli;

    /** @var float */
    public $amido;

    /** @var float */
    public $fibre;

    /** @var float */
    public $proteine;

    /** @var float */
    public $sale;

    /** @var string JSON */
    public $vitamine_minerali;

    /** @var string HTML */
    public $ingredienti;

    /** @var string HTML */
    public $allergeni;

    /** @var string */
    public $note;

    /** @var bool */
    public $active = 1;

    /** @var string */
    public $date_add;

    /** @var string */
    public $date_upd;

    /**
     * @see ObjectModel::$definition
     */
    public static $definition = array(
        'table' => 'product_nutrition',
        'primary' => 'id_nutrition',
        'fields' => array(
            'id_product' => array(
                'type' => self::TYPE_INT,
                'validate' => 'isUnsignedId',
                'required' => true,
            ),
            'porzione' => array(
                'type' => self::TYPE_STRING,
                'validate' => 'isGenericName',
                'size' => 100,
            ),
            'energia_kcal' => array(
                'type' => self::TYPE_FLOAT,
                'validate' => 'isUnsignedFloat',
            ),
            'energia_kj' => array(
                'type' => self::TYPE_FLOAT,
                'validate' => 'isUnsignedFloat',
            ),
            'grassi' => array(
                'type' => self::TYPE_FLOAT,
                'validate' => 'isUnsignedFloat',
            ),
            'grassi_saturi' => array(
                'type' => self::TYPE_FLOAT,
                'validate' => 'isUnsignedFloat',
            ),
            'grassi_monoinsaturi' => array(
                'type' => self::TYPE_FLOAT,
                'validate' => 'isUnsignedFloat',
            ),
            'grassi_polinsaturi' => array(
                'type' => self::TYPE_FLOAT,
                'validate' => 'isUnsignedFloat',
            ),
            'carboidrati' => array(
                'type' => self::TYPE_FLOAT,
                'validate' => 'isUnsignedFloat',
            ),
            'zuccheri' => array(
                'type' => self::TYPE_FLOAT,
                'validate' => 'isUnsignedFloat',
            ),
            'polialcoli' => array(
                'type' => self::TYPE_FLOAT,
                'validate' => 'isUnsignedFloat',
            ),
            'amido' => array(
                'type' => self::TYPE_FLOAT,
                'validate' => 'isUnsignedFloat',
            ),
            'fibre' => array(
                'type' => self::TYPE_FLOAT,
                'validate' => 'isUnsignedFloat',
            ),
            'proteine' => array(
                'type' => self::TYPE_FLOAT,
                'validate' => 'isUnsignedFloat',
            ),
            'sale' => array(
                'type' => self::TYPE_FLOAT,
                'validate' => 'isUnsignedFloat',
            ),
            'vitamine_minerali' => array(
                'type' => self::TYPE_STRING,
                'validate' => 'isString',
            ),
            'ingredienti' => array(
                'type' => self::TYPE_HTML,
                'validate' => 'isCleanHtml',
            ),
            'allergeni' => array(
                'type' => self::TYPE_HTML,
                'validate' => 'isCleanHtml',
            ),
            'note' => array(
                'type' => self::TYPE_STRING,
                'validate' => 'isCleanHtml',
            ),
            'active' => array(
                'type' => self::TYPE_BOOL,
                'validate' => 'isBool',
            ),
            'date_add' => array(
                'type' => self::TYPE_DATE,
                'validate' => 'isDate',
            ),
            'date_upd' => array(
                'type' => self::TYPE_DATE,
                'validate' => 'isDate',
            ),
        ),
    );

    /**
     * Recupera l'oggetto ProductNutrition per un dato prodotto.
     *
     * @param int $id_product
     * @return ProductNutrition|null
     */
    public static function getByProductId($id_product)
    {
        $id_product = (int) $id_product;

        $sql = new DbQuery();
        $sql->select('id_nutrition');
        $sql->from('product_nutrition');
        $sql->where('id_product = ' . $id_product);

        $id_nutrition = (int) Db::getInstance()->getValue($sql);

        if ($id_nutrition > 0) {
            $obj = new ProductNutrition($id_nutrition);
            if (Validate::isLoadedObject($obj)) {
                return $obj;
            }
        }

        return null;
    }

    /**
     * Elimina i dati nutrizionali per un dato prodotto.
     *
     * @param int $id_product
     * @return bool
     */
    public static function deleteByProductId($id_product)
    {
        $id_product = (int) $id_product;

        return Db::getInstance()->delete('product_nutrition', 'id_product = ' . $id_product);
    }

    /**
     * Verifica se almeno un campo nutrizionale è compilato.
     *
     * @return bool
     */
    public function hasNutritionalData()
    {
        $numericFields = array(
            'energia_kcal', 'energia_kj', 'grassi', 'grassi_saturi',
            'grassi_monoinsaturi', 'grassi_polinsaturi', 'carboidrati',
            'zuccheri', 'polialcoli', 'amido', 'fibre', 'proteine', 'sale',
        );

        foreach ($numericFields as $field) {
            if ($this->{$field} !== null && $this->{$field} !== '') {
                return true;
            }
        }

        // Verifica anche campi testo
        if (!empty($this->vitamine_minerali) && $this->vitamine_minerali !== '[]') {
            return true;
        }
        if (!empty($this->ingredienti)) {
            return true;
        }
        if (!empty($this->allergeni)) {
            return true;
        }

        return false;
    }
}
