<?php
    ob_start();
    if (file_exists(dirname(__FILE__) . '/config.php')) {
        include_once(dirname(__FILE__) . "/config.php");
    } else {
        die('Server configuration is not completed,wait...');
    }

    include_once("Database.php");
    include_once("Data/buidata.php");
    include_once("Data/cp.php");
    include_once("Data/cel.php");
    include_once("Data/resdata.php");
    include_once("Data/unitdata.php");
    include_once("Data/hero_full.php");
    include_once("Data/bounty.php");
    include_once("Mailer.php");
    include_once("Battle.php");
    include_once("Form.php");
    include_once("Generator.php");
    include_once("Natars.php");
    include_once("Logging.php");
    include_once("Message.php");
    include_once("Multisort.php");
    include_once("Ranking.php");
    include_once("Alliance.php");
    include_once("Profile.php");


    class Session
    {

        var $checker, $mchecker, $villages = array(), $bonus = 0, $bonus1 = 0, $bonus2 = 0, $bonus3 = 0, $bonus4 = 0, $username, $uid, $access, $plus, $tribe, $isAdmin, $alliance, $gold, $oldrank, $gpack, $referrer, $url, $logged_in = FALSE;
        public $userinfo = array();
        private $time;
        private $userarray = array();

        function Session()
        {
            $this->check_ip();
            global $database;
            $this->time = $_SERVER['REQUEST_TIME'];
            session_start();

            $this->logged_in = $this->checkLogin();
            if (!isset($_SESSION['lang']) || $_SESSION['lang'] == '') $_SESSION['lang'] = constant('LANG');
            if ($this->logged_in) {
                $uLang = $database->getUserField($this->username, 'lang', 1);
                if (isset($uLang) && $uLang != '') $_SESSION['lang'] = $uLang;
            }
            if (isset($_COOKIE['lang']) and $_COOKIE['lang'] != '' && (!isset($_SESSION['lang']) || $_SESSION['lang'] == '')) $_SESSION['lang'] = $_COOKIE['lang'];
            if (!isset($_SESSION['lang']) || $_SESSION['lang'] == '' || $_SESSION['lang'] == 'LANG') $_SESSION['lang'] = 'fa';
            include_once("Lang/" . $_SESSION['lang'] . ".php");
            //include("Automation.php");
            if ($this->logged_in && TRACK_USR) {
                $database->updateActiveUser($this->username, $this->time);
            }
            if (isset($_SESSION['url'])) {
                $this->referrer = $_SESSION['url'];
            } else {
                $this->referrer = "/";
            }
            $this->url = $_SESSION['url'] = $_SERVER['PHP_SELF'];
            $this->SurfControl();
            //$this->Options();
            // if($this->logged_in) { $this->checkGoldSilverHack();}
        }

        private function check_ip()
        {
            //BLOCK IP/s FROM BLACK list
            if (!defined('BLACKLIST'))
                define ('BLACKLIST', 'black.php');
            if (file_exists(BLACKLIST)) {
                $list = file(BLACKLIST);
                foreach ($list as $addr) {
                    $addr = trim($addr);
                    $host_addr = $this->getIp();
                    // Semplice indirizzo IP
                    if ($host_addr == $addr) die (US_BANIPMSG);
                    // Subnet di classe C
                    else if (preg_match('/(\d+\.\d+\.\d+)\.0\/24/', $addr, $sub)) {
                        $subnet = trim($sub[1]);
                        if (preg_match("/^{$subnet}/", $host_addr))
                            die (US_BANIPMSG);
                    } // Subnet di classe B
                    else if (preg_match('/(\d+\.\d+)\.0\.0\/16/', $addr, $sub)) {
                        $subnet = trim($sub[1]);
                        if (preg_match("/^{$subnet}/", $host_addr))
                            die (US_BANIPMSG);
                    } // Subnet di classe A
                    else if (preg_match('/(\d+)\.0\.0\.0\/8/', $addr, $sub)) {
                        $subnet = trim($sub[1]);
                        if (preg_match("/^{$subnet}/", $host_addr))
                            die (US_BANIPMSG);
                    }
                }
            }
        }

        private function getIp()
        {
            $http_client_ip = isset($_SERVER['HTTP_CLIENT_IP']) ? $_SERVER['HTTP_CLIENT_IP'] : null;
            $http_x_forwarded_for = isset($_SERVER['HTTP_X_FORWARDED_FOR']) ? $_SERVER['HTTP_X_FORWARDED_FOR'] : null;
            $remote_addr = $_SERVER['REMOTE_ADDR'];
            if (!empty($http_client_ip)) {
                $host_addr = $http_client_ip;
            } elseif (!empty($http_x_forwarded_for)) {
                $host_addr = $http_x_forwarded_for;
            } else {
                $host_addr = $remote_addr;
            }

            return $host_addr;
        }

        private function checkLogin()
        {
            global $database;
            if (isset($_SESSION['username']) && isset($_SESSION['sessid'])) {
                if (!$database->checkActiveSession($_SESSION['username'], $_SESSION['sessid'])) {
                    $this->Logout();

                    return FALSE;
                } else {
                    $ua = $_SERVER['HTTP_USER_AGENT'];
                    $ip = $_SERVER['REMOTE_ADDR'];
                    $id = session_id();
                    $all = "$ua $ip $id";
                    $all = sha1($all);
                    $all = htmlspecialchars($all);
                    if (isset($_SESSION['hash']) && $_SESSION['hash'] != $all){
                        return FALSE;
                    }
                    //Get and Populate Data
                    $this->PopulateVar();
                    //update database
                    $database->addActiveUser($_SESSION['username'], $this->time);
                    $database->updateUserField($_SESSION['username'], "timestamp", $this->time, 0);
                    $database->updateUserField($_SESSION['username'], "ip", $this->getIp(), 0);

                    return TRUE;
                }
            } else {
                return FALSE;
            }
        }

        public function Logout()
        {
            global $database;
            $this->logged_in = FALSE;
            $q = "SELECT `sessid` FROM " . TB_PREFIX . "users WHERE username = '" . $_SESSION['username'] . "' LIMIT 1";
            $result = mysql_query($q);
            $user = mysql_fetch_assoc($result);
            $sessidarray = explode('+', $user['sessid']);
            $last = count($sessidarray);
            for ($i = 0; $i <= $last; $i++) {
                if ($sessidarray[$i] == $_SESSION['sessid']) {
                    $sessidarray[$i] = null;
                }
            }

            $database->updateUserField($_SESSION['username'], 'sessid', '', 0);
            for ($i = 0; $i <= $last; $i++) {
                if ($sessidarray[$i] != 0) {
                    if ($sessidarray[$i - 1] == 0) {
                        $xx = $sessidarray[$i];
                    } else {
                        $xx = $sessidarray[$i - 1] . '+' . $sessidarray[$i];
                    }
                }
            }
            $database->updateUserField($_SESSION['username'], 'sessid', $xx, 0);
            $database->UpdateOnline("logout", $this->username, 0);
            if (ini_get('session.use_cookies')) {
                $params = session_get_cookie_params();
                session_set_cookie_params('3600'); // 1 hour
                setcookie(session_name(), '', $_SERVER['REQUEST_TIME'] - 42000, $params['path'], $params['domain'], TRUE, TRUE);
                setcookie('lang', $_SESSION['lang'], $_SERVER['REQUEST_TIME'] + 86400, $params["path"], $params["domain"], $params["secure"], $params["httponly"]);
            }
            session_unset();
            session_destroy();
            session_start();
        }

        private function PopulateVar()
        {
            global $database;
            $this->userarray = $this->userinfo = $database->getUser($_SESSION['username'], 0);
            $this->username = $this->userarray['username'];
            $this->email = $this->userarray['email'];
            $this->uid = $_SESSION['uid'] = $this->userarray['id'];
            $this->gpack = $this->userarray['gpack'];
            $this->access = $this->userarray['access'];
            $this->plus = ($this->userarray['plus'] > $this->time);
            $this->goldclub = $this->userarray['goldclub'];
            $this->villages = $database->getVillagesID($this->uid);
            $this->tribe = $this->userarray['tribe'];
            $this->isAdmin = $this->access >= 9;
            $this->alliance = $this->userarray['alliance'];
            $this->checker = $_SESSION['checker'];
            $this->mchecker = $_SESSION['mchecker'];
            $this->gold = $this->userarray['gold'];
            $this->is_sitter = $database->checkSitter($_SESSION['username']);
            $this->silver = $this->userarray['silver'];
            $this->cp = $this->userarray['cp'];
            $this->oldrank = $this->userarray['oldrank'];
            $_SESSION['ok'] = $this->userarray['ok'];
            if ($this->userarray['b1'] > $this->time) {
                $this->bonus1 = 1;
            }
            if ($this->userarray['b2'] > $this->time) {
                $this->bonus2 = 1;
            }
            if ($this->userarray['b3'] > $this->time) {
                $this->bonus3 = 1;
            }
            if ($this->userarray['b4'] > $this->time) {
                $this->bonus4 = 1;
            }
            //check hero adventure
            $time = $this->time;
            $herodetail = $database->getHero($this->uid);
            $aday = min(86400 / SPEED, 100);
            $tenday = min(86400 / SPEED, 600);


            $endat = time() + 900;

            if ($herodetail['lastadv'] <= ($time - $aday)) {
                if ($herodetail['lastadv'] <= $time - $tenday) {
                    //$herodetail['lastadv'] = $time-$tenday+$aday;
                }
                $dif = rand(0, 2);
                $database->addAdventure($database->getVFH($herodetail['uid']), $herodetail['uid'], $endat, $dif);
                $database->addAdventure($database->getVFH($herodetail['uid']), $herodetail['uid'], $endat + rand(10, 20), $dif);
                $herodetail['lastadv'] += $aday;
                $endat += $aday;
            }
            $database->modifyHero(0, $herodetail['heroid'], 'lastadv', $time, 0);
        }

        private function SurfControl()
        {
            if (SERVER_WEB_ROOT) {
                $page = $_SERVER['SCRIPT_NAME'];
            } else {
                $explode = explode("/", $_SERVER['SCRIPT_NAME']);
                $i = count($explode) - 1;
                $page = $explode[$i];

            }
            // echo $page;die;
            $pagearray = array("index.php", "anleitung.php", "tutorial.php", "login.php", "activate.php", "anmelden.php");
            if (!$this->logged_in) {
                if (!in_array($page, $pagearray) && $page != "setlang.php" && $page != "contact.php" && $page != "serverregistere.php" && $page != "password.php") {
                    header("Location: login.php");
                    exit;
                }
            } else {
                if (in_array($page, $pagearray)) {
                    header("Location: dorf1.php");
                    exit;
                }
            }
        }

        public function Login($user)
        {
            global $database, $generator, $logging;
            $this->logged_in = TRUE;
            $sesid = md5($_SERVER['HTTP_ACCEPT_CHARSET'] . $_SERVER['HTTP_ACCEPT_ENCODING'] . $_SERVER['HTTP_ACCEPT_LANGUAGE'] . $_SERVER['HTTP_USER_AGENT'] . $_SERVER['REMOTE_ADDR']);
            $_SESSION['sessid'] = $sesid;
            $_SESSION['username'] = $user;
            $_SESSION['checker'] = $generator->generateRandStr(3);
            $_SESSION['mchecker'] = $generator->generateRandStr(5);
            $_SESSION['qst'] = $database->getUserField($_SESSION['username'], "quest", 1);
            $_SESSION['chat_config'] = $database->getUserField($_SESSION['username'], "chat_config", 1);
            if (!isset($_SESSION['wid'])) {
                $query = mysql_query('SELECT * FROM `' . TB_PREFIX . 'vdata` WHERE `owner` = ' . $database->getUserField($_SESSION['username'], "id", 1) . ' LIMIT 1');
                $data = mysql_fetch_assoc($query);
                $_SESSION['wid'] = $data['wref'];
            } else
                if ($_SESSION['wid'] == '') {
                    $query = mysql_query('SELECT * FROM `' . TB_PREFIX . 'vdata` WHERE `owner` = ' . $database->getUserField($_SESSION['username'], "id", 1) . ' LIMIT 1');
                    $data = mysql_fetch_assoc($query);
                    $_SESSION['wid'] = $data['wref'];
                }


            $this->PopulateVar();

            $logging->addLoginLog($this->uid, $_SERVER['REMOTE_ADDR']);
            $database->addActiveUser($_SESSION['username'], $this->time);

            $database->addActiveUser($_SESSION['username'], $this->time);

            $q = "SELECT `sessid` FROM " . TB_PREFIX . "users WHERE username = '" . $_SESSION['username'] . "' LIMIT 1";
            $result = mysql_query($q);
            $dbarray = mysql_fetch_array($result);

            if(strlen($dbarray['sessid']) > 134){
                $database->updateUserField($_SESSION['username'], 'sessid', '', 0);
            }
            if ($dbarray['sessid'] != '') {
                $sessid = $dbarray['sessid'] . '+' . $_SESSION['sessid'];
            } else {
                $sessid = $_SESSION['sessid'];
            }
            $database->updateUserField($_SESSION['username'], 'sessid', $sessid, 0);

            $ua = $_SERVER['HTTP_USER_AGENT'];
            $ip = $_SERVER['REMOTE_ADDR'];
            $id = session_id();
            $all = "$ua $ip $id";
            $all = sha1($all);
            $_SESSION['hash'] = htmlspecialchars($all);

            header("Location: dorf1.php");
            exit;
        }

        public function changeChecker()
        {
            global $generator;
            $this->checker = $_SESSION['checker'] = $generator->generateRandStr(3);
            $this->mchecker = $_SESSION['mchecker'] = $generator->generateRandStr(5);
        }

        public function setlang($lang = 'fa')
        {
            global $database;
            $_SESSION['lang'] = $lang;
            $database->modifyUser($_SESSION['username'], 'lang', $lang, 1);
            $params = session_get_cookie_params();
            setcookie('lang', $_SESSION['lang'], $_SERVER['REQUEST_TIME'] + 86400, $params["path"], $params["domain"], $params["secure"], $params["httponly"]);
        }

        private function Options()
        {
            if ((freegold_time + freegold_lasttime) < time()) {
                $giveGold = TRUE;
            } else {
                $giveGold = FALSE;
            }
            if ($giveGold) {
                $res = mysql_query("SELECT id FROM " . TB_PREFIX . "users");

                while ($row = mysql_fetch_assoc($res)) {

                    mysql_query("UPDATE " . TB_PREFIX . "users SET gold = gold + " . FREEGOLD_VALUE . " , giftgold = giftgold + " . FREEGOLD_VALUE . " WHERE id = " . $row['id'] . " AND access >= 2") or die(mysql_error());
                }
                mysql_query("UPDATE " . TB_PREFIX . "config SET freegold_lasttime = " . time()) or die(mysql_error());
            }
        }

        private function checkGoldSilverHack()
        {
            global $database;
            $ud = $database->getUser($this->uid, 1);
            $pgold = $ud['boughtgold'] + $ud['giftgold'] + $ud['seggold'] + $ud['transferedgold'];
            $ngold = $ud['usedgold'];
            $gb = $pgold - $ngold;
            if ($ud['gold'] < 0 || $ud['gold'] > $gb) {
                $gb = max(0, $gb);
                $database->modifyUser($this->uid, 'gold', $gb, 0);
                //$this->access = 0;
            }
            $psilver = $ud['giftsilver'] + $ud['gessilver'] + $ud['sisilver'];
            $nsilver = $ud['bisilver'];
            $sb = $psilver - $nsilver;
            if ($ud['silver'] < 0 || $ud['silver'] > $sb) {
                $database->modifyUser($this->uid, 'access', 0, 0);
                $this->access = 0;
            }
        }
    }

    ;

    $session = new Session;
    /*
    // Refresher System - no ban Just Logout Yet !
    $page = $_SERVER['REQUEST_URI'];
    if(isset($_SESSION[$page]['timer']) && time() - $_SESSION[$page]['timer'] < 5){
        $_SESSION[$page]['last_page'] = $page;
        // Defaults
        if(!isset($_SESSION[$page]['count']) OR $_SESSION[$page]['last_page'] != $_SERVER['REQUEST_URI'])
        {
            $_SESSION[$page]['count'] = 1;
            $_SESSION[$page]['first_hit'] = time();
            $_SESSION[$page]['banned'] = false;
        }
        else
        {
            $_SESSION[$page]['count']++; // Increase the counter
            $_SESSION[$page]['page'] = $page;
            $_SESSION[$page]['timer'] = time();
        }
        if($_SESSION[$page]['first_hit'] < time() - 5)
        {
            $_SESSION[$page]['count'] = 1; // Reset every 5 seconds
            $_SESSION[$page]['first_hit'] = time();
        }

        if($_SESSION[$page]['count'] > 10)
        {
            $_SESSION[$page]['banned'] = true;
            // Ban if they hit over 10 times in 30 seconds.
        }else{
            $_SESSION[$page]['banned'] = false;
        }

        // If person is banned, end script
        if($_SESSION[$page]['banned'] == true)
        {
            //$session->Logout();
        }
    }else{
        $_SESSION[$page]['timer'] = time();
    }
    */
    $ids_checkpost = urldecode($_SERVER['QUERY_STRING']);
    if (eregi("[\'|'/'\''<'>'*'~'`']", $ids_checkpost) || strstr($ids_checkpost, 'union') || strstr($ids_checkpost, 'java') || strstr($ids_checkpost, 'script') || strstr($ids_checkpost, 'substring(') || strstr($ids_checkpost, 'ord()')
        || strstr($ids_checkpost, 'http') || strstr($ids_checkpost, 'https') || strstr($ids_checkpost, 'www')
    ) {
        $hack_attempt = 1;
        // echo "<center><font color=red> Hack attempt <br/><br/>!!! WARNING !!! <br/>
        // Malicious Code Detected! The Admin has been notified !<br/><br/>
        // Your Ip Address Has Been Loged ! Your ip is : ".getIp()."</font></center>";
        header("Location:Hacking.php");
        die;
    }
    if (isset($block_INPUT) && !empty($block_INPUT)) {
        echo("<script>location='hacking.php'</script>");
        setcookie('COOKUID', $_COOKIE['COOKUID'] + 1, time() + 600);
        if ($_COOKIE['COOKUID'] >= 5) {
            $reason = 'forcing to hack , input: {' . $block_INPUT . '}, url: {' . $_SERVER['REQUEST_URI'] . '}';
            $fp = fopen('black.php', 'a+');
            fwrite($fp, "LOG [" . date('d/m/Y') . " " . date('G/i/s') . "] [" . $_SERVER['REMOTE_ADDR'] . "] [" . $reason . "]\n" . $_SERVER['REMOTE_ADDR'] . "\n");
        }
        if ($_COOKIE['COOKUID'] >= 10) {
            $reason = 'forcing to hack , input: {' . $block_INPUT . '}, url: {' . $_SERVER['REQUEST_URI'] . '}';
            $fp = fopen('black.php', 'a+');
            fwrite($fp, "LOG [" . date('d/m/Y') . " " . date('G/i/s') . "] [" . $_SERVER['REMOTE_ADDR'] . "] [" . $reason . "]\n" . $_SERVER['REMOTE_ADDR'] . "\n");
        }
    }

    $form = new Form;
    $message = new Message;

    include_once("Automation.php");
?>