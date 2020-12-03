<?php

    class Profile
    {
        public function procProfile($post)
        {
            //var_dump($post);die;
            if (isset($post['ft'])) {
                switch ($post['ft']) {
                    case "p1":
                        $this->updateProfile($post);
                        break;
                    case "p3":
                        $this->updateAccount($post);
                        break;
                }
            }
            if (isset($post['s'])) {
                switch ($post['s']) {
                    case "4":
                        // $this->gpack($post);
                        break;
                }
            }
            if (isset($post['f']) AND isset($post['t'])) {
                $this->options();
            }
        }

        private function updateProfile($post)
        {
            global $database, $session;
            $birthday = $post['jahr'] . '-' . $post['monat'] . '-' . $post['tag'];
            $database->submitProfile($database->RemoveXSS($session->uid), $database->RemoveXSS($post['mw']), $database->RemoveXSS($post['ort']), $database->RemoveXSS($birthday), $database->RemoveXSS($post['be2']), $database->RemoveXSS($post['be1']));
            $varray = $database->getProfileVillages($session->uid);
            for ($i = 0; $i <= count($varray) - 1; $i++) {
                $post['dname' . $i] = str_replace('[=]', '', $post['dname' . $i]);
                $post['dname' . $i] = str_replace('[|]', '', $post['dname' . $i]);
                $post['dname' . $i] = join('&#65533;', array_map('trim', explode('&#65533;', $post['dname' . $i])));
                $search = array(chr(0xC2) . chr(0xA0), // c2a0; Alt+255; Alt+0160; Alt+511; Alt+99999999;
                    chr(0xC2) . chr(0x90), // c290; Alt+0144
                    chr(0xC2) . chr(0x9D), // cd9d; Alt+0157
                    chr(0xC2) . chr(0x81), // c281; Alt+0129
                    chr(0xC2) . chr(0x8D), // c28d; Alt+0141
                    chr(0xC2) . chr(0x8F), // c28f; Alt+0143
                    chr(0xC2) . chr(0xAD), // cdad; Alt+0173
                    chr(0xAD)); // Soft-Hyphen; AD
                $post['dname' . $i] = str_replace($search, '', $post['dname' . $i]);
                if ($post['dname' . $i] != null && $post['dname' . $i] != '' && $post['dname' . $i] != '' && $post['dname' . $i] != '&#65533;') {
                    $database->setVillageName($varray[$i]['wref'], $post['dname' . $i]);
                } else {
                    $name = $_SESSION['username'] . '\' Village';
                    $database->setVillageName($varray[$i]['wref'], $name);
                }
            }
            header("Location: ?uid=" . $session->uid);
            exit;
        }

        private function updateAccount($post)
        {
            global $database, $session, $form;
            // print_r($post);die;
            if ($post['pw2'] != '' && $post['pw3'] != '' && $post['pw1'] != '') {
                if ($post['pw2'] == $post['pw3']) {
                    if ($database->login($session->username, $post['pw1'])) {
                        $database->updateUserField($session->uid, "password", $this->generateHash($post['pw2']), 1);
                        mysql_query("UPDATE " . TB_PREFIX . "users set sessid = '' WHERE id = " . $session->uid);
                    } else {
                        $form->addError("pw", US_LOGINPWERROR);
                    }
                } else {
                    $form->addError("pw", US_PASSMISMATCH);
                }
            }
            if ($post['email_alt'] != '') {
                if ($post['email_alt'] == $session->userinfo['email']) {
                    $database->updateUserField($session->uid, "email", $post['email_neu'], 1);
                } else {
                    $form->addError("email", US_EMAILERROR);
                }
            }
            if ($post['del'] != '' && $post['del_pw'] != '') {
                if ($post['del'] && $this->generateHash($post['del_pw']) == $session->userinfo['password']) {
                    if ($database->isAllianceOwner($session->uid)) {
                        $form->addError("del", US_ALLIOWNER);
                    } else {
                        $database->setDeleting($session->uid, 0);
                    }
                } else {
                    $form->addError("del", US_PASSMISMATCH);
                }
            }
            if ($post['v1'] != '') {
                $sitid = $database->getUserField($post['v1'], 'id', 1);

                $qu = mysql_query("SELECT COUNT(`id`) FROM ".TB_PREFIX."users WHERE sit1 = ".$sitid." OR sit2 = ".$sitid." LIMIT 2");
                $qu = mysql_fetch_assoc($qu);

                //$sitterz = $database->whoissitter($sitid);

                if($qu['COUNT(`id`)'] >= 2){
                    $form->addError('sit', US_SITERROR2);
                }
                elseif ($sitid == $session->userinfo['sit1'] || $sitid == $session->userinfo['sit2']) {
                    $form->addError('sit', US_SITERROR);
                } else {
                    //if ($session->userinfo['sit1'] == 0) {
                    $database->SetSitter($post['uid'], 'sit1', $sitid, 1);
                    //$database->SetSitter($sitid, 'sit_me1', $post['uid'], 1);
                    $database->sitsetting(1, 1, 0, $session->uid);
                    $database->sitsetting(1, 2, 0, $session->uid);
                    $database->sitsetting(1, 3, 0, $session->uid);
                    $database->sitsetting(1, 4, 0, $session->uid);
                    $database->sitsetting(1, 5, 0, $session->uid);
                    $database->sitsetting(1, 6, 0, $session->uid);
                    if ($_POST['sitter1_flag0'] == 1) {
                        $database->sitsetting(1, 1, 1, $session->uid);
                    }
                    if ($_POST['sitter1_flag1'] == 1) {
                        $database->sitsetting(1, 2, 1, $session->uid);
                    }
                    if ($_POST['sitter1_flag2'] == 1) {
                        $database->sitsetting(1, 3, 1, $session->uid);
                    }
                    if ($_POST['sitter1_flag3'] == 1) {
                        $database->sitsetting(1, 4, 1, $session->uid);
                    }
                    if ($_POST['sitter1_flag4'] == 1) {
                        $database->sitsetting(1, 5, 1, $session->uid);
                    }
                    if ($_POST['sitter1_flag5'] == 1) {
                        $database->sitsetting(1, 6, 1, $session->uid);
                    }
                    //}
                }

            } else if ($post['v2'] != '') {
                $sitid = $database->getUserField($post['v2'], 'id', 1);
                //$sitterz = $database->whoissitter($sitid);
                if ($sitid == $session->userinfo['sit1'] || $sitid == $session->userinfo['sit2']) {
                    $form->addError('sit', US_SITERROR);
                } else {
                    //if ($session->userinfo['sit2'] == 0) {
                    $database->SetSitter($post['uid'], 'sit2', $sitid, 1);
                    // $database->SetSitter($sitid, 'sit_me2', $post['uid'], 1);
                    $database->sitsetting(2, 1, 0, $session->uid);
                    $database->sitsetting(2, 2, 0, $session->uid);
                    $database->sitsetting(2, 3, 0, $session->uid);
                    $database->sitsetting(2, 4, 0, $session->uid);
                    $database->sitsetting(2, 5, 0, $session->uid);
                    $database->sitsetting(2, 6, 0, $session->uid);

                    if ($_POST['sitter2_flag0'] == 1) {
                        $database->sitsetting(2, 1, 1, $session->uid);
                    }
                    if ($_POST['sitter2_flag1'] == 1) {
                        $database->sitsetting(2, 2, 1, $session->uid);
                    }
                    if ($_POST['sitter2_flag2'] == 1) {
                        $database->sitsetting(2, 3, 1, $session->uid);
                    }
                    if ($_POST['sitter2_flag3'] == 1) {
                        $database->sitsetting(2, 4, 1, $session->uid);
                    }
                    if ($_POST['sitter2_flag4'] == 1) {
                        $database->sitsetting(2, 5, 1, $session->uid);
                    }
                    if ($_POST['sitter2_flag5'] == 1) {
                        $database->sitsetting(2, 6, 1, $session->uid);
                    }
                    //}
                }
            } else {

                $database->sitsetting(1, 1, 0, $session->uid);
                $database->sitsetting(1, 2, 0, $session->uid);
                $database->sitsetting(1, 3, 0, $session->uid);
                $database->sitsetting(1, 4, 0, $session->uid);
                $database->sitsetting(1, 5, 0, $session->uid);
                $database->sitsetting(1, 6, 0, $session->uid);

                if ($_POST['sitter1_flag0'] == 1) {
                    $database->sitsetting(1, 1, 1, $session->uid);
                }
                if ($_POST['sitter1_flag1'] == 1) {
                    $database->sitsetting(1, 2, 1, $session->uid);
                }
                if ($_POST['sitter1_flag2'] == 1) {
                    $database->sitsetting(1, 3, 1, $session->uid);
                }
                if ($_POST['sitter1_flag3'] == 1) {
                    $database->sitsetting(1, 4, 1, $session->uid);
                }
                if ($_POST['sitter1_flag4'] == 1) {
                    $database->sitsetting(1, 5, 1, $session->uid);
                }
                if ($_POST['sitter1_flag5'] == 1) {
                    $database->sitsetting(1, 6, 1, $session->uid);
                }

                $database->sitsetting(2, 1, 0, $session->uid);
                $database->sitsetting(2, 2, 0, $session->uid);
                $database->sitsetting(2, 3, 0, $session->uid);
                $database->sitsetting(2, 4, 0, $session->uid);
                $database->sitsetting(2, 5, 0, $session->uid);
                $database->sitsetting(2, 6, 0, $session->uid);

                if ($_POST['sitter2_flag0'] == 1) {
                    $database->sitsetting(2, 1, 1, $session->uid);
                }
                if ($_POST['sitter2_flag1'] == 1) {
                    $database->sitsetting(2, 2, 1, $session->uid);
                }
                if ($_POST['sitter2_flag2'] == 1) {
                    $database->sitsetting(2, 3, 1, $session->uid);
                }
                if ($_POST['sitter2_flag3'] == 1) {
                    $database->sitsetting(2, 4, 1, $session->uid);
                }
                if ($_POST['sitter2_flag4'] == 1) {
                    $database->sitsetting(2, 5, 1, $session->uid);
                }
                if ($_POST['sitter2_flag5'] == 1) {
                    $database->sitsetting(2, 6, 1, $session->uid);
                }
            }
            $_SESSION['valuearray'] = $post;
            $_SESSION['errorarray'] = $form->getErrors();
            header('Location: options.php?s=' . $_POST['get']);
            exit;
        }

        function generateHash($plainText, $salt = 1)
        {
            $salt = substr($salt, 0, 9);

            return $salt . md5($salt . $plainText);
        }

        private function options()
        {
            global $session;
            if (isset ($_POST['t']) && $_POST['t'] == 1 && isset ($_POST['f']) && $_POST['f'] == 1) {
                $_POST['timezone'] = (int)$_POST['timezone'];
                $_POST['timezone'] = filter_var($_POST['timezone'], FILTER_SANITIZE_MAGIC_QUOTES);
                $_POST['timezone'] = filter_var($_POST['timezone'], FILTER_SANITIZE_NUMBER_INT);
                $_POST['timezone'] = filter_var($_POST['timezone'], FILTER_SANITIZE_SPECIAL_CHARS);
                $result = preg_replace('[^0-9]', '', $_POST['timezone']);
                mysql_query("UPDATE " . TB_PREFIX . "users SET timezone = '" . $result . "' WHERE id = $session->uid") or die(mysql_error());
            }
            if (isset($_POST['v4'])) {
                mysql_query("UPDATE " . TB_PREFIX . "users_setting SET nopicn = 1 WHERE id = $session->uid") or die(mysql_error());
            } else {
                mysql_query("UPDATE " . TB_PREFIX . "users_setting SET nopicn = 0 WHERE id = $session->uid") or die(mysql_error());
            }

        }

        public function procSpecial($get)
        {
            global $database, $session;
            if (isset($get['e'])) {
                switch ($get['e']) {
                    case 2:
                        $this->removeMeSit($get);
                        break;
                    case 3:
                        $this->removeSitter($get);
                        break;
                    case 4:
                        $timestamp = $database->isDeleting($session->uid);
                        $delduration = max(round(259200 / sqrt(SPEED)), 3600);
                        $cancelduration = $delduration * 2 / 3;
                        if ($timestamp > time() + $cancelduration) $this->cancelDeleting($get);
                        break;
                }
            }
        }

        private function removeMeSit($get)
        {
            global $database, $session;
            if ($get['a'] == $session->checker) {
                $database->removeMeSit($get['owner'], $session->uid);
                $session->changeChecker();
            }
            header("Location: spieler.php?s=" . $get['s']);
            exit;
        }

        private function removeSitter($get)
        {

            global $database, $session;

            if ($get['a'] == $session->checker && isset($get['owner'])) {
                $getsit = "getSitee".$get['type'];
                $getsit1 = $database->$getsit($session->uid);
                $database->updateUserField($getsit1['id'], "sit" . $get['type'], 0, 1);
                $session->changeChecker();
            }
            elseif ($get['a'] == $session->checker) {
                if ($session->userinfo['sit' . $get['type']] == $get['id']) {
                    $database->updateUserField($session->uid, "sit" . $get['type'], 0, 1);
                }
                $session->changeChecker();
            }
            header("Location: options.php?s=" . $get['s']);
            exit;
        }

        private function cancelDeleting($get)
        {
            global $database, $session;
            $database->setDeleting($session->uid, 1);
            header("Location: spieler.php?s=" . $get['s']);
            exit;
        }

    }

    $profile = new Profile;
?>
