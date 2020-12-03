<?php
/**********************************************
/ All Of the Copy Rights Of The Script Is Reserved For vikings.ir
/	You may have made some changes but You Have No Right To remove This Copy Right!
/	For Debug And Support Just Contact Me :09335751872 just sms
/	Yahoo ID: gorz1872@yahoo.com
/
*/
    //date_default_timezone_set('Asia/Tehran');

    include_once("Session.php");
    include_once("Building.php");
    include_once("Market.php");
    include_once("Technology.php");
    include_once("Automation.funcs/updateResource.php");

    /*(	SECURITY SYSTEM CHECK ) */
    if (!isset($security_system) && $security_system != 1) die("<b>Error:</b> Security Setting Must Be Enabled To Run Script!...");

    // Time Zone //

    $q = mysql_query("SELECT `timezone` FROM " . TB_PREFIX . "users WHERE id = $session->uid LIMIT 1");
    $q = mysql_fetch_array($q);
    switch ($q['timezone']) {
        case 0:
        case 30:
            $time = 'Asia/Tehran';
            break;
        case 31:
            $time = 'Canada/Central';
            break;
        case 32:
            $time = 'Europe/Berlin';
            break;
        case 33:
            $time = 'Australia/North';
            break;
        case 34:
            $time = 'America/New_York';
            break;
        case 35:
            $time = 'Australia/ACT';
            break;
        case 12:
            $time = 'Etc/GMT-11';
            break;
        case 13:
            $time = 'Etc/GMT-10';
            break;
        case 14:
            $time = 'Etc/GMT-9';
            break;
        case 15:
            $time = 'Etc/GMT-8';
            break;
        case 16:
            $time = 'Etc/GMT-7';
            break;
        case 17:
            $time = 'Etc/GMT-6';
            break;
        case 18:
            $time = 'Etc/GMT-5';
            break;
        case 19:
            $time = 'Etc/GMT-4';
            break;
        case 20:
            $time = 'Etc/GMT-3';
            break;
        case 21:
            $time = 'Etc/GMT-2';
            break;
        case 22:
            $time = 'Etc/GMT-1';
            break;
        case 23:
            $time = 'Etc/GMT+0';
            break;
        case 0:
            $time = 'Etc/GMT+1';
            break;
        case 1:
            $time = 'Etc/GMT+2';
            break;
        case 2:
            $time = 'Etc/GMT+3';
            break;
        case 3:
            $time = 'Etc/GMT+4';
            break;
        case 4:
            $time = 'Etc/GMT+5';
            break;
        case 5:
            $time = 'Etc/GMT+6';
            break;
        case 6:
            $time = 'Etc/GMT+7';
            break;
        case 7:
            $time = 'Etc/GMT+8';
            break;
        case 8:
            $time = 'Etc/GMT+9';
            break;
        case 9:
            $time = 'Etc/GMT+10';
            break;
        case 10:
            $time = 'Etc/GMT+11';
            break;
        case 11:
            $time = 'Etc/GMT+12';
            break;
        default:
            $time = 'Asia/Tehran';
            break;
    }
    date_default_timezone_set('Asia/Tehran');

    class Village
    {

        public $type;
        public $coor = array();
        public $awood, $aclay, $airon, $acrop, $pop, $maxstore, $maxcrop;
        public $wid, $vname, $capital;
        public $upkeep;
        public $resarray = array();
        public $unitarray, $trappedinme, $trappedinyou, $techarray, $unitall, $researching, $abarray = array();
        public $ocounter2 = array();
        private $infoarray = array();
        private $production = array();
        private $oasisowned, $ocounter = array();

        function Village()
        {
            global $session;
            if (isset($_SESSION['wid'])) {
                $this->wid = $_SESSION['wid'];
            } else {
                $this->wid = $session->villages[0];
            }
            $this->LoadTown();
            $this->ActionControl();
        }

        private function LoadTown()
        {
            global $database, $session, $logging, $technology;
            updateWrefResource($this->wid);
            $this->infoarray = $database->getVillage($this->wid);
            if ($this->infoarray['owner'] != $session->uid && !$session->isAdmin) {
                unset($_SESSION['wid']);
                $logging->addIllegal($session->uid, $this->wid, 1);
                $this->wid = $session->villages[0];
                $this->infoarray = $database->getVillage($this->wid);
            }
            $this->resarray = $database->getResourceLevel($this->wid);
            $this->coor = $database->getCoor($this->wid);
            $this->type = $database->getVillageType($this->wid);
            $this->oasisowned = $database->getOasis($this->wid);
            $this->ocounter = $this->sortOasis();
            $this->ocounter2 = $this->sortOasis();
            $this->unitarray = $database->getUnit($this->wid);
            $this->enforcetome = $database->getEnforceVillage($this->wid, 0);
            $this->enforcetoyou = $database->getEnforceVillage($this->wid, 1);
            $this->trappedinme = $database->getTrappedIn($this->wid);
            $this->trappedinyou = $database->getTrappedFrom($this->wid);
            $this->unitall = $technology->getAllUnits($this->wid);
            $this->techarray = $database->getTech($this->wid);
            $this->abarray = $database->getABTech($this->wid);
            $this->researching = $database->getResearching($this->wid);
            $this->capital = $this->infoarray['capital'];
            $this->currentcel = $this->infoarray['celebration'];
            $this->wid = $this->infoarray['wref'];
            if (defined($this->infoarray['name'])) $this->infoarray['name'] = constant($this->infoarray['name']);
            $this->vname = $this->infoarray['name'];
            $this->awood = $this->infoarray['wood'];
            $this->aclay = $this->infoarray['clay'];
            $this->airon = $this->infoarray['iron'];
            $this->acrop = $this->infoarray['crop'];
            $this->production['wood'] = intval($this->infoarray['woodp']);
            $this->production['clay'] = intval($this->infoarray['clayp']);
            $this->production['iron'] = intval($this->infoarray['ironp']);
            $this->production['crop'] = intval($this->infoarray['cropp']);
            $this->upkeep = intval($this->infoarray['upkeep']);
            $this->pop = $this->infoarray['pop'];
            $this->maxstore = $this->infoarray['maxstore'];
            $this->maxcrop = $this->infoarray['maxcrop'];
            $this->allcrop = intval($this->production['crop'] + $this->upkeep + $this->pop);
            $this->loyalty = $this->infoarray['loyalty'];
            $this->natar = $this->infoarray['natar'];
        }

        private function sortOasis()
        {
            $crop = $clay = $wood = $iron = 0;
            if (!empty($this->oasisowned)) {
                foreach ($this->oasisowned as $oasis) {
                    switch ($oasis['type']) {
                        case 1:
                            $wood += 1;
                            break;
                        case 2:
                            $wood += 2;
                            break;
                        case 3:
                            $wood += 1;
                            $crop += 1;
                            break;
                        case 4:
                            $clay += 1;
                            break;
                        case 5:
                            $clay += 2;
                            break;
                        case 6:
                            $clay += 1;
                            $crop += 1;
                            break;
                        case 7:
                            $iron += 1;
                            break;
                        case 8:
                            $iron += 2;
                            break;
                        case 9:
                            $iron += 1;
                            $crop += 1;
                            break;
                        case 10:
                        case 11:
                            $crop += 1;
                            break;
                        case 12:
                            $crop += 2;
                            break;
                    }
                }
            }

            return array($wood, $clay, $iron, $crop);
        }

        private function ActionControl()
        {
            global $session;
            if (SERVER_WEB_ROOT) {
                $page = $_SERVER['SCRIPT_NAME'];
            } else {
                $explode = explode("/", $_SERVER['SCRIPT_NAME']);
                $i = count($explode) - 1;
                $page = $explode[$i];
            }
            if ($page == "build.php" && $session->uid != $this->infoarray['owner']) {
                unset($_SESSION['wid']);
                header("Location: dorf1.php");
                exit;
            }
        }

        public function getProd($type)
        {
            return $this->production[$type];
        }

        public function getAllUnits($vid)
        {
            global $database, $technology;

            return $technology->getUnits($database->getUnit($vid), $database->getEnforceVillage($vid, 0));
        }

    }
    $village = new Village;
    $building = new Building;
?>
