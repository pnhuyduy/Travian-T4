<?php

    class Units
    {
        public $sending, $recieving, $return = array();

        public function procUnits($post)
        {
            global $session, $database;
            if (isset($post['c'])) {
                switch ($post['c']) {
                    case 1:
                        if (isset($post['a']) && $post['a'] == 533374) {
                            $this->sendTroops($post);
                        } else {
                            $post = $this->loadUnits($post);

                            return $post;
                        }
                        break;
                    case 2:
                        if ($session->is_sitter == 1) {
                            $setting = $database->getUsersetting($session->uid);
                            $who = $database->whoissitter($session->uid);
                            switch ($who['whosit_sit']) {
                                case 1:
                                    $settings = $setting['sitter1_set_2'];
                                    break;
                                case 2:
                                    $settings = $setting['sitter2_set_2'];
                                    break;
                            }
                        }
                        if ((isset($settings) && $settings == 1) || $session->is_sitter != 1) {
                            if (isset($post['a']) && $post['a'] == 533374) {
                                $this->sendTroops($post);
                            } else {
                                $post = $this->loadUnits($post);

                                return $post;
                            }
                        }
                        break;
                    case 8:
                        $this->sendTroopsBack($post);
                        break;
                    case 3:
                        if ($session->is_sitter == 1) {
                            $setting = $database->getUsersetting($session->uid);
                            $who = $database->whoissitter($session->uid);
                            switch ($who['whosit_sit']) {
                                case 1:
                                    $settings = $setting['sitter1_set_1'];
                                    break;
                                case 2:
                                    $settings = $setting['sitter2_set_1'];
                                    break;
                            }
                        }
                        if ((isset($settings) && $settings == 1) || $session->is_sitter != 1) {
                            if (isset($post['a']) && $post['a'] == 533374) {
                                $this->sendTroops($post);
                            } else {
                                $post = $this->loadUnits($post);

                                return $post;
                            }
                        }
                        break;
                    case 4:
                        if ($session->is_sitter == 1) {
                            $setting = $database->getUsersetting($session->uid);
                            $who = $database->whoissitter($session->uid);
                            switch ($who['whosit_sit']) {
                                case 1:
                                    $settings = $setting['sitter1_set_1'];
                                    break;
                                case 2:
                                    $settings = $setting['sitter2_set_1'];
                                    break;
                            }
                        }
                        if ((isset($settings) && $settings == 1) || $session->is_sitter != 1) {
                            if (isset($post['a']) && $post['a'] == 533374) {
                                $this->sendTroops($post);
                            } else {
                                $post = $this->loadUnits($post);

                                return $post;
                            }
                        }
                        break;
                    case 5:
                        if (isset($post['a']) && $post['a'] == "new") {
                            $this->Settlers($post);
                        } else {
                            $post = $this->loadUnits($post);

                            return $post;
                        }
                        break;
                }
            }
        }

        private function sendTroops($post)
        {
            global $form, $database, $village, $generator, $session, $building;

            $data = $database->getA2b($post['timestamp_checksum'], $post['timestamp']);

            $tStarter = ($session->tribe - 1) * 10;
            for ($i = 1; $i <= 10; $i++) {
                if (isset($data['u' . $i])) {
                    $data['u' . $i] = intval($data['u' . $i]);
                    if ($data['u' . $i] > $village->unitarray['u' . ($tStarter + $i)]) {
                        $data['u' . $i] = $village->unitarray['u' . ($tStarter + $i)];
                    }
                    if ($data['u' . $i] < 0) {
                        $data['u' . $i] = 0;
                    }
                } else {
                    $data['u' . $i] = 0;
                }
            }
            $data['u11'] = intval($data['u11']);
            if ($data['u11'] >= $village->unitarray['hero']) {
                $data['u11'] = $village->unitarray['hero'];
            } else {
                $data['u11'] = 0;
            }
            $uc = 0;
            for ($i = 1; $i <= 11; $i++) {
                $uc += $data['u' . $i];
            }
            if ($uc <= 0) $form->addError("error", AT_A2BERRSELECT1TROOP);
            if ($form->returnErrors() > 0) {
                $_SESSION['errorarray'] = $form->getErrors();
                $_SESSION['valuearray'] = $_POST;
                $database->removeA2b($post['timestamp_checksum'], $post['timestamp']);
                header("Location: a2b.php?z=".$data['to_vid']);
                exit;
            } else {
                $tStarter = ($session->tribe - 1) * 10;
                for ($i = 1; $i <= 10; $i++) {
                    if ($data['u' . $i] > 0) {
                        $database->modifyUnit($village->wid, ($tStarter + $i), $data['u' . $i], 0);
                    }
                }
                if ($data['u11'] > 0) $database->modifyUnit($village->wid, "hero", $data['u11'], 0);

                $query21 = mysql_query('SELECT * FROM `' . TB_PREFIX . 'users` WHERE `id` = ' . $session->uid);
                $data21 = mysql_fetch_assoc($query21);

                $eigen = $database->getCoor($village->wid);
                $from = array('x' => $eigen['x'], 'y' => $eigen['y']);
                $ander = $database->getCoor($data['to_vid']);
                $to = array('x' => $ander['x'], 'y' => $ander['y']);
                //$start = ($data21['tribe'] - 1) * 10 + 1;
                //$end = ($data21['tribe'] * 10);

                $speeds = array();
                //$scout = 1;

                //find slowest unit.
                for ($i = 1; $i <= 10; $i++) {
                    if (isset($data['u' . $i])) {
                        if ($data['u' . $i] != '' && $data['u' . $i] > 0) {
                            if ($unitarray) {
                                reset($unitarray);
                            }
                            $unitarray = $GLOBALS["u" . (($session->tribe - 1) * 10 + $i)];
                            $speeds[] = $unitarray['speed'];
                        }
                    }
                }
                if (isset($data['u11'])) {
                    if ($data['u11'] != '' && $data['u11'] > 0) {
                        $heroarray = $database->getHero($session->uid);
                        $speeds[] = $heroarray['speed'] + $heroarray['itemspeed'];
                    }
                } else {
                    $heroarray = array();
                }

                $time = $generator->procDistanceTime($from, $to, min($speeds), 1, $heroarray);
                if (!isset($post['ctar1'])) {
                    $post['ctar1'] = 255;
                }
                if (!isset($post['ctar2'])) {
                    $post['ctar2'] = 255;
                }
                if ($session->tribe == 2 && $database->getCapBrewery($session->uid) > 0) {
                    if ($post['ctar1'] != 255) $post['ctar1'] = 0;
                    if ($post['ctar2'] != 255) $post['ctar2'] = 0;
                }
                $rallypoint = $building->getTypeLevel(16);

                if ($rallypoint < 3) {
                    if ($post['ctar1'] != 255) $post['ctar1'] = 0;
                } elseif ($rallypoint >= 3 && $rallypoint < 5) {
                    switch ($post['ctar1']) {
                        case 255:
                        case 10:
                        case 11:
                        case 38:
                        case 39:
                            break;
                        default:
                            $post['ctar1'] = 0;
                            break;
                    }
                } elseif ($rallypoint >= 5 && $rallypoint < 10) {
                    switch ($post['ctar1']) {
                        case 255:
                        case 1:
                        case 2:
                        case 3:
                        case 4:
                        case 5:
                        case 6:
                        case 7:
                        case 8:
                        case 9:
                            break;
                        default:
                            $post['ctar1'] = 0;
                            break;
                    }
                }

                if ($rallypoint < 20) {
                    $post['ctar2'] = 255;
                }
                $attacker_id = $database->getVillageField($village->wid, 'owner');
                $defender_id = $database->getVillageField($data['to_vid'], 'owner');

                $defender_name = $database->getVillageField($data['to_vid'], 'name');

                if ($database->hasBeginnerProtection($village->wid) == 1) {
                    if ($database->isVillageOases($data['to_vid']) == 0 && $attacker_id != $defender_id AND $defender_name != 'Farm Village') {
                        mysql_query('UPDATE `' . TB_PREFIX . 'users` set protect = 0 WHERE `id` = ' . $session->uid);
                    }
                }
                if (!isset($post['spy'])) {
                    $post['spy'] = 0;
                }
                $abdata = $database->getABTech($village->wid);
                $reference = $database->addAttack(($village->wid), $data['u1'], $data['u2'], $data['u3'], $data['u4'], $data['u5'], $data['u6'], $data['u7'], $data['u8'], $data['u9'], $data['u10'], $data['u11'], $data['type'], $post['ctar1'], $post['ctar2'], $post['spy'], $abdata['b1'], $abdata['b2'], $abdata['b3'], $abdata['b4'], $abdata['b5'], $abdata['b6'], $abdata['b7'], $abdata['b8']);

                $database->addMovement(3, $village->wid, $data['to_vid'], $reference, 0, ($time + time()));
                //$database->removeA2b($post['timestamp_checksum'], $post['timestamp']);

               /* if ($form->returnErrors() > 0) {
                    $_SESSION['errorarray'] = $form->getErrors();
                    $_SESSION['valuearray'] = $_POST;
                    header("Location: a2b.php");
                    exit;
                }*/

                header("Location: build.php?id=39");
                exit;
            }
        }

        private function loadUnits($post)
        {
            //var_dump($post);die;
            global $database, $village, $session, $generator, $form;
            // Busqueda por nombre de pueblo
            // Confirmamos y buscamos las coordenadas por nombre de pueblo
            if (!$post['dname'] && (!isset($post['x']) || !isset($post['y']))) {
                $form->addError("error", AT_A2BERRINSERTNAMECOOR);
            }
            if (isset($post['dname']) && $post['dname'] != "") {
                $id = $database->getVillageByName(stripslashes($post['dname']));
                if (!isset($id)) {
                    $form->addError("error", AT_A2BERRNOVILLAGE);
                } else {
                    $coor = $database->getCoor($id);
                    $post['x'] = $coor['x'];
                    $post['y'] = $coor['y'];
                }
            }

            // Busqueda por coordenadas de pueblo
            // Confirmamos y buscamos las coordenadas por coordenadas de pueblo
            if (isset($post['x']) && isset($post['y']) && $post['x'] != "" && $post['y'] != "") {
                $coor = array('x' => $post['x'], 'y' => $post['y']);
                $id = $generator->getBaseID($coor['x'], $coor['y']);
                if (!$database->getVillageState($id)) {
                    $form->addError("error", AT_A2BERRNOCOOR);
                }
                if ($post['c'] == 2) {
                    // check if oasis is yours
                    if ($database->getOasisField($id, 'owner') == 3)
                        $form->addError("error", AT_A2BERRCANTREINFOASIS);
                }
                $tStarter = ($session->tribe - 1) * 10;
                for ($i = 1; $i <= 10; $i++) {
                    if (isset($post['t' . $i])) {
                        $post['t' . $i] = intval($post['t' . $i]);
                        if ($post['t' . $i] > $village->unitarray['u' . ($tStarter + $i)]) {
                            $post['t' . $i] = $village->unitarray['u' . $tStarter];
                        }
                        if ($post['t' . $i] < 0) {
                            $post['t' . $i] = 0;
                        }
                    } else {
                        $post['t' . $i] = 0;
                    }
                }
                $post['t11'] = intval(isset($post['t11']) ? $post['t11'] : 0);
                if ($post['t11'] >= $village->unitarray['hero']) {
                    $post['t11'] = $village->unitarray['hero'];
                } else {
                    $post['t11'] = 0;
                }
            }

            $uc = 0;
            for ($i = 1; $i <= 11; $i++) {
                $uc += $post['t' . $i];
            }
            if ($uc <= 0) $form->addError("error", AT_A2BERRSELECT1TROOP);

            //find slowest unit.
            $speeds = array();
            if ($post['t11'] != '' && $post['t11'] > 0) {
                $heroarray = $database->getHero($session->uid);
                $speeds[] = $heroarray['speed'] + $heroarray['itemspeed'];
            } else {
                $heroarray = array();
            }
            for ($i = 1; $i <= 10; $i++) {
                if ($post['t' . $i] != '' && $post['t' . $i] > 0) {
                    if (isset($unitarray) && !empty($unitarray)) {
                        reset($unitarray);
                    }
                    $unitarray = $GLOBALS["u" . (($session->tribe - 1) * 10 + $i)];
                    $speeds[] = $unitarray['speed'];
                }
            }

            if ($database->isVillageOases($id) == 0) {

                //check if banned:
                $villageOwner = $database->getVillageField($id, 'owner');
                $userAccess = $database->getUserField($villageOwner, 'access', 0);
                if ($userAccess == '0' or $userAccess >= '8') {
                    $form->addError("error", AT_A2BERRCANTATTACKBANNED);
                }


                //check if player is under protection
                if (($database->hasBeginnerProtection($id) == 1) && ($villageOwner != $session->uid)) {
                    $form->addError("error", AT_A2BERRCANTATTACKBEGIINERPROTECTED);
                }


                $ip = $database->getUserField($villageOwner, 'ip', 0);
                $ip2 = $database->getUserField($session->uid, 'ip', 0);
                if ($villageOwner != $session->uid && $ip == $ip2 && !$session->sitter) {
                    $form->addError("error", AT_MULTIDETECT);
                }

                //check if attacking same village that units are in
                if ($id == $village->wid) {
                    $form->addError("error", AT_A2BERRFROMTOARETHESAME);
                }
                // Procesamos el array con los errores dados en el formulario
                if ($form->returnErrors() > 0) {
                    $_SESSION['errorarray'] = $form->getErrors();
                    $_SESSION['valuearray'] = $_POST;
                    header("Location: a2b.php?z=".$id);
                    exit;
                } else {
                    // Debemos devolver un array con $post, que contiene todos los datos mas
                    // otra variable que definira que el flag esta levantado y se va a enviar y el tipo de envio
                    $villageName = $database->getVillageField($id, 'name');
                    $timetaken = $generator->procDistanceTime($village->coor, $coor, min($speeds), 1, $heroarray);
                    array_push($post, "$id", "$villageName", "$villageOwner", "$timetaken");

                    return $post;
                }
            } else {
                if ($post['c'] == 3)
                    if ($database->getOasisField($id, 'owner') == 3)
                        $form->addError("error", AT_A2BERRNORMALATOASIS);

                if ($form->returnErrors() > 0) {
                    $_SESSION['errorarray'] = $form->getErrors();
                    $_SESSION['valuearray'] = $_POST;
                    header("Location: a2b.php");
                    exit;
                } else {
                    $villageName = VL_UNOCCUPIEDOASIS;
                    $timetaken = $generator->procDistanceTime($village->coor, $coor, min($speeds), 1, $heroarray);
                    array_push($post, "$id", "$villageName", "3", "$timetaken");

                    return $post;
                }
            }
        }

        private function sendTroopsBack($post)
        {
            global $form, $database, $village, $generator, $session, $technology;

            $enforce = $database->getEnforceArray($post['ckey'], 0);
            if (($enforce['from'] == $village->wid) || ($enforce['vref'] == $village->wid)) {
                $isoasis = $database->isVillageOases($enforce['from']);
                if ($isoasis) {
                    $to = $database->getOMInfo($enforce['from']);
                    if ($to['conqured']) {
                        $to['name'] = VL_OCCUPIEDOASIS;
                    } else {
                        $to['name'] = VL_UNOCCUPIEDOASIS;
                    }
                    $to['name'] .= ' (' . $to['x'] . '|' . $to['y'] . ')';
                } else {
                    $to = $database->getMInfo($enforce['from']);
                }

                $ownertribe = $database->getUserField($to['owner'], 'tribe', 0);
                $tStarter = ($ownertribe - 1) * 10;
                for ($i = 1; $i <= 10; $i++) {
                    if (isset($post['t' . $i])) {
                        $post['t' . $i] = intval($post['t' . $i]);
                        if ($post['t' . $i] >= $enforce['u' . ($tStarter + $i)]) {
                            $post['t' . $i] = $enforce['u' . ($tStarter + $i)];
                        } elseif ($post['t' . $i] < 0) {
                            $post['t' . $i] = 0;
                        }
                    } else {
                        $post['t' . $i] = 0;
                    }
                }

                if (isset($post['t11'])) {
                    $post['t11'] = intval($post['t11']);
                    if ($post['t11'] >= $enforce['hero']) {
                        $post['t11'] = $enforce['hero'];
                    } elseif ($post['t11'] < 0) {
                        $post['t11'] = 0;
                    }
                } else {
                    $post['t11'] = 0;
                }

                $uc = 0;
                for ($i = 1; $i <= 11; $i++) {
                    $uc += $post['t' . $i];
                }
                if ($uc <= 0) $form->addError("error", AT_A2BERRSELECT1TROOP);

                if ($form->returnErrors() > 0) {
                    $_SESSION['errorarray'] = $form->getErrors();
                    $_SESSION['valuearray'] = $_POST;
                    header("Location: a2b.php");
                    exit;
                } else {
                    //change units
                    $start = ($database->getUserField($to['owner'], 'tribe', 0) - 1) * 10 + 1;
                    $end = ($database->getUserField($to['owner'], 'tribe', 0) * 10);

                    $j = '1';
                    for ($i = $start; $i <= $end; $i++) {
                        $database->modifyEnforce($post['ckey'], $i, $post['t' . $j . ''], 0);
                        $j++;
                    }
                    $database->modifyEnforce($post['ckey'], 'hero', $post['t11'], 0);
                    $j++;

                    //get cord
                    $fromcoor = $database->getCoor($enforce['from']);
                    $tocoor = $database->getCoor($enforce['vref']);
                    $fromCor = array('x' => $tocoor['x'], 'y' => $tocoor['y']);
                    $toCor = array('x' => $fromcoor['x'], 'y' => $fromcoor['y']);

                    //find slowest unit.
                    $speeds = array();
                    for ($i = 1; $i <= 10; $i++) {
                        if (isset($post['t' . $i])) {
                            if ($post['t' . $i] != '' && $post['t' . $i] > 0) {
                                if ($unitarray) {
                                    reset($unitarray);
                                }
                                $unitarray = $GLOBALS["u" . (($session->tribe - 1) * 10 + $i)];
                                $speeds[] = $unitarray['speed'];
                            }
                        }
                    }
                    if (isset($post['t11'])) {
                        if ($post['t11'] != '' && $post['t11'] > 0) {
                            $heroarray = $database->getHero($to['owner']);
                            $speeds[] = $heroarray['speed'] + $heroarray['itemspeed'];
                        }
                    } else {
                        $heroarray = array();
                    }

                    $time = $generator->procDistanceTime($toCor, $fromCor, min($speeds), 1, $heroarray, TRUE);
                    $reference = $database->addAttack($enforce['from'], $post['t1'], $post['t2'], $post['t3'], $post['t4'], $post['t5'], $post['t6'], $post['t7'], $post['t8'], $post['t9'], $post['t10'], $post['t11'], 2, 0, 0, 0, 0);
                    $database->addMovement(4, $enforce['vref'], $enforce['from'], $reference, 0, ($time + time()));
                    $technology->checkReinf($post['ckey']);

                    header("Location: build.php?id=39");
                    exit;
                }
            } else {
                $form->addError("error", AT_A2BERRANOTHERPLAYER);
                if ($form->returnErrors() > 0) {
                    $_SESSION['errorarray'] = $form->getErrors();
                    $_SESSION['valuearray'] = $_POST;
                    header("Location: a2b.php");
                    exit;
                }
            }
        }

        public function Settlers($post)
        {
            global $form, $database, $village, $session, $generator;

            if ($database->getVillageState($post['s'])) {
                $form->addError("error", AT_CANTSETTLE);
            }

            if ($database->getVillageStateForSettle($post['s'])) {
                $form->addError("error", AT_A2BERRNOVILLAGE);
            }

            $mode = CP;
            $total = count($database->getProfileVillages($session->uid));
            $need_cps = ${'cp' . $mode}[$total];
            $cps = $session->cp;
			if ($cps < $need_cps) {
				$form->addError("error", AT_NOTENCUL);
			}
			//$founder = $database->getVillage($village->wid);
			$newvillage = $database->getMInfo($post['s']);
			$eigen = $database->getCoor($village->wid);
			$from = array('x' => $eigen['x'], 'y' => $eigen['y']);
			$to = array('x' => $newvillage['x'], 'y' => $newvillage['y']);
			$time = $generator->procDistanceTime($from, $to, 3, 0);
			$unit = ($session->tribe * 10);
			$vUnits = $database->getUnit($village->wid);
			if (!isset($vUnits['u' . $unit]) || $vUnits['u' . $unit] < 3) {
				$form->addError("error", AT_A2BERRSELECT1TROOP);
			}
			if ($form->returnErrors() > 0) {
				$_SESSION['errorarray'] = $form->getErrors();
				$_SESSION['valuearray'] = $_POST;
				header("Location: a2b.php");
				exit;
			}
			$database->modifyResource($village->wid, 750, 750, 750, 750, 0);
			$database->modifyUnit($village->wid, $unit, 3, 0);
			$database->addMovement(5, $village->wid, $post['s'], 0, 0, time() + $time);
			header("Location: build.php?id=39");
			exit;
        }

        public function Adventures($post)
        {
            global $database, $village, $session, $generator;
            $adventure = $database->getAdventure($session->uid, $post['h'], 0);
            if (!isset($adventure) || !$adventure) {
                header('Location: build.php?id=39');
                exit;
            }
            $eigen = $database->getCoor($village->wid);
            $adventureXY = $database->getMInfo($post['h']);
            $from = array('x' => $eigen['x'], 'y' => $eigen['y']);
            $to = array('x' => $adventureXY['x'], 'y' => $adventureXY['y']);
            $herodetail = $database->getHero($session->uid);
            $speed = $herodetail['speed'] + $herodetail['itemspeed'];
            $time = $generator->procDistanceTime($from, $to, $speed, 1, $herodetail);
            $getHero = count($database->getHero($session->uid, 0, 0));
            $unit = $database->getUnit($village->wid);
            if ($getHero > 0 && $unit['hero'] > 0) {
                $database->modifyUnit($village->wid, 'hero', 1, 0);
                $database->addMovement(9, $village->wid, $post['h'], 0, 0, time() + $time);

            }
            header("Location: build.php?id=39");
            exit;
        }

        function procTrapped($get)
        {
            global $database, $village, $generator;
             $get['k'] = isset($get['k'])? intval($get['k']):0;
            //block kill traped
            //$get['k'] = 0;
            $get['f'] = isset($get['f']) ? intval($get['f']) : 0;
            $id = 0;
            if ($get['k'] > 0) {
                $id = $get['k'];
            } elseif ($get['f'] > 0) {
                $id = $get['f'];
            }
            if ($id > 0) {
                $trapped = $database->getTrapped($id);
                if (!empty($trapped) && ($trapped['from'] == $village->wid || $trapped['vref'] == $village->wid)) {
                    $isvrefoasis = $database->isVillageOases($trapped['vref']);
                    if ($isvrefoasis) {
                        $vrefMInfo = $database->getOMInfo($trapped['vref']);
                    } else {
                        $vrefMInfo = $database->getMInfo($trapped['vref']);
                    }
                    $vrefTribe = $database->getUserField($vrefMInfo["owner"], "tribe", 0);
                    $isfromoasis = $database->isVillageOases($trapped['from']);
                    if ($isfromoasis) {
                        $fromMInfo = $database->getOMInfo($trapped['from']);
                    } else {
                        $fromMInfo = $database->getMInfo($trapped['from']);
                    }

                    // if natars trapped the troops
                    if ($vrefTribe == 5) {
                        $database->removeTrapped($id);
                        if ($trapped['hero'] > 0) {
                            $hero = $database->getHero($fromMInfo["owner"]);
                            $database->modifyHero(0, $hero['heroid'], 'health', 0, 0);
                            $database->modifyHero(0, $hero['heroid'], 'dead', 1, 0);
                        }
                        header("Location: build.php?id=39");
                        exit;
                    }

                    // Remove trapped data from db
                    $database->removeTrapped($id);
                    $fromTribe = $database->getUserField($fromMInfo["owner"], "tribe", 0);
                    $tStarter = ($fromTribe - 1) * 10;
                    $toReturn = array();
                    $usedTrapCount = 0;
                    for ($i = 1; $i <= 10; $i++) {
                        $toReturn[$i] = $trapped['u' . ($tStarter + $i)];
                        $usedTrapCount += $trapped['u' . ($tStarter + $i)];
                    }
                    $toReturn[11] = $trapped['hero'];
                    if ($toReturn[11] > 0) {
                        $hero = $database->getHero($fromMInfo["owner"]);
                    }
                    if ($get['k'] > 0 && $trapped['vref'] == $village->wid) { // Trapper attemt to kill
                        // Release 1/9 of troops and 1/3 of traps, hero will take damage or even dies if current HP is <=45
                        $database->modifyUnit($village->wid, 199, round(2 * $usedTrapCount * TRAPPED_FREEKILL_PORTION), 0);
                        for ($i = 1; $i <= 10; $i++) {
                            $toReturn[$i] = round($toReturn[$i] * TRAPPED_FREEKILL_PORTION * TRAPPED_FREEKILL_PORTION);
                            if ($toReturn[$i] > 0) {
                                global ${'u' . ($i + $tStarter)};
                                $speeds[] = ${'u' . ($i + $tStarter)}['speed'];
                            }
                        }
                        if (isset($hero)) {
                            $hero['health'] = round($hero['health'] * TRAPPED_FREEKILL_PORTION * TRAPPED_FREEKILL_PORTION);
                            if ($hero['health'] <= 5) {
                                $database->modifyHero(0, $hero['heroid'], 'health', 0, 0);
                                $database->modifyHero(0, $hero['heroid'], 'dead', 1, 0);
                                $toReturn[11] = 0;
                                $pdtHero = array();
                            } else {
                                $database->modifyHero(0, $hero['heroid'], 'health', $hero['health'], 0);
                                $speeds[] = $hero['speed'] + $hero['itemspeed'];
                                $pdtHero = $hero;
                            }
                        } else {
                            $pdtHero = array();
                        }
                        $returntime = $generator->procDistanceTime($fromMInfo, $vrefMInfo, min($speeds), 1, $pdtHero, TRUE) + time();
                        $attRef = $database->addAttack($trapped['from'], $toReturn[1], $toReturn[2], $toReturn[3], $toReturn[4], $toReturn[5], $toReturn[6], $toReturn[7], $toReturn[8], $toReturn[9], $toReturn[10], $toReturn[11], 3, 0, 0, 0);
                        $database->addMovement(4, $vrefMInfo['wref'], $fromMInfo['wref'], $attRef, '', $returntime);
                    } elseif ($get['k'] > 0 && $trapped['from'] == $village->wid) { // Troops owner attempt to make an anarchi
                        // All traps will be lost, 1/9 of troops will survive, hero will take damage or even dies if current HP is <=36
                        $database->modifyUnit($trapped['vref'], 199, $usedTrapCount, 0);
                        for ($i = 1; $i <= 10; $i++) {
                            $toReturn[$i] = round($toReturn[$i] * TRAPPED_FREEKILL_PORTION * TRAPPED_FREEKILL_PORTION);
                            if ($toReturn[$i] > 0) {
                                global ${'u' . ($i + $tStarter)};
                                $speeds[] = ${'u' . ($i + $tStarter)}['speed'];
                            }
                        }
                        if (isset($hero)) {
                            $hero['health'] = round($hero['health'] * TRAPPED_FREEKILL_PORTION * TRAPPED_FREEKILL_PORTION);
                            if ($hero['health'] <= 4) {
                                $database->modifyHero(0, $hero['heroid'], 'health', 0, 0);
                                $database->modifyHero(0, $hero['heroid'], 'dead', 1, 0);
                                $toReturn[11] = 0;
                                $pdtHero = array();
                            } else {
                                $database->modifyHero(0, $hero['heroid'], 'health', $hero['health'], 0);
                                $speeds[] = $hero['speed'] + $hero['itemspeed'];
                                $pdtHero = $hero;
                            }
                        } else {
                            $pdtHero = array();
                        }
                        $returntime = $generator->procDistanceTime($fromMInfo, $vrefMInfo, min($speeds), 1, $pdtHero, TRUE) + time();
                        $attRef = $database->addAttack($trapped['from'], $toReturn[1], $toReturn[2], $toReturn[3], $toReturn[4], $toReturn[5], $toReturn[6], $toReturn[7], $toReturn[8], $toReturn[9], $toReturn[10], $toReturn[11], 3, 0, 0, 0);
                        $database->addMovement(4, $vrefMInfo['wref'], $fromMInfo['wref'], $attRef, '', $returntime);
                    } elseif ($get['f'] > 0 && $trapped['vref'] == $village->wid) { // Trapper attemt to free
                        // All traps and troops will survive
                        for ($i = 1; $i <= 10; $i++) if ($toReturn[$i] > 0) {
                            global ${'u' . ($i + $tStarter)};
                            $speeds[] = ${'u' . ($i + $tStarter)}['speed'];
                        }
                        if (isset($hero)) {
                            $speeds[] = $hero['speed'] + $hero['itemspeed'];
                            $pdtHero = $hero;
                        } else {
                            $pdtHero = array();
                        }
                        $returntime = $generator->procDistanceTime($fromMInfo, $vrefMInfo, min($speeds), 1, $pdtHero, TRUE) + time();
                        $attRef = $database->addAttack($trapped['from'], $toReturn[1], $toReturn[2], $toReturn[3], $toReturn[4], $toReturn[5], $toReturn[6], $toReturn[7], $toReturn[8], $toReturn[9], $toReturn[10], $toReturn[11], 3, 0, 0, 0);
                        $database->addMovement(4, $vrefMInfo['wref'], $fromMInfo['wref'], $attRef, '', $returntime);
                    }
                }
            }
            header("Location: build.php?id=39");
            exit;
        }

        function procanimals(){
            global $village,$database;
            if (count($village->enforcetome) > 0) {
                foreach ($village->enforcetome as $enforce) {
                    for($i=31; $i<=40; $i++){
                        if($enforce["u".$i]>0){
                            $database->removeAnimals($enforce['id']);
                            header("Location: build.php?id=39");
                            exit;
                        }
                    }
                }
            }
            header("Location: build.php?id=39");
            exit;
        }
    }
    $units = new Units;

?>
