<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

function upgrade_module_1_0_1($module)
{
    $filePath = dirname(__FILE__) . '/../sql/update_1.0.1.sql';

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
