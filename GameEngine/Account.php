<?php
/**********************************************
/ All Of the Copy Rights Of The Script Is Reserved For vikings.ir
/	You may have made some changes but You Have No Right To remove This Copy Right!
/	For Debug And Support Just Contact Me :09335751872 just sms
/	Yahoo ID: gorz1872@yahoo.com
/
*/
    include_once("Session.php");

    class Account
    {
        function Account()
        {
            global $session;
            if (isset($_POST['ft'])) {
                switch ($_POST['ft']) {
                    case 'a0':
                        $this->Signup2();
                        break;
                    case "a1":
                        $this->Signup();
                        break;
                    case "a2":
                        $this->Activate();
                        break;
                    case "a3":
                        $this->Unreg();
                        break;
                    case "a4":
                        $this->Login();
                        break;
                    case 'a5':
                        $this->resend();
                        break;
                    case 'a6':
                        $this->changemail();
                        break;
                }
            }
            if (isset($_POST['forgotPassword']) && $_POST['forgotPassword'] == 1) {
                $this->forgotPassword($_POST['pw_email']);
            }
            if (isset($_POST['code'])) {
                $_POST['id'] = $_POST['code'];
                $this->Activate();
            } else {
                if ($session->logged_in && in_array("logout.php", explode("/", $_SERVER['PHP_SELF']))) {
                    $this->Logout();
                }
            }
        }

        private function Signup2()
        {
            global $database, $session;

            $uid = filter_var($_POST['uid'], FILTER_SANITIZE_NUMBER_INT);
            // $uid = abs($uid);
            $vid = filter_var($_POST['vid'], FILTER_SANITIZE_NUMBER_INT);
            $vid = abs($vid);

            switch ($vid) {
                case 1:
                    $tb = 1;
                    break;
                case 2:
                    $tb = 2;
                    break;
                case 3:
                    $tb = 3;
                    break;
                default:
                    $tb = 1;
                    break;
            }

            $reg2 = $database->checkreg($uid);
            $reg = $reg2['reg2'];

            if ($reg == 1) {
                $database->settribe($tb, $uid);
                $reg2 = $database->checkname($uid);
                $name = $reg2['username'];
                //$email = $reg2['email'];
                setcookie('COOKUSR', $name, time() + COOKIE_EXPIRE, COOKIE_PATH);
                $frandom0 = rand(0, 3);
                $frandom1 = rand(0, 3);
                $frandom2 = rand(0, 4);
                $frandom3 = rand(0, 3);
                $database->addHeroFace($uid, $frandom0, $frandom1, $frandom2, $frandom3, $frandom3, $frandom2, $frandom1, $frandom0, $frandom2);
                $database->addHero($uid);
                $database->updateUserField($uid, "act", "", 1);
                $_POST['sector'] = filter_var($_POST['sector'], FILTER_SANITIZE_SPECIAL_CHARS);
                // echo $_POST['sector']."<br>";
                $this->generateBase($_POST['sector'], $uid, $name);
                // die;
                $database->modifyUnit($database->getVFH($uid), 'hero', 1, 1);
                $database->modifyHero($uid, 0, 'wref', $database->getVFH($uid), 0);
                for ($s = 1; $s <= 3; $s++) {
                    $database->addAdventure($database->getVFH($uid), $uid);
                }
                $database->setreg2($uid);
                $database->modifyGold($uid, Activate_Plus, 1);
                $time = time() + (MINPROTECTION * 2);
                mysql_query("UPDATE " . TB_PREFIX . "users set protect = '" . $time . "' WHERE id = " . $uid) or die(mysql_error());

                mysql_query("INSERT INTO " . TB_PREFIX . "users_setting (`id`) values ('" . $uid . "')") or die(mysql_error());

                $times = time() + EXTRAPLUS;
                mysql_query("UPDATE " . TB_PREFIX . "users set plus = '" . $times . "' WHERE id = " . $uid) or die(mysql_error());

                $session->login($name);

            }
        }

        function generateBase($kid, $uid, $username)
        {
            global $database, $message;
            if ($kid == '') {
                $kid = rand(1, 4);
            }
            if ($kid == 'nw') {
                $kid = 2;
            } elseif ($kid == 'no') {
                $kid = 3;
            } elseif ($kid == 'sw') {
                $kid = 1;
            } elseif ($kid == 'so') {
                $kid = 4;
            }

            $wid = $database->generateBase($kid);
            $database->setFieldTaken($wid);
            $database->addVillage($wid, $uid, $username, 1);
            $database->addResourceFields($wid, $database->getVillageType($wid));
            $database->addUnits($wid);
            $database->addTech($wid);
            $database->addABTech($wid);
            $database->updateUserField($uid, "access", USER, 1);
            $database->updateUserField($uid, "location", "", 1);
            $message->sendWelcome($uid, $username);
        }

               private function Signup() {
                global $database,$form,$mailer,$generator,$session;
                if(!isset($_POST['name']) || trim($_POST['name']) == "") {
                        $form->addError("name",USRNM_EMPTY);
                } else {
                        if(strlen($_POST['name']) < USRNM_MIN_LENGTH) {
                                $form->addError("name",USRNM_SHORT);
                        }
                        else if(!USRNM_SPECIAL && preg_match('/[^0-9A-Za-z]/',$_POST['name'])) {
                                $form->addError("name",USRNM_CHAR);
                        }
                        else if($database->checkExist($_POST['name'],0)) {
                                $form->addError("name",USRNM_TAKEN);
                        }
                        else if($database->checkExist_activate($_POST['name'],0)) {
                                $form->addError("name",USRNM_TAKEN);
                        }
                        else if($_POST['name']=="admin" || $_POST['name']=="admin" || $_POST['name']=="Admin" ) {
                                $form->addError("name",REG_ADMIN);
                        }                        
                }
                if(!isset($_POST['pw']) || $_POST['pw'] == "") {
                        $form->addError("pw",PW_EMPTY);
                } else {
                        if(strlen($_POST['pw']) < PW_MIN_LENGTH) {
                                $form->addError("pw",PW_SHORT);
                        }
                        else if($_POST['pw'] == $_POST['name']) {
                                $form->addError("pw",PW_INSECURE);
                        }
                }
                if(!isset($_POST['email'])) {
                        $form->addError("email",EMAIL_EMPTY);
                } else {
                        if(!$this->validEmail($_POST['email'])) {
                                $form->addError("email",EMAIL_INVALID);
                        }
                        else if($database->checkExist($_POST['email'],1)) {
                                $form->addError("email",EMAIL_TAKEN);
                        }
                        else if($database->checkExist_activate($_POST['email'],1)) {
                                $form->addError("email",EMAIL_TAKEN);
                        }
                }
                if(!isset($_POST['vid'])) {
                        $form->addError("tribe",TRIBE_EMPTY);
                }
                if(!isset($_POST['agb'])) {
                        $form->addError("agree",AGREE_ERROR);
                }
                if($form->returnErrors() > 0) {
                        $_SESSION['errorarray'] = $form->getErrors();
                        $_SESSION['valuearray'] = $_POST;
                        
                        header("Location: anmelden.php");
                } else


                if (isset($_POST['name']) && isset($_POST['pw']) && isset($_POST['email'])) {
                    function StrRegister2($TextVar)
                    {
                        $bug = array('', '!', '\'', '/', '"', '!', '%', '*', '(', '$', '#', '^', '&', ')', '<', '>', '?', '{', '}', '[', ']');

                        return @str_replace($bug, '', $TextVar);
                    }

                    $act = $generator->generateRandStr(10);
                    if (AUTH_EMAIL) {

                        $uid = $database->activate(StrRegister2($_POST['name']), $_POST['pw'], $_POST['email'], $act, $_POST['server'], '');
                        if (isset($_POST['ref']) && is_numeric($_POST['ref'])) {
                            $name1 = $database->checkname($_POST['ref']);
                            $name = $name1['username'];
                            $database->setref($uid, $name);
                        }
                        if ($uid) {
                            $mailer->sendActivate($_POST['email'], StrRegister2($_POST['name']), $_POST['pw'], $act, $_POST['server']);
                            header('Location: ' . HOMEPAGE . '/?worldid=' . $_POST['server'] . '#activation');
                            exit;
                        }
                    } else if (!AUTH_EMAIL) {
                        function StrRegister3($TextVar)
                        {
                            $bug = array('', '!', '\'', '/', '"', '!', '%', '*', '(', '$', '#', '^', '&', ')', '<', '>', '?', '{', '}', '[', ']');

                            return @str_replace($bug, '', $TextVar);
                        }

                        $uid = $database->register2(StrRegister3($_POST['name']), md5($_POST['pw']), $_POST['email'], $act, time());
                        if (isset($_POST['ref']) && is_numeric($_POST['ref'])) {
                            $name1 = $database->checkname($_POST['ref']);
                            $name = $name1['username'];
                            $database->setref($uid, $name);
                        }
                        $reg2 = $database->checkreg2(StrRegister3($_POST['name']));
                        $mailer->sendActivate2($_POST['email'], StrRegister2($_POST['name']), $_POST['pw'], $_POST['server']);
                        $reg = $reg2['reg2'];
                        // $u = $database->checkid(StrRegister3($_POST['name']));
                        // $ui = $u['id'];
                        if ($reg == 1) {
                            // $pq = rand(0, 100000000);
                            setcookie("COOKUSR", $_POST['name'], time() + 3600); /* expire in 1 hour */
                          header("Location: login.php");                          
						  exit;
                        }
                    }
                }
        }

        private function process_si_contact_form2()
        {
            $_SESSION['ctform'] = array(); // re-initialize the form session data
            // if the form has been submitted
            foreach ($_POST as $key => $value) {
                if (!is_array($key)) {
                    // sanitize the input data
                    $_POST[$key] = htmlspecialchars(stripslashes(trim($value)));
                }
            }

            $captcha = $_POST['ct_captcha']; // the user's entry for the captcha code
            $errors = array(); // initialize empty error array

            // Only try to validate the captcha if the form has no errors
            // This is especially important for ajax calls

            require('securimage.php');

            $securimage = new Securimage();

            if ($securimage->check($captcha) == FALSE) {
                $errors['captcha_error'] = 'Incorrect security code entered<br />';
            }

            if (sizeof($errors) == 0) {
                $time = $securimage->getTimeToSolve();
                if ($time > 3) {
                    return TRUE;
                } else {
                    return FALSE;
                }
            } else {
                return FALSE;
            }

            return FALSE; // clear success value after running
        }

        private function validEmail($email)
        {
            $regexp = "/^[a-z0-9]+([_\\.-][a-z0-9]+)*@([a-z0-9]+([\.-][a-z0-9]+)*)+\\.[a-z]{2,}$/i";
            if (!preg_match($regexp, $email)) {
                return FALSE;
            }

            return TRUE;
        }

        function generateHash($plainText, $salt = 1)
        {
            $salt = substr($salt, 0, 9);
            return $salt . md5($salt . $plainText);
        }

        private function Activate()
        {
            global $database, $form;
            $q = "SELECT * FROM " . TB_PREFIX . "activate where act = '" . $_POST['id'] . "'";
            $result = mysql_query($q, $database->connection);
            $dbarray = mysql_fetch_array($result);
            if ($_POST['id'] == '') {
                $form->addError('activation', 'enter activation code');
            } elseif ($dbarray['act'] == $_POST['id'] && $_POST['id'] != '' && $dbarray['act'] != '') {
                // echo "YES";die;
                function StrRegister3($TextVar)
                {
                    $bug = array('', '!', '\'', '/', '"', '!', '%', '*', '(', '$', '#', '^', '&', ')', '<', '>', '?', '{', '}', '[', ']');

                    return @str_replace($bug, '', $TextVar);
                }

                $uid = $database->register2(StrRegister3($dbarray['username']), $this->generateHash($dbarray['password']), $dbarray['email'], '', time());
                if ($uid) {
                    $database->unreg($dbarray['username']);
                    header('Location: ' . $dbarray['location'] . '/login.php');
                    exit;
                }
            } else {
                $form->addError('activation', 'Activation code is wrong or account activated before.');
            }

            if ($form->returnErrors() > 0) {
                function StrRegister1($TextVar)
                {
                    $bug = array('', '!', '\'', '/', '"', '*', '=', '^', '&', '<', '>', '?');

                    return @str_replace($bug, '', $TextVar);
                }

                $_SESSION['error'] = 1;
                $_SESSION['servernumber'] = $_POST['server'];
                $_SESSION['errorarray'] = $form->getErrors();
                $_SESSION['valuearray'] = StrRegister1($_POST);
                header('Location: ../?sv=' . $_POST['server'] . '#activation');
                exit;
            }
        }

        private function Unreg()
        {
            global $database, $form;
            $q = "SELECT * FROM " . TB_PREFIX . "activate where username = '" . $_POST['name'] . "'";
            $result = mysql_query($q, $database->connection);
            $dbarray = mysql_fetch_array($result);
            if (md5($_POST['pw']) == $dbarray['password']) {
                $database->unreg($dbarray['username']);
                header('Location: ../#activation');
                exit;
            } else {
                $form->addError("unreg", 'Wronge username or password');
                $form->addError('page', '1');
                $_SESSION['errorarray'] = $form->getErrors();
                $_SESSION['valuearray'] = $_POST;
                header('Location: ../#activation');
                exit;
            }
        }

        private function Login()
        {
            global $database, $session, $form;
            if (!isset($_POST['user']) || $_POST['user'] == "") {
                $form->addError("user", US_USRNM_EMPTY);
            } else if (!$database->checkExist($_POST['user'], 0)) {
                $form->addError("user", US_USRNTFOUND);
            }
            if (!isset($_POST['pw']) || $_POST['pw'] == "") {
                $form->addError("pw", US_PWEMPTY);
            } else if (!$database->login($_POST['user'], $_POST['pw']) && !$database->sitterLogin($_POST['user'], $_POST['pw'])) {
                $form->addError("pw", US_LOGINPWERROR);
            }
            if (AUTH_EMAIL) {
                if ($database->getUserField($_POST['user'], "reg2", 1) == 1) {
                    $form->addError("activate", $_POST['user']);
                }
            }
            if ($_SESSION['LOGIN_FAILED'] > 3) {
                if (!$this->process_si_contact_form()) { // Process the form, if it was submitted
                    $form->addError('captcha', 'Wrong Captcha');
                }
            }
            if (!isset($_POST['pw']) || $_POST['pw'] == '') {
                $form->addError('pw', US_PWEMPTY);
            } else if (!$database->login($_POST['user'], $_POST['pw']) && !$database->sitterLogin($_POST['user'], $_POST['pw'])) {
                $form->addError('pw', "Wrong Username Or Password");
                setcookie('COOKUID', $_COOKIE['COOKUID'] + 1, time() + 600);
                if ($_COOKIE['COOKUID'] >= 10) {
                    $reason = 'brute force account';
                    $fp = fopen('black.list', 'a+');
                    fwrite($fp, "LOG [" . date('d/m/Y') . " " . date('G/i/s') . "] [" . $_SERVER['REMOTE_ADDR'] . "] [" . $reason . "]\n" . $_SERVER['REMOTE_ADDR'] . "\n");
                }
            }
            if (COMMENCE > time()) {
                $form->addError("pw", 'US_CANTLOGIN');
            }
            if (!isset($_SESSION['LOGIN_FAILED'])) $_SESSION['LOGIN_FAILED'] = 0;
            if ($form->returnErrors() > 0) {
                $_SESSION['errorarray'] = $form->getErrors();
                $_SESSION['valuearray'] = $_POST;
                $_SESSION['LOGIN_FAILED']++;
                header("Location: login.php");
                exit;
            } else {
                if (isset($_POST['lowRes']) && $_POST['lowRes'] == 1) {
                    setcookie('lowRes', 1, time() + COOKIE_EXPIRE, COOKIE_PATH);
                } elseif (!isset($_POST['lowRes'])) {
                    setcookie('lowRes', 0, time() - COOKIE_EXPIRE, COOKIE_PATH);
                }
                setcookie("COOKUSR", $_POST['user'], time() + COOKIE_EXPIRE, COOKIE_PATH);
                if ($database->sitterLogin($_POST['user'], $_POST['pw'])) {
                    $database->UpdateOnline("login", $_POST['user'], 1);
                } else {
                    $reg2 = $database->checkreg2($_POST['user']);
                    $reg = $reg2['reg2'];
                    $u = $database->checkid($_POST['user']);
                    $ui = $u['id'];
                    if ($reg == 1) {
                        function generateRandomString($length = 40)
                        {
                            $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
                            $randomString = '';
                            for ($i = 0; $i < $length; $i++) {
                                $randomString .= $characters[rand(0, strlen($characters) - 1)];
                            }

                            return $randomString;
                        }

                        $pq = generateRandomString(25);
                        // $ran = rand(45, 68954);
                        // $ran = generateRandomString();
                        function generateHash($plainText, $salt = 1)
                        {
                            $salt = substr($salt, 0, 9);

                            return $salt . sha1($salt . $plainText);
                        }

                        // $ui =  generateHash($ui);
                        setcookie('MYUID', $ui, 0);
                        $_SESSION['token'] = $pq;
                        header("Location: activate.php?token=$pq&cv=$ui");
                        exit;
                    } else {
                        $database->UpdateOnline("login", $_POST['user'], 0);
                    }
                }
                $_SESSION['LOGIN_FAILED'] = 0;

                $session->login($_POST['user']);
            }
        }

        private function process_si_contact_form()
        {
            $_SESSION['ctform'] = array(); // re-initialize the form session data
            // if the form has been submitted
            foreach ($_POST as $key => $value) {
                if (!is_array($key)) {
                    // sanitize the input data
                    $_POST[$key] = htmlspecialchars(stripslashes(trim($value)));
                }
            }

            $captcha = $_POST['ct_captcha']; // the user's entry for the captcha code
            $errors = array(); // initialize empty error array

            // Only try to validate the captcha if the form has no errors
            // This is especially important for ajax calls

            require('Security/securimage.php');
            $securimage = new Securimage();

            if ($securimage->check($captcha) == FALSE) {
                $errors['captcha_error'] = 'Incorrect security code entered<br />';
            }

            if (sizeof($errors) == 0) {
                $time = $securimage->getTimeToSolve();
                if ($time > 3) {
                    return TRUE;
                } else {
                    return FALSE;
                }
            } else {
                return FALSE;
            }

            return FALSE; // clear success value after running
        }

        private function resend()
        {
            global $database, $form, $mailer;
            $_POST['email'] = filter_var($_POST['email'], FILTER_SANITIZE_EMAIL);
            $q = "SELECT * FROM " . TB_PREFIX . "activate where email = '" . $_POST['email'] . "' LIMIT 1";
            $result = mysql_query($q, $database->connection);
            if ($dbarray = mysql_fetch_assoc($result)) {
                // if (!empty($_REQUEST['captcha'])){
                // var_dump($this->process_si_contact_form());die;
                if (!$this->process_si_contact_form2()) { // Process the form, if it was submitted
                    $form->addError('captcha', 'Wrong Captcha');
                    $form->addError('page', '1');
                } else {
                    if ($_POST['email'] == null || $_POST['email'] == '') {
                        $form->addError('email', 'Enter email');
                        $form->addError('page', '1');
                    } else {
                        if ($dbarray['email'] == $_POST['email']) {
                            // $em1 = $database->resendact($dbarray['email']);
                            // $email = $dbarray['email'];
                            // $name = $dbarray['username'];
                            // $pw = $dbarray['password'];
                            // $id = $dbarray['id'];
                            // $q2 = "SELECT * FROM ".TB_PREFIX."activate where act = '".$id."' LIMIT 1";
                            // $result2 = mysql_query($q2, $database->connection);
                            // $dbarray2 = mysql_fetch_assoc($result2);
                            // if($dbarray['id'] == $id){
                            $mailer->sendActivate($dbarray['email'], $dbarray['username'], $dbarray['password'], $dbarray['act'], $dbarray['location']);
                            $form->addError('send', 'activation code send');
                            $form->addError('page', '1');
                            // unset($_SESSION['captcha']);
                            // }
                            // else{
                            // $form->addError('email','This email is not available');
                            // $form->addError('page','1');
                            // }
                        } else {
                            $form->addError('email', 'This email is not available');
                            $form->addError('page', '1');
                        }
                    }
                }
                // }else{
                // $form->addError('capt','کد امنيتي وارد نشده است');
                // $form->addError('page','1');
                // }
            } else {
                $form->addError('email', 'wrong email');
                $form->addError('page', '1');
            }
            if ($form->returnErrors() > 0) {
                function StrRegister1($TextVar)
                {
                    $bug = array('', '!', '\'', '/', '"', '*', '=', '^', '&', '<', '>', '?');

                    return @str_replace($bug, '', $TextVar);
                }

                $_SESSION['errorarray'] = $form->getErrors();
                $_SESSION['valuearray'] = StrRegister1($_POST);
                header('Location: ../#activation');
                exit;
            }
        }

        private function changemail()
        {
            global $database, $form, $mailer;
            $_POST['oldEmail'] = filter_var($_POST['oldEmail'], FILTER_SANITIZE_EMAIL);
            $_POST['newEmail'] = filter_var($_POST['newEmail'], FILTER_SANITIZE_EMAIL);
            $_POST['password'] = filter_var($_POST['password'], FILTER_SANITIZE_SPECIAL_CHARS);
            $q = "SELECT * FROM " . TB_PREFIX . "activate where email = '" . $_POST['oldEmail'] . "' OR username = '" . $_POST['oldEmail'] . "' LIMIT 1";
            $result = mysql_query($q, $database->connection);
            $dbarray = mysql_fetch_assoc($result);

            if ($_POST['oldEmail'] != '' && $_POST['newEmail'] != '' && $_POST['password'] != '') {
                if ($dbarray['email'] == $_POST['oldEmail'] OR $dbarray['username'] == $_POST['oldEmail']) {
                    if ($this->validEmail($_POST['newEmail'])) {
                        if (!$database->checkExist($_POST['newEmail'], 1)) {
                            if ($dbarray['password'] == $this->generateHash($_POST['password'])) {
                                $id = $dbarray['id'];
                                $mail = $_POST['newEmail'];
                                $this->changeEmail($mail, $id);
                                $mailer->sendActivate($mail, $dbarray['username'], $dbarray['password'], $dbarray['act'], $dbarray['location']);
                                $form->addError('chm', 'Your Email Address was change');
                                $form->addError('page', '2');
                            } else {
                                $form->addError('pass2', 'Wrong password');
                                $form->addError('page', '2');
                            }
                            //wrong pass
                        } else {
                            $form->addError('email2', 'This email is not available');
                            $form->addError('page', '2');
                        }
                        //EMAIL_TAKEN
                    } else {
                        $form->addError('email2', 'Wrong Email');
                        $form->addError('page', '2');
                    }
                    //Email wrong
                } else {
                    $form->addError('email3', 'Wrong Email');
                    $form->addError('page', '2');
                }
                //email not match

            } else {
                $form->addError('pass2', 'All fields are required');
                $form->addError('page', '2');
            } //enter pass
            if ($form->returnErrors() > 0) {
                function StrRegister1($TextVar)
                {
                    $bug = array('', '!', '\'', '/', '"', '*', '=', '^', '&', '<', '>', '?');

                    return @str_replace($bug, '', $TextVar);
                }

                $_SESSION['errorarray'] = $form->getErrors();
                $_SESSION['valuearray'] = StrRegister1($_POST);
                header('Location: ../#activation');
                exit;
            }
        }

        private function changeEmail($mail, $id)
        {
            global $database;
            $q = "UPDATE " . TB_PREFIX . "activate set email='$mail' WHERE id ='$id'";
            mysql_query($q, $database->connection);
        }

        private function forgotPassword($email)
        {
            global $database, $generator, $form, $mailer;
            $npw = $generator->generateRandStr(6);
            $act = $generator->generateRandStr(10);
            $getData = $database->getUserWithEmail($email);
            if ($email == "") {
                $form->addError("pw_email", US_EMAILEMPTY);
            } elseif ($database->checkProcExist($getData['id'])) {
                if ($database->checkExist($email, 1)) {
                    $database->addNewProc($getData['id'], $npw, 0, $act, 0);
                    $mailer->sendPassword($email, $getData['id'], $getData['username'], $npw, $act);
                } else {
                    $form->addError("pw_email", US_EMAILINVALID);
                }
            } else {
                $form->addError("pw_email", US_EMAILTAKEN);
            }
            if ($form->returnErrors() > 0) {
                $_SESSION['errorarray'] = $form->getErrors();
                $_SESSION['valuearray'] = $_POST;
            } else {
                header("Location: login.php?action=forgotPassword&finish=true");
                exit;
            }
        }

        private function Logout()
        {
            global $session, $database;
            unset($_SESSION['wid']);
            $database->activeModify(addslashes($session->username), 1);
            $database->UpdateOnline("logout", $session->username, 0);
            $session->Logout();
        }
    }

    ;
    $account = new Account;
?>
