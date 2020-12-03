<?php
    include_once(dirname(__FILE__) . "/../Database.php");
    include_once(dirname(__FILE__) . "/../Data/buidata.php");
    include_once(dirname(__FILE__) . "/func/getPop.php");

    function resourceRequiredbcom($wid, $id, $tid)
    {
        $name = "bid" . $tid;
        global $$name,$database;
        $dataarray = $$name;
        $vilres = $database->getResourceLevel($wid);
        if (isset($dataarray[$vilres['f' . $id] + 1])) {
            $pop = $dataarray[$vilres['f' . $id] + 1]['pop'];
            $cp = $dataarray[$vilres['f' . $id] + 1]['cp'];
            return array("pop" => $pop, "cp" => $cp);
        }
    }

    function buildComplete()
    {
        global $database, $session, $bid18, $bid10, $bid11, $bid38, $bid39;
        if (!$database->checkConnection()) {
            throw new Exception(__FILE__ . ' cant connect to database.');
        }
        $time = time();
        $array = array();
        $q = "SELECT `id`,`wid`,`field`,`level`,`type` FROM " . TB_PREFIX . "bdata where timestamp <= $time";
        $array = $database->query_return($q);
        foreach ($array as $indi) {
            $q = "UPDATE " . TB_PREFIX . "fdata set f" . $indi['field'] . " = " . $indi['level'] . ", f" . $indi['field'] . "t = " . $indi['type'] . " where vref = " . $indi['wid'];
            if ($indi['level'] == 100 && $indi['type'] == 40) {
                $cfg = $database->query_return("SELECT `winmoment` FROM " . TB_PREFIX . "config");
                if ($cfg[0]['winmoment'] <= 0) {
                    $database->query("UPDATE " . TB_PREFIX . "config set winmoment = " . time());
                }
                $dbs = mysql_connect('localhost', $AppConfig['md']['user'], $AppConfig['md']['password']);
                mysql_select_db($AppConfig['md']['database'], $dbs);
                $wid = $indi['wid'];
                $user = $database->query_return("SELECT `owner` FROM " . TB_PREFIX . "vdata WHERE wref = '$wid'");
                $user = $user[0]['owner'];
                $email = $database->query_return("SELECT `email` FROM " . TB_PREFIX . "users WHERE id = '$user'");
                $email = $email[0]['email'];
                mysql_query("INSERT INTO medal (id,userid,categorie,status,email,img) VALUES ('', '" . $user . "', 'winner', '" . sv_ . "', '" . $email . "', 'tw') ");
                mysql_close($dbs);
                mysql_connect(SQL_SERVER, SQL_USER, SQL_PASS);
                mysql_select_db(SQL_DB);
            }
            if ($database->query($q)) {
                $resource = resourceRequiredbcom($indi['wid'], $indi['field'], $indi['type']);
                $database->modifyPop($indi['wid'], $resource['pop'], 0);
                $database->addCP($indi['wid'], $resource['cp']);
                $level = $database->getFieldLevel($indi['wid'], $indi['field']);
                //$pop = getPop($indi['type'], ($level - 1));
                //$database->modifyPop($indi['wid'], $pop[0], 0);
                //$database->addCP($indi['wid'], $pop[1] / 200);
                if ($indi['type'] == 18) {
                    $owner = $database->getVillageField($indi['wid'], "owner");
                    $max = $bid18[$level]['attri'];
                    $q = "UPDATE " . TB_PREFIX . "alidata set max = $max where leader = $owner";
                    $database->query($q);
                }

                if ($indi['type'] == 10) {
                    $max = $database->getVillageField($indi['wid'], "maxstore");
                    if ($level == '1' && $max == STORAGE_BASE) {
                        $max -= STORAGE_BASE;
                    }
                    if ($level > 1) $max -= $bid10[$level - 1]['attri'] * STORAGE_MULTIPLIER;
                    $max += $bid10[$level]['attri'] * STORAGE_MULTIPLIER;
                    $database->setVillageField($indi['wid'], "maxstore", $max);
                }

                if ($indi['type'] == 11) {
                    $max = $database->getVillageField($indi['wid'], "maxcrop");
                    if ($level == '1' && $max == STORAGE_BASE) {
                        $max -= STORAGE_BASE;
                    }
                    if ($level > 1) $max -= $bid11[$level - 1]['attri'] * STORAGE_MULTIPLIER;
                    $max += $bid11[$level]['attri'] * STORAGE_MULTIPLIER;
                    $database->setVillageField($indi['wid'], "maxcrop", $max);
                }
                if ($indi['type'] == 38) {
                    $max = $database->getVillageField($indi['wid'], "maxstore");
                    if ($level == '1' && $max == STORAGE_BASE) {
                        $max -= STORAGE_BASE;
                    }
                    if ($level > 1) $max -= $bid38[$level - 1]['attri'] * STORAGE_MULTIPLIER;
                    $max += $bid38[$level]['attri'] * STORAGE_MULTIPLIER;
                    $database->setVillageField($indi['wid'], "maxstore", $max);
                }

                if ($indi['type'] == 39) {
                    $max = $database->getVillageField($indi['wid'], "maxcrop");
                    if ($level == '1' && $max == STORAGE_BASE) {
                        $max -= STORAGE_BASE;
                    }
                    if ($level > 1) $max -= $bid39[$level - 1]['attri'] * STORAGE_MULTIPLIER;
                    $max += $bid39[$level]['attri'] * STORAGE_MULTIPLIER;
                    $database->setVillageField($indi['wid'], "maxcrop", $max);
                }

                $q4 = "UPDATE " . TB_PREFIX . "bdata set loopcon = 0 where loopcon = 1 and wid = " . $indi['wid'];
                $database->query($q4);
                $q = "DELETE FROM " . TB_PREFIX . "bdata where id = " . $indi['id'];
                $database->query($q);
            }
        }
    }

?>
