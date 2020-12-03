<?php
    include_once(dirname(__FILE__) . "/../Database.php");
    include_once(dirname(__FILE__) . "/../Ranking.php");
    $row = mysql_fetch_assoc(mysql_query('SELECT `stats_lasttime`, `stats_time` FROM ' . TB_PREFIX . 'config'));
    $stats_lasttime = $row['stats_lasttime'];
    $stats_time = $row['stats_time'];
    $TimerM = $stats_time + $stats_lasttime;
    if ($_SERVER['REQUEST_TIME'] > $TimerM) {
        global $database, $ranking;
        $res = mysql_query("SELECT `wref`, `owner`, `wood`, `clay`, `iron`, `crop`, `pop` FROM " . TB_PREFIX . "vdata WHERE owner > 4 AND natar != 1");
        while ($user = mysql_fetch_assoc($res)) {
            $q = mysql_query("SELECT `id`, `timestamp`, `tribe`, `plus` FROM " . TB_PREFIX . "users WHERE id = '" . $user['owner'] . "'") or die(mysql_error());
            $t = mysql_fetch_assoc($q);
            $time = $_SERVER['REQUEST_TIME'];
            if (($time - $t['timestamp']) < (3600 * 24) && $t['plus'] > $time) {
                $owner = $user['owner'];
                $wref = $user['wref'];
                $tribe = $t['tribe'];
                $pop = $user['pop'];
                $tot = $user['wood'] + $user['clay'] + $user['iron'] + $user['crop'];
                $heroamt = $amount = $rein = 0;
                $units = $database->getUnit($wref);
                switch ($tribe) {
                    case 1:
                        $Gtribe = '';
                        break;
                    case 2:
                        $Gtribe = '1';
                        break;
                    case 3:
                        $Gtribe = '2';
                        break;
                }
                for ($i = 1; $i < 30; $i++) {
                    $amount += $units['u' . $Gtribe . $i];
                }
                $reinfs = $database->getEnforceVillage($wref, 0);;
                if (count($reinfs) > 0) {
                    foreach ($reinfs as $reinf) {
                        for ($i = 1; $i <= 50; $i++) {
                            if ($reinf['u' . $i] != 0) {
                                $rein += $reinf['u' . $i];
                            }
                        }
                    }
                }
                $myrank = $ranking->getUserRank($t['id']);
                mysql_query("INSERT INTO " . TB_PREFIX . "stats values ('','$owner','$amount','$rein','$tot','$pop','$myrank','$time')") or die(mysql_error());
            }
        }
        mysql_query("UPDATE " . TB_PREFIX . "config SET `stats_lasttime` = '" . $time . "' ") or die(mysql_error());
    }