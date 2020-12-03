<?php
    include_once(dirname(__FILE__) . "/../Database.php");
    include_once(dirname(__FILE__) . "/func/getTypeLevel.php");
    function loyaltyRegeneration()
    {
        global $database;
        if (!$database->checkConnection()) {
            throw new Exception(__FILE__ . ' cant connect to database.');
        }
        $array = array();
        $q = "SELECT `wref`,`loyalty`,`lastupdate` FROM " . TB_PREFIX . "vdata WHERE loyalty < 100 LIMIT 50";
        $array = $database->query_return($q);
        if (!empty($array)) {
            foreach ($array as $loyalty) {
                if (getTypeLevel(25, $loyalty['wref']) >= 1) {
                    $value = getTypeLevel(25, $loyalty['wref']);
                } elseif (getTypeLevel(26, $loyalty['wref']) >= 1) {
                    $value = getTypeLevel(26, $loyalty['wref']);
                } else {
                    $value = 0;
                }
                $newloyalty = min(100, $loyalty['loyalty'] + $value * ($_SERVER['REQUEST_TIME'] - $loyalty['lastupdate']) * SPEED / (3600));
                $q = "UPDATE " . TB_PREFIX . "vdata SET loyalty = $newloyalty WHERE wref = '" . $loyalty['wref'] . "'";
                $database->query($q);
            }
        }
        $array = array();
        $q = "SELECT `loyalty`,`conqured`,`lastupdated`,`wref` FROM " . TB_PREFIX . "odata WHERE loyalty<100 LIMIT 50";
        $array = $database->query_return($q);
        if (!empty($array)) {
            foreach ($array as $loyalty) {
                if (getTypeLevel(25, $loyalty['conqured']) >= 1) {
                    $value = getTypeLevel(25, $loyalty['conqured']);
                } elseif (getTypeLevel(26, $loyalty['conqured']) >= 1) {
                    $value = getTypeLevel(26, $loyalty['conqured']);
                } else {
                    $value = 0;
                }
                $newloyalty = min(100, $loyalty['loyalty'] + $value * ($_SERVER['REQUEST_TIME'] - $loyalty['lastupdated']) * SPEED / (60 * 60));
                $q = "UPDATE " . TB_PREFIX . "odata SET loyalty = $newloyalty WHERE wref = '" . $loyalty['wref'] . "'";
                $database->query($q);
            }
        }
        $q = "UPDATE " . TB_PREFIX . "vdata SET loyalty = 125 WHERE loyalty>125";
        $database->query($q);
    }

?>
