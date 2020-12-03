<?php

    /*
    |--------------------------------------------------------------------------
    |   PLEASE DO NOT REMOVE THIS COPYRIGHT NOTICE!
    |--------------------------------------------------------------------------
    |
    |   Project owner:   Dzoki < dzoki.travian@gmail.com >
    |
    |   This script is property of TravianX Project. You are allowed to change
    |   its source and release it under own name, not under name `TravianX`.
    |   You have no rights to remove copyright notices.
    |
    |   TravianX All rights reserved
    |
    */

// print_r($_POST);die;
    class Alliance
    {

        public $gotInvite = FALSE;
        public $inviteArray = array();
        public $allianceArray = array();
        public $userPermArray = array();

        public function procAlliance($get)
        {
            global $session, $database;

            if ($session->alliance != 0) {
                $this->allianceArray = $database->getAlliance($session->alliance);
                // Permissions Array
                // [id] => id [uid] => uid [alliance] => alliance [opt1] => assign [opt2] => kick [opt3] => desc [opt4] => invite [opt5] => forum [opt6] => diplom [opt7] => IGM [opt8] => X
                $this->userPermArray = $database->getAlliPermissions($session->uid, $session->alliance);
            } else {
                $this->inviteArray = $database->getInvitation2($session->uid);
                $this->gotInvite = count($this->inviteArray) == 0 ? FALSE : TRUE;
            }
            if (isset($get['a'])) {
                switch ($get['a']) {
                    case 2:
                        $this->rejectInvite($get);
                        break;
                    case 3:
                        $this->acceptInvite($get);
                        break;
                    default:
                        break;
                }
            }
            if (isset($get['o'])) {
                switch ($get['o']) {
                    case 4:
                        if (isset($this->userPermArray['opt4']) && $this->userPermArray['opt4'] == 1) $this->delInvite($get);
                        break;
                    default:
                        break;
                }
            }
        }

        /*****************************************
         * Function to reject an invitation
         *****************************************/
        private function rejectInvite($get)
        {
            global $database, $session;
            foreach ($this->inviteArray as $invite) {
                if ($invite['id'] == $get['d']) {
                    $database->removeInvitation($get['d']);
                    $database->insertAlliNotice($session->alliance, '<a href="spieler.php?uid=' . $session->uid . '">' . addslashes($session->username) . '</a> ' . AL_REP3 . '.');
                }
            }
            //header("Location: build.php?id=".$get['id']);exit;
        }

        /*****************************************
         * Function to accept an invitation
         *****************************************/
        private function acceptInvite($get)
        {
            global $form, $database, $session;
            if ($session->access != BANNED) {
                foreach ($this->inviteArray as $invite) {
                    if ($invite['id'] == $get['d'] && $invite['uid'] == $session->uid) {
                        $alliance_info = $database->getAlliance($invite['alliance']);
                        $memberlist = $database->getAllMember($invite['alliance']);
                        $alliance_info['max'] = 12;
                        if (count($memberlist) < $alliance_info['max'] || $alliance_info['max'] == 0) {
                            $database->removeInvitation($database->RemoveXSS($get['d']));
                            $database->updateUserField($database->RemoveXSS($invite['uid']), "alliance", $database->RemoveXSS($invite['alliance']), 1);
                            $database->createAlliPermissions($database->RemoveXSS($invite['uid']), $database->RemoveXSS($invite['alliance']), '', '0', '0', '0', '0', '0', '0', '0', '0');
                            // Log the notice
                            $database->insertAlliNotice($invite['alliance'], '<a href="spieler.php?uid=' . $session->uid . '">' . addslashes($session->username) . '</a> ' . AL_REP5 . '.');
                        } else {
                            $accept_error = 1;
                            $max = $alliance_info['max'];
                        }
                    }
                }
                if ($accept_error == 1) {
                    $form->addError("error", sprintf(AL_REP6, $max));
                    function StrRegister1($TextVar)
                    {
                        $bug = array('', '!', '\'', '/', '"', '*', '=', '^', '&', '<', '>', '?');

                        return @str_replace($bug, '', $TextVar);
                    }

                    $_SESSION['error'] = 1;
                    $_SESSION['servernumber'] = $_POST['server'];
                    $_SESSION['errorarray'] = $form->getErrors();
                    $_SESSION['valuearray'] = StrRegister1($_POST);
                } else {
                    header("Location: build.php?id=" . $get['id']);
                }
            } else {
                header("Location: banned.php");
            }
            header("Location: build.php?id=" . $get['id']);
            exit;
        }

        /*****************************************
         * Function to del an invitation
         *****************************************/
        private function delInvite($get)
        {
            global $database, $session;
            $inviteArray = $database->getAliInvitations($session->alliance);
            foreach ($inviteArray as $invite) {
                if ($invite['id'] == $get['d']) {
                    $invitename = $database->getUserField($invite['uid'], 'username', 0);
                    $database->removeInvitation($get['d']);
                    $database->insertAlliNotice($session->alliance, '<a href="spieler.php?uid=' . $session->uid . '">' . addslashes($session->username) . '</a> ' . AL_REP4 . ' <a href="spieler.php?uid=' . $invite['uid'] . '">' . $invitename['username'] . '</a>.');
                }
            }
            //header("Location: build.php?id=".$get['id']);exit;
        }

        public function procAlliForm($post)
        {
            global $building, $database, $session;
            $this->userPermArray = $database->getAlliPermissions($session->uid, $session->alliance);
            if (isset($post['ft'])) {
                switch ($post['ft']) {
                    case "ali1":
                        $embassy = $building->getTypeLevel(18);
                        if ($embassy >= 3) $this->createAlliance($post);
                        break;
                }

            }
            if ($this->userPermArray['opt6'] and isset($_POST['dipl']) and isset($_POST['a_name'])) {
                $this->changediplomacy($post);
            }

            if (isset($post['s'])) {
                if (isset($post['o'])) {
                    switch ($post['o']) {
                        case 1:
                            if ($this->userPermArray['opt1'] && isset($_POST['a'])) {
                                $this->changeUserPermissions($post);
                            }
                            break;
                        case 2:
                            if ($this->userPermArray['opt2'] && isset($_POST['a_user'])) {
                                $this->kickAlliUser($post);
                            }
                            break;
                        case 4:
                            if ($this->userPermArray['opt4'] && isset($_POST['a']) && $_POST['a'] == 4) {
                                $this->sendInvite($post);
                            }
                            break;
                        case 3:
                            if ($this->userPermArray['opt3']) $this->updateAlliProfile($post);
                            break;
                        case 11:
                            $this->quitally($post);
                            break;
                        case 100:
                            if ($this->userPermArray['opt3']) $this->changeAliName($post);
                            break;
                    }
                }
            }
            // header("Location: ".$_SERVER['PHP_SELF']);
        }

        /*****************************************
         * Function to create an alliance
         *****************************************/
        private function createAlliance($post)
        {
            global $form, $database, $session, $bid18, $village;
            if (!isset($post['ally1']) || $post['ally1'] == "") {
                $form->addError("error", AL_ATAGEMPTY);
            }
            if (!isset($post['ally2']) || $post['ally2'] == "") {
                $form->addError("error", AL_ANAMEEMPTY);
            }
            if ($database->aExist($post['ally1'], "tag")) {
                $form->addError("error", AL_ATAGEXIST);
            }
            if ($database->aExist($post['ally2'], "name")) {
                $form->addError("error", AL_ANAMEEXIST);
            }
            if ($form->returnErrors() != 0) {
                $_SESSION['errorarray'] = $form->getErrors();
                $_SESSION['valuearray'] = $post;
                header("Location: build.php?id=" . $post['id']);
                exit;
            } else {
                $max = $bid18[$village->resarray['f' . $post['id']]]['attri'];
                $aid = $database->createAlliance($database->RemoveXSS($post['ally1']), $database->RemoveXSS($post['ally2']), $session->uid, $max);
                $database->updateUserField($database->RemoveXSS($session->uid), "alliance", $database->RemoveXSS($aid), 1);
                // Asign Permissions
                $database->createAlliPermissions($database->RemoveXSS($session->uid), $database->RemoveXSS($aid), AL_REP6_2, '1', '1', '1', '1', '1', '1', '1', '1');
                // log the notice
                $database->insertAlliNotice($session->alliance, AL_REP7.' <a href="spieler.php?uid=' . $session->uid . '">' . addslashes($session->username) . '</a>');
                header("Location: build.php?id=" . $post['id']);
                exit;
            }
        }

        private function changediplomacy($post)
        {
            global $database, $session, $form;

            $aName = $database->RemoveXSS($post['a_name']);
            $aType = (int)intval($post['dipl']);
            if ($database->aExist($aName, "tag")) {
                if ($database->getAllianceID($aName) != $session->alliance) {
                    if ($aType >= 1 and $aType <= 3) {
                        if (!$database->diplomacyInviteCheck($database->getAllianceID($aName), $session->alliance)) {
                            if ($aType == 1) {
                                $notice = AL_REP8;
                            } else if ($aType == 2) {
                                $notice = AL_REP9;
                            } else if ($aType == 3) {
                                $notice = AL_REP10;
                            }
                            $database->insertAlliNotice($session->alliance, '<a href="allianz.php?aid=' . $session->alliance . '">' . $database->getAllianceName($session->alliance) . '</a> ' . $notice . ' <a href="allianz.php?aid=' . $database->getAllianceID($aName) . '">' . $aName . '</a>.');

                            $database->diplomacyInviteAdd($session->alliance, $database->getAllianceID($aName), $aType);
                            $form->addError("error", AL_REP11);
                        } else {
                            $form->addError("error", AL_REP12);
                        }

                    } else {
                        $form->addError("error",AL_REP13);
                    }
                } else {
                    $form->addError("error", AL_REP14);
                }
            } else {
                $form->addError("error", AL_ALLYNTEX);
            }
            if ($form->returnErrors() != 0) {
                $_SESSION['errorarray'] = $form->getErrors();
                $_SESSION['valuearray'] = $post;
                header("Location: allianz.php?s=5&o=6");
                exit;
            }
        }

        /*****************************************
         * Function to change the user permissions
         *****************************************/
        private function changeUserPermissions($post)
        {
            global $database, $session, $form;
            if ($this->userPermArray['opt1'] == 0) {
                $form->addError("error", AL_NOPERM);
            }
            if ($form->returnErrors() != 0) {
                $_SESSION['errorarray'] = $form->getErrors();
                $_SESSION['valuearray'] = $post;
                header("Location: allianz.php?s=5&o=1");
                exit;
            } else {
                $database->updateAlliPermissions($post['a_user'], $session->alliance, $post['a_titel'], $post['e1'], $post['e2'], $post['e3'], $post['e4'], $post['e5'], $post['e6'], $post['e7'], $post['e8']);
                // log the notice
                $database->insertAlliNotice($session->alliance, '<a href="spieler.php?uid=' . $session->uid . '">' . addslashes($session->username) . '</a> '.AL_REP15.'.');
            }

        }

        /*****************************************
         * Function to kick a user from alliance
         *****************************************/
        private function kickAlliUser($post)
        {
            global $database, $session, $form;
            if ($session->access != BANNED) {
                $UserData = $database->getUser($post['a_name'], 0);
                if ($this->userPermArray['opt2'] == 0) {
                    $form->addError("error", AL_NOPERM);
                } // Can't kick self
                else if ($UserData['id'] != $session->uid) {
                    if ($database->isAllianceOwner($UserData['id'])) {
                        // Can't kick owner
                        $form->addError("error", AL_REP16);
                    }
                }else{
                    $form->addError("error", AL_REP19);
                }
                if ($form->returnErrors() != 0) {
                    $_SESSION['errorarray'] = $form->getErrors();
                    $_SESSION['valuearray'] = $post;
                    header("Location: allianz.php?s=5&o=2");
                    exit;
                } else {
                    $database->updateUserField($post['a_user'], 'alliance', 0, 1);
                    $database->deleteAlliPermissions($post['a_user']);
                    // log the notice
                    $database->insertAlliNotice($session->alliance, '<a href="spieler.php?uid=' . $session->uid . '">' . addslashes($session->username) . '</a> '.AL_REP17.' <a href="spieler.php?uid=' . $post['a_user'] . '">' . $UserData['username'] . '</a> '.AL_REP18.'!.');
                    //header("Location: build.php?id=".$post['id']);exit;
                }
            } else {
                header("Location: banned.php");
                die;
            }
        }

        /*****************************************
         * Function to process of sending invitations
         *****************************************/
        public function sendInvite($post)
        {
            global $form, $database, $session;

            $UserData = $database->getUser($post['a_name'], 0);

            // �El campo posee informacion?
            if (!isset($post['a_name']) || $post['a_name'] == "") {
                $form->addError("error", AL_ANAMEEMPTY);
            }
            // �Existe el usuario?
            elseif (!$database->checkExist($post['a_name'], 0)) {
                $form->addError("error", US_USRNTFOUND);
            }
            // �La invitacion es a si mismo?
            elseif ($post['a_name'] == (addslashes($session->username))) {
                $form->addError("error", AL_SAMENAME);
            }
            // �Esta ya invitado a la alianza?

            elseif ($database->getInvitation($UserData['id'], $session->alliance)) {
                $form->addError("error", AL_ALREADYINVITED);
            }
            // �Esta ya en la alianza?
            //$UserData = $database->getUser($post['a_name'], 0);
            elseif ($UserData['alliance'] == $session->alliance) {
                $form->addError("error", AL_ALREADYINALLY);
            }
            // �La invitaci�n la envia un autorizado?
            elseif ($this->userPermArray['opt4'] == 0) {
                $form->addError("error", AL_NOPERM);
            }
            if ($form->returnErrors() != 0) {
                $_SESSION['errorarray'] = $form->getErrors();
                $_SESSION['valuearray'] = $post;
                header("Location: allianz.php?s=5&o=4");
                die;
            } else {
                // Obtenemos la informacion necesaria
                $aid = $session->alliance;
                // Insertamos invitacion
                $database->sendInvitation($UserData['id'], $aid, $session->uid);
                // Log the notice
                $database->insertAlliNotice($session->alliance, '<a href="spieler.php?uid=' . $session->uid . '">' . addslashes($session->username) . '</a> ' . AL_REP1 . ' <a href="spieler.php?uid=' . $UserData['id'] . '">' . $UserData['username'] . '</a> ' . AL_REP2 . '.');
            }
        }

        /*****************************************
         * Function to create/change the alliance description
         *****************************************/
        private function updateAlliProfile($post)
        {
            global $database, $session, $form;
            if ($this->userPermArray['opt3'] == 0) {
                $form->addError("error", AL_NOPERM);
            }
            if ($form->returnErrors() != 0) {
                $_SESSION['errorarray'] = $form->getErrors();
                $_SESSION['valuearray'] = $post;
                //header("Location: build.php?id=".$post['id']);exit;
            } else {
                $database->submitAlliProfile($database->RemoveXSS($session->alliance), $database->RemoveXSS($post['be2']), $database->RemoveXSS($post['be1']));
                // log the notice
                $database->insertAlliNotice($session->alliance, '<a href="spieler.php?uid=' . $session->uid . '">' . addslashes($session->username) . '</a> '.AL_REP20.'.');
            }
        }

        /*****************************************
         * Function to quit from alliance
         *****************************************/

        private function quitally($post)
        {
            global $database, $session, $form;
            if (!isset($post['pw']) || $post['pw'] == "") {
                $form->addError("error", US_PWEMPTY);
            } elseif ($this->generateHash($post['pw']) !== $session->userinfo['password']) {
                $form->addError("error", US_LOGINPWERROR);
            } else {
                if ($database->isAllianceOwner($session->uid)) {
                    $allmembers = $database->getAllMember($session->alliance);
                    $newleader = $allmembers[1];
                    $q = "UPDATE " . TB_PREFIX . "alidata set leader = " . $newleader['id'] . " where id = " . $session->alliance . "";
                    $database->query($q);
                    $database->updateAlliPermissions($newleader['id'], $session->alliance, 'Interim Leader', 1, 1, 1, 1, 1, 1, 1, 1);
                }
                $database->updateUserField($session->uid, 'alliance', 0, 1);
                $database->deleteAlliPermissions($session->uid);
                $database->deleteAlliance($session->alliance);
                $database->insertAlliNotice($session->alliance, '<a href="spieler.php?uid=' . $session->uid . '">' . addslashes($session->username) . '</a> '.AL_REP21);
                header("Location: dorf1.php");
                exit;
            }
        }

        function generateHash($plainText, $salt = 1)
        {
            $salt = substr($salt, 0, 9);

            return $salt . md5($salt . $plainText);
        }

        /*****************************************
         * Function to change the alliance name
         *****************************************/
        private function changeAliName($post)
        {
            global $form, $database, $session;
            if (!$database->isAllianceOwner($session->uid)) {
                $form->addError("error", AL_REP22);
            }
            if (!isset($post['ally1']) || $post['ally1'] == "") {
                $form->addError("error", AL_ATAGEMPTY);
            }
            if (!isset($post['ally2']) || $post['ally2'] == "") {
                $form->addError("error", AL_ANAMEEMPTY);
            }
            if ($database->aExist($post['error'], "tag")) {
                $ea = $database->getAlliance($post['ally1'], 2);
                if ($ea['id'] != $session->alliance) $form->addError("error", AL_ATAGEXIST);
            }
            if ($database->aExist($post['error'], "name")) {
                $ea = $database->getAlliance($post['ally2'], 1);
                if ($ea['id'] != $session->alliance) $form->addError("error", AL_ANAMEEXIST);
            }
            if ($this->userPermArray['opt3'] == 0) {
                $form->addError("error", AL_NOPERM);
            }
            if ($form->returnErrors() != 0) {
                $_SESSION['errorarray'] = $form->getErrors();
                $_SESSION['valuearray'] = $post;
                header("Location: allianz.php?s=5&o=100");exit;
            } else {
                $database->setAlliName($session->alliance, $database->RemoveXSS($post['ally2']), $database->RemoveXSS($post['ally1']));
                // log the notice
                $database->insertAlliNotice($session->alliance, '<a href="spieler.php?uid=' . $session->uid . '">' . addslashes($session->username) . '</a> '.AL_REP23.'.');
            }
        }
    }

    $alliance = new Alliance;
?>