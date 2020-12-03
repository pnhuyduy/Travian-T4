<?php
    include_once(dirname(__FILE__) . "/../Database.php");
    include_once(dirname(__FILE__) . "/../Data/hero_full.php");
    function updateHero()
    {
        global $database, $hero_levels;
        if (!$database->checkConnection()) {
            throw new Exception(__FILE__ . ' cant connect to database.');
        }
        //throw new Exception(__FILE__.' thrower.');
        $time = $_SERVER['REQUEST_TIME'];
        $q = "SELECT `dead`,`health`,`autoregen`,`itemautoregen`,`heroid`,`level`,`experience` FROM " . TB_PREFIX . "hero";
        $harray = $database->query_return($q);
        if (!empty($harray)) {
            foreach ($harray as $hero) {
                if ($hero['dead'] == 0 && $hero['health'] < 100) {
                    $updatediff = $time - $hero['lastupdate'];
                    $updatepart = $updatediff / 86400;
                    $health = round((($hero['autoregen'] * HEROATTRSPEED) + ($hero['itemautoregen'] * ITEMATTRSPEED))
//* $updatepart
                        , 1);
                    $health += $hero['health'];
                    if ($health > 100) $health = 100;
                    $database->modifyHero(0, $hero['heroid'], "health", $health, 0);
                    $database->modifyHero(0, $hero['heroid'], "lastupdate", $_SERVER['REQUEST_TIME'], 0);
                }
                while ($hero['experience'] > 0 && $hero['level'] < 100 && isset($hero_levels[$hero['level']]) && $hero['experience'] >= $hero_levels[$hero['level']]) {
                    $database->modifyHero(0, $hero['heroid'], "level", 1, 1);
                    $database->modifyHero(0, $hero['heroid'], "points", 4, 1);
                    $hero['level']++;
                }
                if ($hero['experience'] > PHP_INT_MAX) {
                    $database->modifyHero(0, $hero['heroid'], "experience", PHP_INT_MAX, 0);
                }
                if ($hero['level'] > 100) {
                    $hero['level'] = 100;
                    $database->modifyHero(0, $hero['heroid'], "level", 100, 0);
                    $database->modifyHero(0, $hero['heroid'], "experience", PHP_INT_MAX, 0);
                }
                if ($hero['level'] > 0 && $hero['experience'] == 0) {
                    if ($hero['level'] < 100) {
                        $level = $hero_levels[$hero['level']];
                    } else {
                        $level = $hero_levels[99];
                    }
                    $database->modifyHero(0, $hero['heroid'], "experience", $level, 0);
                }
            }
        }
        $q2 = "UPDATE " . TB_PREFIX . "units SET hero = 1 WHERE hero > 1";
        $database->query($q2);
        $q2 = "UPDATE " . TB_PREFIX . "enforcement SET hero = 1 WHERE hero > 1";
        $database->query($q2);
        $q2 = "UPDATE " . TB_PREFIX . "trapped SET hero = 1 WHERE hero > 1";
        $database->query($q2);
        $q2 = "UPDATE " . TB_PREFIX . "attacks SET t11 = 1 WHERE t11 > 1";
        $database->query($q2);
    }

?>
