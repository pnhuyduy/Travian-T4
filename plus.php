<?php
/**********************************************
/ All Of the Copy Rights Of The Script Is Reserved For vikings.ir
/	You may have made some changes but You Have No Right To remove This Copy Right!
/	For Debug And Support Just Contact Me :09335751872 just sms
/	Yahoo ID: gorz1872@yahoo.com
/
*/
    include("GameEngine/Protection.php");
    // include("GameEngine/Session.php");
    include("GameEngine/Village.php");

    if ($session->access < 2) {
        header("Location: banned.php");
        die;
    }

    $start = $generator->pageLoadTimeStart();
    if (isset($_GET['ok'])) {
        $database->updateUserField($session->username, 'ok', '0', '0');
        $_SESSION['ok'] = '0';
    }
    if (isset($_GET['newdid'])) {
        $_SESSION['wid'] = $_GET['newdid'];
        header("Location: " . $_SERVER['PHP_SELF']);
    } else {
        $building->procBuild($_GET);
    }

    //Retrieve the current date/time
    $date2 = strtotime("NOW");

    $plusConfig = array(
        'crop'           => array(
            'duration' => 2 * 21600,
            'cost'     => 25
        ),
        'resources'      => array(
            'duration' => 0,
            'cost'     => 100
        ),
        'maxLvl'         => array(
            'duration' => 0,
            'cost'     => 60
        ),
        'maxRallyPoint'  => array(
            'duration' => 0,
            'cost'     => 15
        ),
        'att'            => array(
            'duration' => 1 * 21600,
            'cost'     => 30
        ),
        'def'            => array(
            'duration' => 1 * 21600,
            'cost'     => 30
        ),
        'speed'          => array(
            'cost' => 15
        ),
        'warehouse'      => array(
            'duration' => 1 * 21600,
            'cost'     => 10
        ),
        'Granary'        => array(
            'duration' => 1 * 21600,
            'cost'     => 10
        ),
        'FinishBuilding' => array(
            'duration' => 'instant',
            'cost'     => 3
        ),
        'FinishTraining' => array(
            'duration' => 'instant',
            'cost'     => 15
        ),
        'Culture'        => array(
            'cost' => 30
        ),
        'Fillres'        => array(
            'cost' => 70
        ),
        'FillresAllvil'  => array(
            'cost' => 100
        ),
        'an1'            => array(
            'an1_1'  => 900,
            'an1_2'  => 900,
            'an1_3'  => 900,
            'an1_4'  => 900,
            'an1_5'  => 900,
            'an1_6'  => 900,
            'an1_7'  => 900,
            'an1_8'  => 90,
            'an1_9'  => 90,
            'an1_10' => 90,
            'cost'   => 5
        ),
        'an2'            => array(
            'an2_1'  => 2250,
            'an2_2'  => 2250,
            'an2_3'  => 2250,
            'an2_4'  => 2250,
            'an2_5'  => 2250,
            'an2_6'  => 2250,
            'an2_7'  => 2250,
            'an2_8'  => 225,
            'an2_9'  => 225,
            'an2_10' => 225,
            'cost'   => 10
        ),
        'an3'            => array(
            'an3_1'  => 5400,
            'an3_2'  => 5400,
            'an3_3'  => 5400,
            'an3_4'  => 5400,
            'an3_5'  => 5400,
            'an3_6'  => 5400,
            'an3_7'  => 5400,
            'an3_8'  => 540,
            'an3_9'  => 540,
            'an3_10' => 540,
            'cost'   => 15
        ),
        'an4'            => array(
            'an4_1'  => 7650,
            'an4_2'  => 7650,
            'an4_3'  => 7650,
            'an4_4'  => 7650,
            'an4_5'  => 7650,
            'an4_6'  => 7650,
            'an4_7'  => 7650,
            'an4_8'  => 765,
            'an4_9'  => 765,
            'an4_10' => 765,
            'cost'   => 20
        ),
        'an5'            => array(
            'an5_1'  => 14500,
            'an5_2'  => 14500,
            'an5_3'  => 14500,
            'an5_4'  => 14500,
            'an5_5'  => 14500,
            'an5_6'  => 14500,
            'an5_7'  => 14500,
            'an5_8'  => 1450,
            'an5_9'  => 1450,
            'an5_10' => 1450,
            'cost'   => 35
        ),
        'an6'            => array(
            'an6_1'  => 31500,
            'an6_2'  => 31500,
            'an6_3'  => 31500,
            'an6_4'  => 31500,
            'an6_5'  => 31500,
            'an6_6'  => 31500,
            'an6_7'  => 31500,
            'an6_8'  => 3150,
            'an6_9'  => 3150,
            'an6_10' => 3150,
            'cost'   => 65
        ),

        'tr1'            => array(
            'tr1_1'  => 1000,
            'tr1_2'  => 1000,
            'tr1_3'  => 1000,
            'tr1_4'  => 1000,
            'tr1_5'  => 1000,
            'tr1_6'  => 1000,
            'tr1_7'  => 1000,
            'tr1_8'  => 100,
            'tr1_9'  => 0,
            'tr1_10' => 0,
            'cost'   => 5
        ),
        'tr2'            => array(
            'tr2_1'  => 2500,
            'tr2_2'  => 2500,
            'tr2_3'  => 2500,
            'tr2_4'  => 2500,
            'tr2_5'  => 2500,
            'tr2_6'  => 2500,
            'tr2_7'  => 2500,
            'tr2_8'  => 250,
            'tr2_9'  => 0,
            'tr2_10' => 0,
            'cost'   => 10
        ),
        'tr3'            => array(
            'tr3_1'  => 6000,
            'tr3_2'  => 6000,
            'tr3_3'  => 6000,
            'tr3_4'  => 6000,
            'tr3_5'  => 6000,
            'tr3_6'  => 6000,
            'tr3_7'  => 6000,
            'tr3_8'  => 600,
            'tr3_9'  => 0,
            'tr3_10' => 0,
            'cost'   => 15
        ),
        'tr4'            => array(
            'tr4_1'  => 8500,
            'tr4_2'  => 8500,
            'tr4_3'  => 8500,
            'tr4_4'  => 8500,
            'tr4_5'  => 8500,
            'tr4_6'  => 8500,
            'tr4_7'  => 8500,
            'tr4_8'  => 850,
            'tr4_9'  => 0,
            'tr4_10' => 0,
            'cost'   => 20
        ),
        'tr5'            => array(
            'tr5_1'  => 15000,
            'tr5_2'  => 15000,
            'tr5_3'  => 15000,
            'tr5_4'  => 15000,
            'tr5_5'  => 15000,
            'tr5_6'  => 15000,
            'tr5_7'  => 15000,
            'tr5_8'  => 1500,
            'tr5_9'  => 0,
            'tr5_10' => 0,
            'cost'   => 35
        ),
        'tr6'            => array(
            'tr6_1'  => 35000,
            'tr6_2'  => 35000,
            'tr6_3'  => 35000,
            'tr6_4'  => 35000,
            'tr6_5'  => 35000,
            'tr6_6'  => 35000,
            'tr6_7'  => 35000,
            'tr6_8'  => 3500,
            'tr6_9'  => 0,
            'tr6_10' => 0,
            'cost'   => 65
        ),

    );
    /*
     * V3 => 300T
     * plus V4 => 80T
     * fix Bug => 50T
     * Automation => 100T
     * Anti SPAM => 15T
     * Paypal => 100T
     * status => 20T
     * hero bug fix => 100T
     * training bug fix => 50T
     * goriz: 150T
     */


    function hasGold($cost)
    {
        global $session;

        return $session->gold >= $cost;
    }

    function travian_redirect($url, $seconds = 0)
    {
        if ($seconds) {
            return TRUE;
        }
        header("Location: " . $url);
        exit(0);
    }

    if (!$winner) {

        if (isset($_GET['id'])) {
            if ($session->is_sitter == 1) {
                $setting = $database->getUsersetting($session->uid);
                $who = $database->whoissitter($session->uid);

                if ($who['whosit_sit'] == 1) {
                    $settings = $setting['sitter1_set_4'];
                } else if ($who['whosit_sit'] == 2) {
                    $settings = $setting['sitter2_set_4'];
                }
            }
            if (($settings == 1 || $session->is_sitter != 1)) {
                $cost = $plusConfig[$_GET['id']]['cost'];
                $duration = $plusConfig[$_GET['id']]['duration'];
                switch ($_GET['id']) {
                    case 'warehouse':
                        if (hasGold($cost)) {
                            $database->modifyExtraVillage($village->wid, 'extra_maxstore', 80000 * STORAGE_MULTIPLIER);
                            $database->modifyGold($session->uid, $cost, 0);
                            updateWrefResource($village->wid);
                            travian_redirect('plus.php?id=3');
                        }
                        break;
                    case 'Granary':
                        if (hasGold($cost)) {
                            $database->modifyExtraVillage($village->wid, 'extra_maxcrop', 80000 * STORAGE_MULTIPLIER);
                            $database->modifyGold($session->uid, $cost, 0);
                            updateWrefResource($village->wid);
                            travian_redirect('plus.php?id=3');
                        }
                        break;
                    case 'att':
                        if (hasGold($cost)) {
                            if ($session->userinfo['att'] > time()) {
                                $database->modifyUser($session->uid, 'att', $session->userinfo['att'] + $duration);
                            } else {
                                $database->modifyUser($session->uid, 'att', time() + $duration);
                            }
                            $database->modifyGold($session->uid, $cost, 0);
                            travian_redirect('plus.php?id=3');
                        }
                        break;
                    case 'def':
                        if (hasGold($cost)) {
                            if ($session->userinfo['def'] > time()) {
                                $database->modifyUser($session->uid, 'def', $session->userinfo['def'] + $duration);
                            } else {
                                $database->modifyUser($session->uid, 'def', time() + $duration);
                            }
                            $database->modifyGold($session->uid, $cost, 0);
                            travian_redirect('plus.php?id=3');
                        }
                        break;
                    // case 'speed':
                    // if(hasGold($cost)){
                    // if($session->userinfo['speed'] > time()){
                    // $database->modifyUser($session->uid, 'speed', $session->userinfo['speed'] + $duration);
                    // } else {
                    // $database->modifyUser($session->uid, 'speed', time() + $duration);
                    // }
                    // $database->modifyGold($session->uid, $cost, 0);
                    // travian_redirect('plus.php?id=3');
                    // }
                    // break;
                    // case 'crop':
                    // if(hasGold($cost)){
                    // if($session->bonus5){
                    // $database->modifyUser($session->uid, 'b5', $session->userinfo['b5'] + $duration);
                    // } else {
                    // $database->modifyUser($session->uid, 'b5', time() + $duration);
                    // }
                    // $database->modifyGold($session->uid, $cost, 0);
                    // updateWrefResource($village->wid);
                    // travian_redirect('plus.php?id=3');
                    // }
                    // break;
                    case 'resources':
                        if (hasGold($cost) && !$village->natar) {
                            $database->modifyResource($village->wid, $village->getProd('wood'), $village->getProd('clay'), $village->getProd('iron'), $village->getProd('crop'), TRUE);
                            $database->modifyGold($session->uid, $cost, 0);
                            travian_redirect('plus.php?id=3');
                        }
                        break;
                    /*case 'Fillres':
                        if (hasGold($cost) && !$village->natar) {
                            $database->modifyResource($village->wid, $village->maxstore, $village->maxstore, $village->maxstore, $village->maxcrop, TRUE);
                            $database->modifyGold($session->uid, $cost, 0);
                            travian_redirect('plus.php?id=3');
                        }
                        break;
                    case 'FillresAllvil':
                        if (hasGold($cost) && !$village->natar) {
                            $varray = $database->getProfileVillages($session->uid);
                            var_dump($varray);
                            foreach ($varray as $vil) {
                                $database->modifyResource($vil['wref'], $vil['maxstore'], $vil['maxstore'], $vil['maxstore'], $vil['maxcrop'], TRUE);
                            }
                            $database->modifyGold($session->uid, $cost, 0);
                            travian_redirect('plus.php?id=3');
                        }
                        break;*/
                    case 'maxLvl':
                        if (hasGold($cost)) {
                            $buildings = $database->getResourceLevel($village->wid);
                            $Levels = 0;
                            $pop = $cp = 0;
                            for ($i = 1 + $RPA_LEVEL; $i <= 20; ++$i) {
                                $pop += $bid16[$i]['pop'];
                                $cp += $bid16[$i]['cp'];
                            }
                            for ($i = 1; $i <= 18; ++$i) {
                                $uLevel = 20 - $buildings['f' . $i];
                                if (!$uLevel) continue;
                                $Levels += $uLevel;
                                for ($j = 1 + $buildings['f' . $i]; $j <= 20; ++$j) {
                                    $pop += $GLOBALS['bid' . $i][$j]['pop'];
                                    $cp += $GLOBALS['bid' . $i][$j]['cp'];
                                }
                                $database->modifyFieldLevel($village->wid, $i, $uLevel, TRUE);
                            }
                            if ($Levels) {
                                $database->modifyPop($village->wid, $pop, 0);
                                $database->addCP($village->wid, $cp);
                                $database->modifyGold($session->uid, $cost, 0);
                                updateWrefResource($village->wid);
                            }
                            travian_redirect('plus.php?id=3');
                        }
                        break;

                    case 'maxRallyPoint':
                        if (hasGold($cost)) {
                            $RPA_LEVEL = $database->getFieldLevel($village->wid, 39);
                            if (20 - $RPA_LEVEL) {
                                global $bid16;
                                $pop = $cp = 0;
                                for ($i = 1 + $RPA_LEVEL; $i <= 20; ++$i) {
                                    $pop += $bid16[$i]['pop'];
                                    $cp += $bid16[$i]['cp'];
                                }
                                $database->modifyPop($village->wid, $pop, 0);
                                $database->addCP($village->wid, $cp);
                                $database->modifyFieldType($village->wid, 39, 16);
                                $database->modifyFieldLevel($village->wid, 39, 20 - $RPA_LEVEL, TRUE);
                                $database->modifyGold($session->uid, $cost, 0);
                            }
                            travian_redirect('plus.php?id=3');
                        }
                        break;
                    case 'FinishBuilding':
                        if (hasGold($cost)) {
                            $MyVilId = mysql_query("SELECT id FROM " . TB_PREFIX . "bdata WHERE `wid`='" . $village->wid . "'") or die(mysql_error());
                            $uuVilid = mysql_fetch_array($MyVilId);
                            $MyVilId2 = mysql_query("SELECT id FROM " . TB_PREFIX . "research WHERE `vref`='" . $village->wid . "'") or die(mysql_error());
                            $uuVilid2 = mysql_fetch_array($MyVilId2);

                            $buildnum = mysql_num_rows($MyVilId);
                            $resnum = mysql_num_rows($MyVilId2);

                            $goldlog = mysql_query("SELECT id FROM " . TB_PREFIX . "gold_fin_log") or die(mysql_error());

                            if (mysql_num_rows($MyVilId) || mysql_num_rows($MyVilId2)) {

                                mysql_query("UPDATE " . TB_PREFIX . "bdata set timestamp = '1' where wid = " . $village->wid . " AND type != '25' OR type != '26' OR type != '40'") or die(mysql_error());
                                mysql_query("UPDATE " . TB_PREFIX . "research set timestamp = '1' where vref = '" . $village->wid . "'") or die(mysql_error());


                                $done1 = "<b>" . $buildnum . "</b> Buildings <b>" . $resnum . "</b> And researches finished";
                                $database->modifyGold($session->uid, $cost, 0);
                                mysql_query("INSERT INTO " . TB_PREFIX . "gold_fin_log VALUES ('" . (mysql_num_rows($goldlog) + 1) . "', '" . $village->wid . "', 'Finish construction and research with gold')") or die(mysql_error());

                            } else {
                                mysql_query("INSERT INTO " . TB_PREFIX . "gold_fin_log VALUES ('" . (mysql_num_rows($goldlog) + 1) . "', '" . $village->wid . "', 'Failed construction and research with gold')") or die(mysql_error());

                            }
                        }
                        break;
                    case 'FinishTraining':
                        if (hasGold($cost)) {
                            $golds = $database->getUser($session->username, 0);
                            $MyVilId = mysql_query("SELECT * FROM " . TB_PREFIX . "training WHERE `vref`='" . $village->wid . "'") or die(mysql_error());
                            $uuVilid = mysql_fetch_array($MyVilId);

                            $buildnum = mysql_num_rows($MyVilId);

                            $goldlog = mysql_query("SELECT * FROM " . TB_PREFIX . "gold_fin_log") or die(mysql_error());

                            if (mysql_num_rows($MyVilId)) {

                                mysql_query("UPDATE " . TB_PREFIX . "training set eachtime = '1', timestamp = '1', commence = '1' where `vref` = " . $village->wid . "") or die(mysql_error());

                                $done1 = "Train <b>" . $buildnum . "</b> Troops finished";
                                $database->modifyGold($session->uid, $cost, 0);
                                mysql_query("INSERT INTO " . TB_PREFIX . "gold_fin_log VALUES ('" . (mysql_num_rows($goldlog) + 1) . "', '" . $village->wid . "', 'Finish training with gold')") or die(mysql_error());

                            } else {
                                mysql_query("INSERT INTO " . TB_PREFIX . "gold_fin_log VALUES ('" . (mysql_num_rows($goldlog) + 1) . "', '" . $village->wid . "', 'Failed training with gold')") or die(mysql_error());

                            }
                        }
                        break;
                    case 'Culture':
                        if (hasGold($cost)) {

                            $goldlog = mysql_query("SELECT * FROM " . TB_PREFIX . "gold_fin_log") or die(mysql_error());

                            mysql_query("UPDATE " . TB_PREFIX . "users set cp = cp + 500 where `id` = " . $session->uid . "") or die(mysql_error());

                            $database->modifyGold($session->uid, $cost, 0);
                            mysql_query("INSERT INTO " . TB_PREFIX . "gold_fin_log VALUES ('" . (mysql_num_rows($goldlog) + 1) . "', '" . $village->wid . "', 'buy Culture point with gold')") or die(mysql_error());

                        }
                        break;
                    case 'an1':
                        if (hasGold($cost)) {
                            $c_counter = 31;
                            for ($i = 1; $i <= 10; $i++) {
                                $caged[$c_counter] = $plusConfig[$_GET['id']]['an1_' . $i];
                                $c_counter++;
                            }
                            // print_r($caged);
                            $ref = $database->addAttack($village->wid, $caged[31], $caged[32], $caged[33], $caged[34], $caged[35], $caged[36], $caged[37], $caged[38], $caged[39], $caged[40], 0, 2, 0, 0, 0);
                            $database->addMovement(3, 20202, $village->wid, $ref, '0,0,0,0,0', time() + 300);
                            $database->modifyGold($session->uid, $cost, 0);
                        }
                        break;
                    case 'an2':
                        if (hasGold($cost)) {
                            $c_counter = 31;
                            for ($i = 1; $i <= 10; $i++) {
                                $caged[$c_counter] = $plusConfig[$_GET['id']]['an2_' . $i];
                                $c_counter++;
                            }
                            // print_r($caged);
                            $ref = $database->addAttack($village->wid, $caged[31], $caged[32], $caged[33], $caged[34], $caged[35], $caged[36], $caged[37], $caged[38], $caged[39], $caged[40], 0, 2, 0, 0, 0);
                            $database->addMovement(3, 20202, $village->wid, $ref, '0,0,0,0,0', time() + 300);
                            $database->modifyGold($session->uid, $cost, 0);
                        }
                        break;
                    case 'an3':
                        if (hasGold($cost)) {
                            $c_counter = 31;
                            for ($i = 1; $i <= 10; $i++) {
                                $caged[$c_counter] = $plusConfig[$_GET['id']]['an3_' . $i];
                                $c_counter++;
                            }
                            // print_r($caged);
                            $ref = $database->addAttack($village->wid, $caged[31], $caged[32], $caged[33], $caged[34], $caged[35], $caged[36], $caged[37], $caged[38], $caged[39], $caged[40], 0, 2, 0, 0, 0);
                            $database->addMovement(3, 20202, $village->wid, $ref, '0,0,0,0,0', time() + 300);
                            $database->modifyGold($session->uid, $cost, 0);
                        }
                        break;
                    case 'an4':
                        if (hasGold($cost)) {
                            $c_counter = 31;
                            for ($i = 1; $i <= 10; $i++) {
                                $caged[$c_counter] = $plusConfig[$_GET['id']]['an4_' . $i];
                                $c_counter++;
                            }
                            // print_r($caged);
                            $ref = $database->addAttack($village->wid, $caged[31], $caged[32], $caged[33], $caged[34], $caged[35], $caged[36], $caged[37], $caged[38], $caged[39], $caged[40], 0, 2, 0, 0, 0);
                            $database->addMovement(3, 20202, $village->wid, $ref, '0,0,0,0,0', time() + 300);
                            $database->modifyGold($session->uid, $cost, 0);
                        }
                        break;
                    case 'an5':
                        if (hasGold($cost)) {
                            $c_counter = 31;
                            for ($i = 1; $i <= 10; $i++) {
                                $caged[$c_counter] = $plusConfig[$_GET['id']]['an5_' . $i];
                                $c_counter++;
                            }
                            // print_r($caged);
                            $ref = $database->addAttack($village->wid, $caged[31], $caged[32], $caged[33], $caged[34], $caged[35], $caged[36], $caged[37], $caged[38], $caged[39], $caged[40], 0, 2, 0, 0, 0);
                            $database->addMovement(3, 20202, $village->wid, $ref, '0,0,0,0,0', time() + 300);
                            $database->modifyGold($session->uid, $cost, 0);
                        }
                        break;
                    case 'an6':
                        if (hasGold($cost)) {
                            $c_counter = 31;
                            for ($i = 1; $i <= 10; $i++) {
                                $caged[$c_counter] = $plusConfig[$_GET['id']]['an6_' . $i];
                                $c_counter++;
                            }
                            // print_r($caged);
                            $ref = $database->addAttack($village->wid, $caged[31], $caged[32], $caged[33], $caged[34], $caged[35], $caged[36], $caged[37], $caged[38], $caged[39], $caged[40], 0, 2, 0, 0, 0);
                            $database->addMovement(3, 20202, $village->wid, $ref, '0,0,0,0,0', time() + 300);
                            $database->modifyGold($session->uid, $cost, 0);
                        }
                        break;
                    /*case 'tr1':
                        if (hasGold($cost)) {
                            $start = ($session->tribe - 1) * 10 + 1;
                            $end = ($session->tribe * 10);
                            $c_counter = 31;
                            $t = 1;
                            for ($i = $start; $i <= $end; $i++) {
                                $database->modifyUnit($village->wid, $i, $plusConfig[$_GET['id']]['tr1_' . $t], 1);
                                $c_counter++;
                                $t++;
                            }
                            $database->modifyGold($session->uid, $cost, 0);
                        }
                        break;
                    case 'tr2':
                        if (hasGold($cost)) {
                            $start = ($session->tribe - 1) * 10 + 1;
                            $end = ($session->tribe * 10);
                            $c_counter = 31;
                            $t = 1;
                            for ($i = $start; $i <= $end; $i++) {
                                $database->modifyUnit($village->wid, $i, $plusConfig[$_GET['id']]['tr2_' . $t], 1);
                                $c_counter++;
                                $t++;
                            }
                            $database->modifyGold($session->uid, $cost, 0);
                        }
                        break;
                    case 'tr3':
                        if (hasGold($cost)) {
                            $start = ($session->tribe - 1) * 10 + 1;
                            $end = ($session->tribe * 10);
                            $c_counter = 31;
                            $t = 1;
                            for ($i = $start; $i <= $end; $i++) {
                                $database->modifyUnit($village->wid, $i, $plusConfig[$_GET['id']]['tr3_' . $t], 1);
                                $c_counter++;
                                $t++;
                            }
                            $database->modifyGold($session->uid, $cost, 0);
                        }
                        break;
                    case 'tr4':
                        if (hasGold($cost)) {
                            $start = ($session->tribe - 1) * 10 + 1;
                            $end = ($session->tribe * 10);
                            $c_counter = 31;
                            $t = 1;
                            for ($i = $start; $i <= $end; $i++) {
                                $database->modifyUnit($village->wid, $i, $plusConfig[$_GET['id']]['tr4_' . $t], 1);
                                $c_counter++;
                                $t++;
                            }
                            $database->modifyGold($session->uid, $cost, 0);
                        }
                        break;
                    case 'tr5':
                        if (hasGold($cost)) {
                            $start = ($session->tribe - 1) * 10 + 1;
                            $end = ($session->tribe * 10);
                            $c_counter = 31;
                            $t = 1;
                            for ($i = $start; $i <= $end; $i++) {
                                $database->modifyUnit($village->wid, $i, $plusConfig[$_GET['id']]['tr5_' . $t], 1);
                                $c_counter++;
                                $t++;
                            }
                            $database->modifyGold($session->uid, $cost, 0);
                        }
                        break;
                    case 'tr6':
                        if (hasGold($cost)) {
                            $start = ($session->tribe - 1) * 10 + 1;
                            $end = ($session->tribe * 10);
                            $c_counter = 31;
                            $t = 1;
                            for ($i = $start; $i <= $end; $i++) {
                                $database->modifyUnit($village->wid, $i, $plusConfig[$_GET['id']]['tr6_' . $t], 1);
                                $c_counter++;
                                $t++;
                            }
                            $database->modifyGold($session->uid, $cost, 0);
                        }
                        break;
                        */
                }

                switch ($_GET['id']) {
                    case 'warehouse':
                    case 'Granary':
                    case 'att':
                    case 'def':
                    case 'resources':
                    case 'maxLvl':
                    case 'maxRallyPoint':
                    case 'FinishBuilding':
                    case 'FinishTraining':
                    case 'Culture':
                    case 'an1':
                    case 'an2':
                    case 'an3':
                    case 'an4':
                    case 'an5':
                    case 'an6':
                        header("Location: plus.php");
                        break;
                    case 'tr1':
                    case 'tr2':
                    case 'tr3':
                    case 'tr4':
                    case 'tr5':
                    case 'tr6':
                        header("Location: plus.php");
                        //header("Location: plus.php?selltroops=go");
                        break;
                }


                if (isset($plusConfig[$_GET['id']])) {
                    $_GET['id'] = 3;
                }
            } else {
                $error = "<center><font color=red>".AL_NOPERM."</font></center>";
            }
        }

    }

    include "Templates/html.tpl";
?>
<body class="v35 gecko statistics perspectiveBuildings">
<script type="text/javascript">
    window.ajaxToken = '<?php echo md5($_REQUEST['SERVER_TIME']);?>';
</script>
<div id="background">
    <div id="headerBar"></div>
    <div id="bodyWrapper">
        <img style="filter:chroma();" src="img/x.gif" id="msfilter" alt=""/>

        <?php
            include('Templates/Header.tpl');
        ?>
        <div id="center">
            <a id="ingameManual" href="help.php">
                <img class="question" alt="Help" src="img/x.gif">
            </a>

            <div id="sidebarBeforeContent" class="sidebar beforeContent">
                <?php
                    include('Templates/heroSide.tpl');
                    include('Templates/Alliance.tpl');
                    include('Templates/infomsg.tpl');
                    include('Templates/links.tpl');
                ?>
                <div class="clear"></div>
            </div>
            <div id="contentOuterContainer">
                <?php include('Templates/res.tpl'); ?>
                <div class="contentTitle">
                    <a id="closeContentButton" class="contentTitleButton" href="dorf1.php" title="<?php echo BL_CLOSE;?>">
                        &nbsp;</a>
                    <a id="answersButton" class="contentTitleButton" href="http://t4.answers.travian.com/"
                       target="_blank"
                       title="<?php echo BL_TRAVIANANS;?>">&nbsp;</a>
                </div>
                <div class="contentContainer"><?php echo $error; ?>
                    <div id="content" class="plus">
                        <?php if (!$_GET || $_GET['id'] == 3) { ?>
                            <div class="contentNavi subNavi">
                                <div title="" class="container <?php if (isset($_GET['banker'])) {
                                    echo "active";
                                } else {
                                    echo "normal";
                                } ?>">
                                    <div class="background-start">&nbsp;</div>
                                    <div class="background-end">&nbsp;</div>
                                    <div class="content"><a href="plus.php?bank"><span
                                                class="tabItem">&#1576;&#1575;&#1606;&#1705; &#1591;&#1604;&#1575;</span></a></div>
                                </div>
                                <div title="" class="container <?php if (isset($_GET['bank'])) {
                                    echo "active";
                                } else {
                                    echo "normal";
                                } ?>">
                                    <div class="background-start">&nbsp;</div>
                                    <div class="background-end">&nbsp;</div>
                                    <div class="content"><a href="plus.php?banker"><span class="tabItem">&#1576;&#1575;&#1586;&#1740;&#1575;&#1576;&#1740; &#1591;&#1604;&#1575;</span></a>
                                    </div>
                                </div>
                                <div class="clear"></div>
                            </div>
                        <?php } ?>
                        <script type="text/javascript">
                            window.addEvent('domready', function () {
                                $$('.subNavi').each(function (element) {
                                    new Travian.Game.Menu(element);
                                });
                            });
                        </script>
                        <?php
                            if (isset($_GET['bank']))
                                include("Templates/Plus/bank.tpl");
                            elseif (isset($_GET['banker']))
                                include("Templates/Plus/banker.tpl");
                            //elseif (isset($_GET['selltroops']))
                            //include("Templates/Plus/selltroops.tpl");
                            else
                                include("Templates/Plus/3.tpl");

                        ?>
                    </div>
                    <div class="clear"></div>
                </div>
                <div class="contentFooter">&nbsp;</div>
            </div>
            <div id="sidebarAfterContent" class="sidebar afterContent">
                <div id="sidebarBoxActiveVillage" class="sidebarBox ">
                    <div class="sidebarBoxBaseBox">
                        <div class="baseBox baseBoxTop">
                            <div class="baseBox baseBoxBottom">
                                <div class="baseBox baseBoxCenter"></div>
                            </div>
                        </div>
                    </div>
                    <?php include 'Templates/sideinfo.tpl'; ?>
                </div>
                <?php
                    include 'Templates/multivillage.tpl';
                    include 'Templates/quest.tpl';
                ?>
            </div>
            <div class="clear"></div>
            &#65279;<?php
                include 'Templates/footer.tpl';
            ?>
        </div>
        <div id="ce"></div>
    </div>
</body>
</html>