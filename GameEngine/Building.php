<?php

    class Building
    {

        public $NewBuilding = FALSE;
        public $buildArray = array();
        private $maxConcurrent;
        private $allocated;
        private $basic, $inner, $plus = 0;

        public function Building()
        {
            global $session;
            $this->maxConcurrent = BASIC_MAX;
            if (ALLOW_ALL_TRIBE || $session->tribe == 1) {
                $this->maxConcurrent += INNER_MAX;
            }
            if ($session->plus) {
                $this->maxConcurrent += PLUS_MAX;
            }
            $this->LoadBuilding();
        }

        private function loadBuilding()
        {
            global $database, $village, $session;
            $this->buildArray = $database->getJobs($village->wid);
            $this->allocated = count($this->buildArray);
            if ($this->allocated > 0) {
                foreach ($this->buildArray as $build) {
                    if ($build['loopcon'] == 1) {
                        $this->plus = 1;
                    } else {
                        if ($build['field'] <= 18) {
                            $this->basic += 1;
                        } else {
                            if ($session->tribe == 1 || ALLOW_ALL_TRIBE) {
                                $this->inner += 1;
                            } else {
                                $this->basic += 1;
                            }
                        }
                    }
                }
                $this->NewBuilding = TRUE;
            }
        }

        public function procBuild($get)
        {
            global $session, $database, $village;

            if (isset($get['a']) && $get['c'] == $session->checker && !isset($get['id'])) {
                if ($get['a'] == 0) {
                    $this->removeBuilding($get['d']);
                } elseif (isset($get['ins']) && $session->userinfo['gold'] >= g_level20) {
                    $session->changeChecker();
                    $FIELD_ID = intval($get['a']);
                    $database->query("DELETE FROM " . TB_PREFIX . "bdata WHERE wid=" . $village->wid . " AND field=" . $FIELD_ID);
                    $RPA_LEVEL = $village->resarray['f' . $FIELD_ID];
                    $FIELD_BID = $village->resarray['f' . $FIELD_ID . 't'];
                    $maxLvL = sizeof($GLOBALS['bid' . $FIELD_BID]);
                    if ($FIELD_BID <= 4) {
                        $maxLvL--;
                        if (!$village->capital) {
                            $maxLvL = 10;
                        }
                    }
                    if ($maxLvL > 20) {
                        return;
                    }
                    $bindicate = $this->canBuild($FIELD_ID, $village->resarray['f' . $FIELD_ID . 't']);
                    if (!in_array($FIELD_BID, array(40, 25, 26)) && !in_array($bindicate, array(1, 10, 11))) {
                        if ($maxLvL - $RPA_LEVEL) {
                            $pop = $cp = 0;
                            for ($i = 1 + $RPA_LEVEL; $i <= $maxLvL; ++$i) {
                                $pop += $GLOBALS['bid' . $FIELD_BID][$i]['pop'];
                                $cp += $GLOBALS['bid' . $FIELD_BID][$i]['cp'];
                            }
                            $database->modifyPop($village->wid, $pop, 0);
                            $database->addCP($village->wid, $cp / SPEED);
                            $database->modifyFieldType($village->wid, $FIELD_ID, $FIELD_BID);
                            $database->modifyFieldLevel($village->wid, $FIELD_ID, $maxLvL - $RPA_LEVEL, TRUE);
                            $database->modifyGold($session->uid, g_level20, 0);
                        }
                    }
                    if ($FIELD_ID >= 19) {
                        header("Location: dorf2.php");
                        exit;
                    } else {
                        header("Location: dorf1.php");
                        exit;
                    }
                } else {
                    $session->changeChecker();
                    $this->upgradeBuilding($get['a']);
                }
            }
            if (isset($get['a']) && $get['c'] == $session->checker && isset($get['id'])) {
                $session->changeChecker();
                $this->constructBuilding($get['id'], $get['a']);
            }
            if (isset($get['cmd']) == 'buildingFinish') {
                if ($session->gold >= 2) {
                    $this->finishAll();
                }
            }
        }

        private function removeBuilding($d)
        {
            global $database, $village;
            foreach ($this->buildArray as $jobs) {
                if ($jobs['id'] == $d) {
                    $uprequire = $this->resourceRequired($jobs['field'], $jobs['type']);
                    if ($database->removeBuilding($d)) {
                        $database->modifyResource($village->wid, $uprequire['wood'], $uprequire['clay'], $uprequire['iron'], $uprequire['crop'], 1);
                        if ($jobs['field'] >= 19) {
                            header("Location: dorf2.php");
                            exit;
                        } else {
                            header("Location: dorf1.php");
                            exit;
                        }
                    }
                }
            }
        }

        public function resourceRequired($id, $tid, $plus = 1)
        {
            $name = "bid" . $tid;
            global $$name, $village, $bid15;
            $dataarray = $$name;
            $wood = $clay = $iron = $crop = 0;
            if (isset($dataarray[$village->resarray['f' . $id] + $plus])) {
                $wood = $dataarray[$village->resarray['f' . $id] + $plus]['wood'];
                $clay = $dataarray[$village->resarray['f' . $id] + $plus]['clay'];
                $iron = $dataarray[$village->resarray['f' . $id] + $plus]['iron'];
                $crop = $dataarray[$village->resarray['f' . $id] + $plus]['crop'];
                $pop = $dataarray[$village->resarray['f' . $id] + $plus]['pop'];

                if ($tid == 15) {
                    if ($this->getTypeLevel(15) == 0) {
                        $time = round($dataarray[$village->resarray['f' . $id] + $plus]['time'] / SPEED * 5);
                    } else {
                        $time = round($dataarray[$village->resarray['f' . $id] + $plus]['time'] / SPEED);
                    }
                } else {
                    if ($this->getTypeLevel(15) != 0) {
                        $time = round($dataarray[$village->resarray['f' . $id] + $plus]['time'] * ($bid15[$this->getTypeLevel(15)]['attri'] / 100) / SPEED);
                    } else {
                        $time = round($dataarray[$village->resarray['f' . $id] + $plus]['time'] * 5 / SPEED);
                    }
                }
                $cp = $dataarray[$village->resarray['f' . $id] + $plus]['cp'];

                return array("wood" => $wood, "clay" => $clay, "iron" => $iron, "crop" => $crop, "pop" => $pop, "time" => $time, "cp" => $cp);
            }
        }

        public function getTypeLevel($tid, $vid = 0)
        {
            global $village, $database;
            $keyholder = array();
            if ($vid == 0) {
                $resourcearray = $village->resarray;
            } else {
                $resourcearray = $database->getResourceLevel($vid);
            }
            foreach (array_keys($resourcearray, $tid) as $key) {
                if (strpos($key, 't')) {
                    $key = preg_replace("/[^0-9]/", '', $key);
                    array_push($keyholder, $key);
                }
            }
            $element = count($keyholder);
            if ($element >= 2) {
                if ($tid <= 4) {
                    $temparray = array();
                    for ($i = 0; $i <= $element - 1; $i++) {
                        array_push($temparray, $resourcearray['f' . $keyholder[$i]]);
                    }
                    foreach ($temparray as $key => $val) {
                        if ($val == max($temparray))
                            $target = $key;
                    }
                } else {
                    $target = 0;
                    for ($i = 1; $i <= $element - 1; $i++) {
                        if ($resourcearray['f' . $keyholder[$i]] > $resourcearray['f' . $keyholder[$target]]) {
                            $target = $i;
                        }
                    }
                }
            } else if ($element == 1) {
                $target = 0;
            } else {
                return 0;
            }
            if ($keyholder[$target] != "") {
                return $resourcearray['f' . $keyholder[$target]];
            } else {
                return 0;
            }
        }

        public function canBuild($id, $tid)
        {
            global $village, $session, $database;
            $demolition = $database->getDemolition($village->wid);
            $mur = $this->meetUpRequierments($id, $tid);
            if ($mur != 0) return $mur;
            if (!empty($demolition) && count($demolition) > 0 && $demolition[0]['buildnumber'] == $id) {
                return 11;
            }
            if ($this->isMax($tid, $id)) {
                return 1;
            } else if ($this->isMax($tid, $id, 1) && ($this->isLoop($id) || $this->isCurrent($id))) {
                return 10;
            } else if ($this->isMax($tid, $id, 2) && $this->isLoop($id) && $this->isCurrent($id)) {
                return 10;
            } else if ($this->isMax($tid, $id, 3) && $this->isLoop($id) && $this->isCurrent($id) && count($database->getMasterJobs($village->wid)) > 0) {
                return 10;
            } else {
                if ($this->allocated <= $this->maxConcurrent) {
                    $resRequired = $this->resourceRequired($id, $village->resarray['f' . $id . 't']);
                    $resRequiredPop = $resRequired['pop'];
                    if ($resRequiredPop == "") {
                        $buildarray = $GLOBALS["bid" . $tid];
                        $resRequiredPop = $buildarray[1]['pop'];
                    }
                    $jobs = $database->getJobs($village->wid);
                    if ($jobs > 0) {
                        $soonPop = 0;
                        foreach ($jobs as $j) {
                            $buildarray = $GLOBALS["bid" . $j['type']];
                            $soonPop += $buildarray[$database->getFieldLevel($village->wid, $j['field']) + 1]['pop'];
                        }
                    }

                    if (($village->getProd("crop") + $village->upkeep - $soonPop - $resRequiredPop) <= 0 && $village->resarray['f' . $id . 't'] <> 4) {
                        return 4;
                    } else {
                        switch ($this->checkResource($tid, $id)) {
                            case 1:
                                return 5;
                                break;
                            case 2:
                                return 6;
                                break;
                            case 3:
                                return 7;
                                break;
                            case 4:
                                if ($id >= 19) {
                                    if ($session->tribe == 1 || ALLOW_ALL_TRIBE) {
                                        if ($this->inner == 0) {
                                            return 8;
                                        } else {
                                            if ($session->plus) {
                                                if ($this->plus == 0) {
                                                    return 9;
                                                } else {
                                                    return 3;
                                                }
                                            } else {
                                                return 2;
                                            }
                                        }
                                    } else {
                                        if ($this->basic == 0) {
                                            return 8;
                                        } else {
                                            if ($session->plus) {
                                                if ($this->plus == 0) {
                                                    return 9;
                                                } else {
                                                    return 3;
                                                }
                                            } else {
                                                return 2;
                                            }
                                        }
                                    }
                                } else {
                                    if ($this->basic == 1) {
                                        if ($session->plus && $this->plus == 0) {
                                            return 9;
                                        } else {
                                            return 3;
                                        }
                                    } else {
                                        return 8;
                                    }
                                }
                                break;
                        }
                    }
                } else {
                    return 2;
                }
            }
        }

        private function meetUpRequierments($id, $tid)
        {
            global $village, $session, $database;
            $wwlvl = $this->getTypeLevel(40);
            if (!(($village->resarray['f' . $id . 't'] != 0 && $tid == $village->resarray['f' . $id . 't']) || ($village->resarray['f' . $id . 't'] == 0 && $id != 99))) {
                return 1000;
            }

            switch ($tid) {
                case 38:
                case 39:
                    foreach ($session->villages as $vil) {
                        $artEffGrt = $database->getArtEffGrt($vil);

                        if ($artEffGrt > 0) break;
                    }
                    if ($artEffGrt <= 0 && $wwlvl <= 0) return 20;
                    break;
                case 40:
                    $artEffBP = $database->getArtEffBP($village->wid);
                    if ($artEffBP <= 0) {
                        return 21;
                    } elseif ($wwlvl >= 50) {
                        $artEffAllyBP = $database->getArtEffAllyBP($session->uid);
                        if ($artEffAllyBP <= 0) {
                            return 22;
                        }
                    }
                    break;
            }

            return 0;
        }

        public function isMax($id, $field, $loop = 0)
        {
            $name = "bid" . $id;
            global $$name, $village;
            $dataarray = $$name;
            //if($village->resarray['f'.$field] > 20){
            //mysql_query("UPDATE ".TB_PREFIX."fdata set `f".$field."` = 20 WHERE vref = '".$village->wid."'")or die(mysql_error());
            //return 1;
            //}
            if ($id <= 4) {
                if ($village->capital == 1) {
                    return ($village->resarray['f' . $field] == (count($dataarray) - 1 - $loop));
                } else {
                    return ($village->resarray['f' . $field] == (count($dataarray) - 11 - $loop));
                }
            } else {
                return ($village->resarray['f' . $field] == count($dataarray) - $loop);
            }
        }

        public function isLoop($id = 0)
        {
            foreach ($this->buildArray as $build) {
                if (($build['field'] == $id && $build['loopcon']) || ($build['loopcon'] == 1 && $id == 0)) {
                    return TRUE;
                }
            }

            return FALSE;
        }

        public function isCurrent($id)
        {
            foreach ($this->buildArray as $build) {
                if ($build['field'] == $id && $build['loopcon'] <> 1) {
                    return TRUE;
                }
            }
        }

        private function checkResource($tid, $id)
        {
            $name = "bid" . $tid;
            global $village, $$name;
            $plus = 1;
            foreach ($this->buildArray as $job) {
                if ($job['type'] == $tid && $job['field'] == $id) {
                    $plus = 2;
                }
            }
            $dataarray = $$name;
            $wood = $dataarray[$village->resarray['f' . $id] + $plus]['wood'];
            $clay = $dataarray[$village->resarray['f' . $id] + $plus]['clay'];
            $iron = $dataarray[$village->resarray['f' . $id] + $plus]['iron'];
            $crop = $dataarray[$village->resarray['f' . $id] + $plus]['crop'];
            if ($wood > $village->maxstore || $clay > $village->maxstore || $iron > $village->maxstore) {
                return 1;
            } else {
                if ($crop > $village->maxcrop) {
                    return 2;
                } else {
                    if ($wood > $village->awood || $clay > $village->aclay || $iron > $village->airon || $crop > $village->acrop) {
                        return 3;
                    } else {
                        if ($village->awood - $wood >= 0 && $village->aclay - $clay >= 0 && $village->airon - $iron >= 0 && $village->acrop - $crop >= 0) {
                            return 4;
                        } else {
                            return 3;
                        }
                    }
                }
            }
        }

        private function upgradeBuilding($id)
        {
            global $database, $village, $session, $logging;
            $bindicate = $this->canBuild($id, $village->resarray['f' . $id . 't']);
            if (($this->allocated < $this->maxConcurrent) && ($bindicate == 8 || $bindicate == 9)) {

                $uprequire = $this->resourceRequired($id, $village->resarray['f' . $id . 't']);
                $time = time() + $uprequire['time'];
                $loop = ($bindicate == 9 ? 1 : 0);
                $loopsame = 0;
                if ($loop == 1) {
                    foreach ($this->buildArray as $build) {
                        if ($build['field'] == $id) {
                            $loopsame += 1;
                            $uprequire = $this->resourceRequired($id, $village->resarray['f' . $id . 't'], ($loopsame > 0 ? 2 : 1));
                        }
                    }
                    if ($session->tribe == 1 || ALLOW_ALL_TRIBE) {
                        if ($id >= 19) {
                            foreach ($this->buildArray as $build) {
                                if ($build['field'] >= 19) {
                                    $time = $build['timestamp'] + $uprequire['time'];
                                }
                            }
                        } else {
                            foreach ($this->buildArray as $build) {
                                if ($build['field'] <= 18) {
                                    $time = $build['timestamp'] + $uprequire['time'];
                                }
                            }
                        }
                    } else {
                        $time = $this->buildArray[0]['timestamp'] + $uprequire['time'];
                    }
                }
                $level = $database->getResourceLevel($village->wid);

                $time = $time + ($loop == 1 ? ceil(60 / SPEED) : 0);
                $newlevel = $level['f' . $id] + 1 + count($database->getBuildingByField($village->wid, $id));
                if ($database->addBuilding($village->wid, $id, $village->resarray['f' . $id . 't'], $loop, $time, 0, $newlevel)) {
                    $database->modifyResource($village->wid, $uprequire['wood'], $uprequire['clay'], $uprequire['iron'], $uprequire['crop'], 0);
                    $logging->addBuildLog($village->wid, $this->procResType($village->resarray['f' . $id . 't']), ($village->resarray['f' . $id] + ($loopsame > 0 ? 2 : 1)), 0);
                }
            }
            if ($id >= 19) {
                header("Location: dorf2.php");
                exit;
            } else {
                header("Location: dorf1.php");
                exit;
            }
        }

        public function procResType($ref)
        {
            //global $session;
            switch ($ref) {
                case 1:
                    $build = "چوب";
                    break;
                case 2:
                    $build = "خشت";
                    break;
                case 3:
                    $build = "معدن اهن";
                    break;
                case 4:
                    $build = "گندم زار";
                    break;
                case 5:
                    $build = "كارخانه‌ چوب‌ بری‌";
                    break;
                case 6:
                    $build = "آجر سازی";
                    break;
                case 7:
                    $build = "آهنگری";
                    break;
                case 8:
                    $build = "آسیاب";
                    break;
                case 9:
                    $build = "نانوایی";
                    break;
                case 10:
                    $build = "انبار";
                    break;
                case 11:
                    $build = "انبار غذا";
                    break;
                case 12:
                    $build = "آهنگری";
                    break;
                case 13:
                    $build = "اسلحه خانه";
                    break;
                case 14:
                    $build = "میدان تمرین";
                    break;
                case 15:
                    $build = "ساختمان اصلی";
                    break;
                case 16:
                    $build = "اردوگاه";
                    break;
                case 17:
                    $build = "بازار";
                    break;
                case 18:
                    $build = "سفارت";
                    break;
                case 19:
                    $build = "سربازخانه";
                    break;
                case 20:
                    $build = "اصطبل";
                    break;
                case 21:
                    $build = "کارگاه";
                    break;
                case 22:
                    $build = "دارلفنون";
                    break;
                case 23:
                    $build = "مخفیگاه";
                    break;
                case 24:
                    $build = "تالار";
                    break;
                case 25:
                    $build = "اقامتگاه";
                    break;
                case 26:
                    $build = "قصر";
                    break;
                case 27:
                    $build = "خزانه داری";
                    break;
                case 28:
                    $build = "تجارتخانه";
                    break;
                case 29:
                    $build = "سربازخانه بزرگ";
                    break;
                case 30:
                    $build = "اصطبل بزرگ";
                    break;
                case 31:
                    $build = "دیوار شهر";
                    break;
                case 32:
                    $build = "خاکریز";
                    break;
                case 33:
                    $build = "پرچین";
                    break;
                case 34:
                    $build = "سنگ تراشی";
                    break;
                case 35:
                    $build = "ابجوسازی";
                    break;
                case 36:
                    $build = "تله ساز";
                    break;
                case 37:
                    $build = "عمارت قهرمان";
                    break;
                case 38:
                    $build = "انبار بزرگ";
                    break;
                case 39:
                    $build = "انبار غذا بزرگ";
                    break;
                case 40:
                    $build = "شگفتی جهان";
                    break;
                case 41:
                    $build = "آبخوری اسب";
                    break;
                case 42:
                    $build = "کارگاه بزرگ";
                    break;
                default:
                    $build = "خطا";
                    break;
            }

            return $build;
        }

        private function constructBuilding($id, $tid)
        {
            global $database, $village, $session, $logging;
            if ($tid == 16) {
                $id = 39;
            } else if ($tid == 31 || $tid == 32 || $tid == 33) {
                $id = 40;
            }
            $bindicate = $this->canBuild($id, $village->resarray['f' . $id . 't']);
            if (($this->allocated < $this->maxConcurrent) && ($bindicate == 8 || $bindicate == 9)) {
                $uprequire = $this->resourceRequired($id, $tid);
                $time = time() + $uprequire['time'];
                $loop = ($bindicate == 9 ? 1 : 0);
                if ($loop == 1) {
                    foreach ($this->buildArray as $build) {
                        if ($build['field'] >= 19 || ($session->tribe <> 1 && !ALLOW_ALL_TRIBE)) {
                            $time = $build['timestamp'] + ceil(60 / SPEED) + $uprequire['time'];
                        }
                    }
                }
                if ($this->meetRequirement($tid)) {
                    $level = $database->getResourceLevel($village->wid);
                    $time = $time + ($loop == 1 ? ceil(60 / SPEED) : 0);
                    $newlevel = $level['f' . $id] + 1 + count($database->getBuildingByField($village->wid, $id));

                    if ($database->addBuilding($village->wid, $id, $tid, $loop, $time, 0, $newlevel)) {
                        $logging->addBuildLog($village->wid, $this->procResType($tid), ($village->resarray['f' . $id] + 1), 1);
                        $database->modifyResource($village->wid, $uprequire['wood'], $uprequire['clay'], $uprequire['iron'], $uprequire['crop'], 0);
                    }
                }
            }
            header("Location: dorf2.php");
            exit;
        }

        private function meetRequirement($id)
        {
            global $village, $session, $database;
            $lvl = $this->getTypeLevel($id);
            $bl = $database->getBuildList($id, $village->wid);
            switch ($id) {
                case 38:
                case 39:
                    $artEffGrt = $database->getArtEffGrt($village->wid);
                    if ($artEffGrt <= 0 && !$this->getTypeLevel(40)) return FALSE;
                    $lvl10 = $this->getTypeLevel(10);
                    $lvl11 = $this->getTypeLevel(11);
                    $lvl38 = $this->getTypeLevel(38);
                    $lvl39 = $this->getTypeLevel(39);
                    if ($id == 38 && $lvl10 < 20 && $lvl38 == 0) return FALSE;
                    if ($id == 39 && $lvl11 < 20 && $lvl39 == 0) return FALSE;
                    break;
                case 10:
                case 11:
                    if (($lvl > 0 && $lvl < 20) || ($lvl == 0 && count($bl) > 0)) return FALSE;
                    break;
                case 23:
                    if (($lvl > 0 && $lvl < 10) || ($lvl == 0 && count($bl) > 0)) return FALSE;
                    break;
                case 36:
                    if (($lvl > 0 && $lvl < 20) || ($lvl == 0 && count($bl) > 0)) return FALSE;
                    break;
                default:
                    if (count($bl) > 0 || ($lvl > 0)) return FALSE;
                    break;
            }
            switch ($id) {
                case 1:
                case 2:
                case 3:
                case 4:
                case 11:
                case 15:
                case 16:
                case 18:
                case 23:
                case 31:
                case 32:
                case 33:
                    return TRUE;
                    break;
                case 10:
                    case 20:
                    return ($this->getTypeLevel(15) >= 1) ? TRUE : FALSE;
                    break;
                case 5:
                    if ($this->getTypeLevel(1) >= 10 && $this->getTypeLevel(15) >= 5) {
                        return TRUE;
                    } else {
                        return FALSE;
                    }
                    break;
                case 6:
                    if ($this->getTypeLevel(2) >= 10 && $this->getTypeLevel(15) >= 5) {
                        return TRUE;
                    } else {
                        return FALSE;
                    }
                    break;
                case 7:
                    if ($this->getTypeLevel(3) >= 10 && $this->getTypeLevel(15) >= 5) {
                        return TRUE;
                    } else {
                        return FALSE;
                    }
                    break;
                case 8:
                    if ($this->getTypeLevel(4) >= 5) {
                        return TRUE;
                    } else {
                        return FALSE;
                    }
                    break;
                case 9:
                    if ($this->getTypeLevel(15) >= 5 && $this->getTypeLevel(4) >= 10 && $this->getTypeLevel(8) >= 5) {
                        return TRUE;
                    } else {
                        return FALSE;
                    }
                    break;
                case 12:
                    if ($this->getTypeLevel(22) >= 1 && $this->getTypeLevel(15) >= 3) {
                        return TRUE;
                    } else {
                        return FALSE;
                    }
                    break;
                case 13:
                    if ($this->getTypeLevel(15) >= 3 && $this->getTypeLevel(22) >= 1) {
                        return TRUE;
                    } else {
                        return FALSE;
                    }
                    break;
                case 14:
                    if ($this->getTypeLevel(16) >= 15) {
                        return TRUE;
                    } else {
                        return FALSE;
                    }
                    break;
                case 17:
                    if ($this->getTypeLevel(15) >= 3 && $this->getTypeLevel(10) >= 1 && $this->getTypeLevel(11) >= 1) {
                        return TRUE;
                    } else {
                        return FALSE;
                    }
                    break;
                case 19:
                    if ($this->getTypeLevel(15) >= 3 && $this->getTypeLevel(16) >= 1) {
                        return TRUE;
                    } else {
                        return FALSE;
                    }
                    break;
                case 20:
                    if ($this->getTypeLevel(12) >= 3 && $this->getTypeLevel(22) >= 5) {
                        return TRUE;
                    } else {
                        return FALSE;
                    }
                    break;
                case 21:
                    if ($this->getTypeLevel(22) >= 10 && $this->getTypeLevel(15) >= 5) {
                        return TRUE;
                    } else {
                        return FALSE;
                    }
                    break;
                case 22:
                    if ($this->getTypeLevel(15) >= 3 && $this->getTypeLevel(16) >= 1) {
                        return TRUE;
                    } else {
                        return FALSE;
                    }
                    break;
                case 24:
                    if ($this->getTypeLevel(22) >= 10 && $this->getTypeLevel(15) >= 10) {
                        return TRUE;
                    } else {
                        return FALSE;
                    }
                    break;
                case 25:
                    if ($this->getTypeLevel(15) >= 5 && $this->getTypeLevel(26) == 0) {
                        return TRUE;
                    } else {
                        return FALSE;
                    }
                    break;
                case 26:
                    if ($this->getTypeLevel(18) >= 1 && $this->getTypeLevel(15) >= 5 && $this->getTypeLevel(25) == 0 && !$this->hasPalaceAnywhere()) {
                        return TRUE;
                    } else {
                        return FALSE;
                    }
                    break;
                case 27:
                    if ($this->getTypeLevel(15) >= 10) {
                        return TRUE;
                    } else {
                        return FALSE;
                    }
                    break;
                case 28:
                    if ($this->getTypeLevel(17) == 20 && $this->getTypeLevel(20) >= 10) {
                        return TRUE;
                    } else {
                        return FALSE;
                    }
                    break;
                case 29:
                    if ($this->getTypeLevel(19) == 20 && $village->capital == 0) {
                        return TRUE;
                    } else {
                        return FALSE;
                    }
                    break;
                case 30:
                    if ($this->getTypeLevel(20) == 20 && $village->capital == 0) {
                        return TRUE;
                    } else {
                        return FALSE;
                    }
                    break;
                case 34:
                    if ($this->getTypeLevel(26) >= 3 && $this->getTypeLevel(15) >= 5 && $this->getTypeLevel(25) == 0) {
                        return TRUE;
                    } else {
                        return FALSE;
                    }
                    break;
                case 35:
                    if ($this->getTypeLevel(16) >= 10 && $this->getTypeLevel(11) == 20) {
                        return TRUE;
                    } else {
                        return FALSE;
                    }
                    break;
                case 36:
                    if ($this->getTypeLevel(16) >= 1 && $session->tribe == 3) {
                        return TRUE;
                    } else {
                        return FALSE;
                    }
                    break;
                case 37:
                    if ($this->getTypeLevel(15) >= 3 && $this->getTypeLevel(16) >= 1) {
                        return TRUE;
                    } else {
                        return FALSE;
                    }
                    break;
                case 38:
                    if ($this->getTypeLevel(15) >= 10 && ($this->getTypeLevel(10) == 20 || $this->getTypeLevel(38))) {
                        return TRUE;
                    } else {
                        return FALSE;
                    }
                    break;
                case 39:
                    if ($this->getTypeLevel(15) >= 10 && ($this->getTypeLevel(11) == 20 || $this->getTypeLevel(39))) {
                        return TRUE;
                    } else {
                        return FALSE;
                    }
                    break;
                case 40:
                    $artEffBP = $database->getArtEffBP($village->wid);
                    if ($artEffBP <= 0 || !$this->getTypeLevel(40)) {
                        return FALSE;
                    } else {
                        return TRUE;
                    }
                    break;
                case 41:
                    if ($this->getTypeLevel(16) >= 10 && $this->getTypeLevel(20) == 20) {
                        return TRUE;
                    } else {
                        return FALSE;
                    }
                    break;
                case 42:
                    if ($this->getTypeLevel(21) == 20 && $village->capital == 0) {
                        return TRUE;
                    } else {
                        return FALSE;
                    }
                    break;
            }
        }

        public function hasPalaceAnywhere()
        {
            global $session, $database;
            $has = FALSE;
            $userVillages = $database->getArrayMemberVillage($session->uid);
            foreach ($userVillages as $v) {
                if ($this->getTypeLevel(26, $v['wref']) || $database->getBuildList(26, $v['wref'])) {
                    $has = TRUE;
                    break;
                }
            }

            return $has;
        }

        private function finishAll()
        {
            global $database, $session, $logging, $village, $bid18, $bid10, $bid11, $bid38, $bid39, $technology;
            foreach ($this->buildArray as $jobs) {
                $level = $database->getFieldLevel($jobs['wid'], $jobs['field']);
                $level = ($level == -1) ? 0 : $level;
                if ($jobs['type'] != 25 AND $jobs['type'] != 26 AND $jobs['type'] != 40) {
                    $resource = $this->resourceRequired($jobs['field'], $jobs['type']);
                    $q = "UPDATE " . TB_PREFIX . "fdata set f" . $jobs['field'] . " = f" . $jobs['field'] . " + 1, f" . $jobs['field'] . "t = " . $jobs['type'] . " where vref = " . $jobs['wid'];
                    if ($database->query($q)) {

                        $database->modifyPop($jobs['wid'], $resource['pop'], 0);
                        $database->addCP($jobs['wid'], $resource['cp']);
                        $database->finishDemolition($village->wid);
                        $database->addCLP($session->uid, 7);

                        $q = "DELETE FROM " . TB_PREFIX . "bdata where id = " . $jobs['id'];
                        $database->query($q);
                        if ($jobs['type'] == 18) {
                            $owner = $database->getVillageField($jobs['wid'], "owner");
                            $max = $bid18[$level]['attri'];
                            $q = "UPDATE " . TB_PREFIX . "alidata set max = $max where leader = $owner";
                            $database->query($q);
                        }
                        if ($jobs['type'] == 10) {
                            $max = $database->getVillageField($jobs['wid'], "maxstore");
                            if ($level == '0' && $this->getTypeLevel(10) != 20) {
                                $max -= STORAGE_BASE;
                            }
                            $max -= $bid10[$level]['attri'] * STORAGE_MULTIPLIER;
                            $max += $bid10[$level + 1]['attri'] * STORAGE_MULTIPLIER;
                            $database->setVillageField($jobs['wid'], "maxstore", $max);
                        }

                        if ($jobs['type'] == 11) {
                            $max = $database->getVillageField($jobs['wid'], "maxcrop");
                            if ($level == '0' && $this->getTypeLevel(11) != 20) {
                                $max -= STORAGE_BASE;
                            }
                            $max -= $bid11[$level]['attri'] * STORAGE_MULTIPLIER;
                            $max += $bid11[$level + 1]['attri'] * STORAGE_MULTIPLIER;
                            $database->setVillageField($jobs['wid'], "maxcrop", $max);
                        }
                        if ($jobs['type'] == 38) {
                            $max = $database->getVillageField($jobs['wid'], "maxstore");
                            if ($level == '0' && $this->getTypeLevel(38) != 20) {
                                $max -= STORAGE_BASE;
                            }
                            $max -= $bid38[$level]['attri'] * STORAGE_MULTIPLIER;
                            $max += $bid38[$level + 1]['attri'] * STORAGE_MULTIPLIER;
                            $database->setVillageField($jobs['wid'], "maxstore", $max);
                        }

                        if ($jobs['type'] == 39) {
                            $max = $database->getVillageField($jobs['wid'], "maxcrop");
                            if ($level == '0' && $this->getTypeLevel(39) != 20) {
                                $max -= STORAGE_BASE;
                            }
                            $max -= $bid39[$level]['attri'] * STORAGE_MULTIPLIER;
                            $max += $bid39[$level + 1]['attri'] * STORAGE_MULTIPLIER;
                            $database->setVillageField($jobs['wid'], "maxcrop", $max);
                        }
                    }
                }
            }

            $technology->finishTech();
            $logging->goldFinLog($village->wid);
            $database->modifyGold($session->uid, 2, 0);
            header("Location: " . $session->referrer);
            exit;
        }

        public function walling()
        {
            global $session;
            $wall = array(31, 32, 33);
            foreach ($this->buildArray as $job) {
                if (in_array($job['type'], $wall)) {
                    return "3" . $session->tribe;
                }
            }

            return FALSE;
        }

        public function rallying()
        {
            foreach ($this->buildArray as $job) {
                if ($job['type'] == 16) {
                    return TRUE;
                }
            }

            return FALSE;
        }

        public function getTypeField($type)
        {
            global $village;
            for ($i = 19; $i <= 40; $i++) {
                if ($village->resarray['f' . $i . 't'] == $type) {
                    return $i;
                }
            }
        }

        public function calculateAvaliable($id, $tid, $plus = 1)
        {
            global $village, $generator;
            $uprequire = $this->resourceRequired($id, $tid, $plus);
            $rwood = $uprequire['wood'] - $village->awood;
            $rclay = $uprequire['clay'] - $village->aclay;
            $rcrop = $uprequire['crop'] - $village->acrop;
            $riron = $uprequire['iron'] - $village->airon;
            $rwtime = $rwood / $village->getProd("wood") * 3600;
            $rcltime = $rclay / $village->getProd("clay") * 3600;
            $rctime = $village->getProd("crop") <= 0 ? 172800 : ($rcrop / $village->getProd("crop") * 3600);
            $ritime = $riron / $village->getProd("iron") * 3600;
            $reqtime = max($rwtime, $rctime, $rcltime, $ritime);
            $reqtime += time();

            return $generator->procMtime($reqtime);
        }
    }

    ;

?>
