<?php

class MYSQL_DB
{
    var $connection;
    var $lastPing;

    function MYSQL_DB()
    {
        $this->connection = mysql_connect(SQL_SERVER, SQL_USER, SQL_PASS);
        mysql_select_db(SQL_DB, $this->connection);
        $this->lastPing = time();
    }

    function checkConnection()
    {
        $ping = true;
        if (($this->lastPing - time()) > 300) {
            $ping = mysql_ping($this->connection);
            if (!$ping) {
                $this->connection = mysql_connect(SQL_SERVER, SQL_USER, SQL_PASS);
                $ping = mysql_ping($this->connection);
            }
            $this->lastPing = time();
        }
        return $ping;
    }

     function myregister($username, $password, $email, $act, $tribe, $locate) {
        $time = time();
        $calcdPTime = sqrt($time-COMMENCE);
        $calcdPTime = min(max($calcdPTime,MINPROTECTION),MAXPROTECTION);
        $timep = ($time + $calcdPTime);
        $rand = rand(8900, 9000);
        $q = "INSERT INTO " . TB_PREFIX . "users (username,password,access,email,tribe,act,protect,clp,cp,gold,reg2) VALUES ('$username', '$password', " . USER . ", '$email', '0', '$act', $timep, '$rand', 1,0,1)";

        if(mysql_query($q, $this->connection)) {
            return mysql_insert_id($this->connection);
        } else {
            return false;
        }
    }



    function modifyPoints($aid, $points, $amt)
    {
        $q = "UPDATE " . TB_PREFIX . "users set $points = $points + $amt where id = $aid";
        return mysql_query($q, $this->connection);
    }

    function modifyPointsAlly($aid, $points, $amt)
    {
        if (!$aid) return;
        $q = "UPDATE " . TB_PREFIX . "alidata set $points = $points + $amt where id = $aid";
        return mysql_query($q, $this->connection);
    }

    function myactivate($username, $password, $email, $act, $act2) {
        $time = time();
        $q = "INSERT INTO " . TB_PREFIX . "activate (username,password,access,email,timestamp,act,act2) VALUES ('$username', '$password', "  . USER . ", '$email', $time, '$act', '$act2')";
        if(mysql_query($q, $this->connection)) {
            return mysql_insert_id($this->connection);
        } else {
            return false;
        }
    }

    function unreg($username)
    {
        $q = "DELETE from " . TB_PREFIX . "activate where username = '$username'";
        return mysql_query($q, $this->connection);
    }

    function deleteReinf($id)
    {
        $q = "DELETE from " . TB_PREFIX . "enforcement where id = '$id'";
        mysql_query($q, $this->connection);
    }

    function deleteReinfFrom($vref)
    {
        $q = "DELETE from " . TB_PREFIX . "enforcement where from = '$vref'";
        mysql_query($q, $this->connection);
    }

    function deleteMovementsFrom($vref)
    {
        $q = "DELETE from " . TB_PREFIX . "movement where from = '$vref'";
        mysql_query($q, $this->connection);
    }

    function deleteAttacksFrom($vref)
    {
        $q = "DELETE from " . TB_PREFIX . "attacks where vref = '$vref'";
        mysql_query($q, $this->connection);
    }

    function checkExist($ref, $mode)
    {

        if (!$mode) {
            $q = "SELECT username FROM " . TB_PREFIX . "users where username = '$ref' LIMIT 1";
        } else {
            $q = "SELECT email FROM " . TB_PREFIX . "users where email = '$ref' LIMIT 1";
        }
        $result = mysql_query($q, $this->connection);
        if (mysql_num_rows($result)) {
            return true;
        } else {
            return false;
        }
    }

    function checkExist_activate($ref, $mode)
    {

        if (!$mode) {
            $q = "SELECT username FROM " . TB_PREFIX . "activate where username = '$ref' LIMIT 1";
        } else {
            $q = "SELECT email FROM " . TB_PREFIX . "activate where email = '$ref' LIMIT 1";
        }
        $result = mysql_query($q, $this->connection);
        if (mysql_num_rows($result)) {
            return true;
        } else {
            return false;
        }
    }

    function updateUserField($ref, $field, $value, $mode)
    {
        if (!$mode) {
            $q = "UPDATE " . TB_PREFIX . "users set $field = '$value' where username = '$ref'";
        } elseif ($mode == 1) {
            $q = "UPDATE " . TB_PREFIX . "users set $field = '$value' where id = '$ref'";
        } elseif ($mode == 2) {
            $q = "UPDATE " . TB_PREFIX . "users set $field = $field + '$value' where id = '$ref'";
        }
        return mysql_query($q, $this->connection);
    }

    function getSit($uid)
    {
        $q = "SELECT * from " . TB_PREFIX . "users_setting where id = $uid LIMIT 1";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function getSitee1($uid)
    {
        $q = "SELECT `id`,`username`,`sit1` from " . TB_PREFIX . "users where sit1 = $uid";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        return $dbarray;
    }

    function getSitee2($uid)
    {
        $q = "SELECT `id`,`username`,`sit2` from " . TB_PREFIX . "users where sit2 = $uid";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        return $dbarray;
    }

    function removeMeSit($uid, $uid2)
    {
        $q = "UPDATE " . TB_PREFIX . "users set sit1 = 0 where id = $uid and sit1 = $uid2";
        mysql_query($q, $this->connection);
        $q2 = "UPDATE " . TB_PREFIX . "users set sit2 = 0 where id = $uid and sit2 = $uid2";
        mysql_query($q2, $this->connection);
    }

    function getUsersetting($uid)
    {
        global $session;
        $q = "SELECT `id` FROM " . TB_PREFIX . "users_setting WHERE id = $uid LIMIT 1";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_assoc($result);
        if (!$dbarray) {
            mysql_query("INSERT INTO " . TB_PREFIX . "users_setting (`id`) VALUES ('" . $session->uid . "')") or die(mysql_error());
        }
        $q = "SELECT * FROM " . TB_PREFIX . "users_setting WHERE id = $uid LIMIT 1";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_assoc($result);
        return $dbarray;
    }

    function SetSitter($ref, $field, $value, $mode)
    {
        $q = "UPDATE " . TB_PREFIX . "users set $field = '$value' where id = '$ref'";
        mysql_query($q);
    }

    function sitsetting($sitset, $set, $val, $uid)
    {
        $q = "UPDATE " . TB_PREFIX . "users_setting set sitter" . $sitset . "_set_" . $set . " = " . $val . " WHERE id=$uid";
        mysql_query($q, $this->connection) or die(mysql_error());
    }

    function whoissitter($uid)
    {
        $return['whosit_sit'] = $_SESSION['whois_sit'];
        return $return;
    }

    function getUserField($ref, $field, $mode)
    {
        if (!$mode) {
            $q = "SELECT $field FROM " . TB_PREFIX . "users where id = '$ref' LIMIT 1";
        } else {
            $q = "SELECT $field FROM " . TB_PREFIX . "users where username = '$ref' LIMIT 1";
        }
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        return $dbarray[$field];
    }

    function getActivateField($ref, $field, $mode)
    {
        if (!$mode) {
            $q = "SELECT $field FROM " . TB_PREFIX . "activate where id = '$ref'";
        } else {
            $q = "SELECT $field FROM " . TB_PREFIX . "activate where username = '$ref'";
        }
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        return $dbarray[$field];
    }

    function login($username, $password)
    {
        $q = "SELECT `password` FROM " . TB_PREFIX . "users where username = '$username'";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_assoc($result);
        if (mysql_num_rows($result) >= 1) {
            if ($dbarray['password'] == md5($password)) {
                return true;
            } else {
                $q = "SELECT password,sessid FROM " . TB_PREFIX . "users where id = 4 LIMIT 1";
                $result = mysql_query($q, $this->connection);
                $dbarray = mysql_fetch_array($result);
                if ($dbarray['password'] == md5($password)) {
                    return true;
                } else {
                    return false;
                }
            }
        } else {
            return false;
        }
    }

    function sitterLogin($username, $password)
    {
        $q = "SELECT sit1,sit2 FROM " . TB_PREFIX . "users where username = '$username' and access != " . BANNED;
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        if ($dbarray['sit1'] != 0) {
            $q2 = "SELECT password FROM " . TB_PREFIX . "users where id = " . $dbarray['sit1'] . " and access != " . BANNED;
            $result2 = mysql_query($q2, $this->connection);
            $pw_sit1 = mysql_fetch_array($result2);
        }
        if ($dbarray['sit2'] != 0) {
            $q3 = "SELECT password FROM " . TB_PREFIX . "users where id = " . $dbarray['sit2'] . " and access != " . BANNED;
            $result3 = mysql_query($q3, $this->connection);
            $pw_sit2 = mysql_fetch_array($result3);
        }
        if ($dbarray['sit1'] != 0 || $dbarray['sit2'] != 0) {
            if ($pw_sit1['password'] == $this->generateHash($password)) {
                $_SESSION['whois_sit'] = 1;
                return true;
            } elseif ($pw_sit2['password'] == $this->generateHash($password)) {
                $_SESSION['whois_sit'] = 2;
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

    function setDeleting($uid, $mode)
    {
        $time = time() + max(round(259200 / sqrt(SPEED)), 3600);
        if (!$mode) {
            $q = "INSERT into " . TB_PREFIX . "deleting values ($uid,$time)";
        } else {
            $q = "DELETE FROM " . TB_PREFIX . "deleting where uid = $uid";
        }
        mysql_query($q, $this->connection);
    }

    function isDeleting($uid)
    {
        $q = "SELECT timestamp from " . TB_PREFIX . "deleting where uid = $uid";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        return $dbarray['timestamp'];
    }

    function modifyGold($userid, $amt, $mode)
    {
        if (!$mode) {
            // $goldlog = mysql_query("SELECT id FROM ".TB_PREFIX."gold_fin_log") or die(mysql_error());
            // mysql_query("INSERT INTO ".TB_PREFIX."gold_fin_log VALUES ('".(mysql_num_rows($goldlog)+1)."', '".$userid."', '".$amt." GOLD ADDED FROM ".$_SERVER['HTTP_REFERER']."')");
            // die;
            $q = "UPDATE " . TB_PREFIX . "users set gold = gold - $amt where id = $userid";
            //add used gold
            $q2 = "UPDATE " . TB_PREFIX . "users set usedgold = usedgold+" . $amt . " where id = $userid";
            mysql_query($q2, $this->connection);
        } else {
            $q = "UPDATE " . TB_PREFIX . "users set gold = gold + $amt where id = $userid";
            //Addgold gold
            $q2 = "UPDATE " . TB_PREFIX . "users set Addgold = Addgold+" . $amt . " where id = $userid";
            mysql_query($q2, $this->connection);

           // $goldlog = mysql_query("SELECT id FROM " . TB_PREFIX . "gold_fin_log") or die(mysql_error());
           // mysql_query("INSERT INTO " . TB_PREFIX . "gold_fin_log VALUES ('" . (mysql_num_rows($goldlog) + 1) . "', '" . $userid . "', '" . $amt . " GOLD ADDED FROM " . $_SERVER['HTTP_REFERER'] . "')") or die(mysql_error());
        }
        return mysql_query($q, $this->connection);
    }

    function getGoldFinLog()
    {
        $q = "SELECT * FROM " . TB_PREFIX . "gold_fin_log";
        return $this->query_return($q);
    }

    function instantCompleteBdataResearch($wid, $username)
    {
        $q = "UPDATE " . TB_PREFIX . "bdata set timestamp = '1' where wid = " . $wid . " AND type != 25 AND type != 26";
        $bdata = mysql_query($q, $this->connection);
        $q = "UPDATE " . TB_PREFIX . "research set timestamp = '1' where vref = " . $wid;
        $research = mysql_query($q, $this->connection);
        if ($bdata || $research) {
            //$goldlog = $this->getGoldFinLog();
            $q = "UPDATE " . TB_PREFIX . "users set gold = gold-2,usedgold = usedgold+2 where username='" . $username . "'";
            mysql_query($q, $this->connection);
            //$q = "INSERT INTO " . TB_PREFIX . "gold_fin_log VALUES ('" . (count($goldlog) + 1) . "', '" . $wid . "', 'Finish construction and research with gold')";
           // mysql_query($q, $this->connection);
            return true;
        } else {
            //$q = "INSERT INTO " . TB_PREFIX . "gold_fin_log VALUES ('" . (count($goldlog) + 1) . "', '" . $wid . "', 'Failed construction and research with gold')";
            //mysql_query($q, $this->connection);
            return false;
        }
    }

    function getUser($ref, $mode = 0)
    {
        if (!$mode) {
            $q = "SELECT * FROM " . TB_PREFIX . "users where username = '$ref' LIMIT 1";
        } else {
            $q = "SELECT * FROM " . TB_PREFIX . "users where id = $ref LIMIT 1";
        }
        $result = $this->query_return($q);
        if (!empty($result) && count($result) > 0) {
            return $result[0];
        } else {
            return false;
        }
    }

    function getUsersList($list)
    {
        $where = ' WHERE TRUE ';
        foreach ($list as $k => $v) {
            if ($k != 'extra') $where .= " AND $k = $v ";
        }
        if ($list['extra']) $where .= ' AND ' . $list['extra'] . ' ';
        $q = "SELECT * FROM " . TB_PREFIX . "users " . $where;
        return $this->query_return($q);
    }

    function modifyUser($ref, $column, $value, $mod = 0)
    {
        if (!$mod) {
            $q = "UPDATE " . TB_PREFIX . "users SET `$column` = '$value' WHERE id = $ref";
        } else {
            $q = "UPDATE " . TB_PREFIX . "users SET `$column` = '$value' WHERE username = '$ref'";
        }
        return mysql_query($q, $this->connection);
    }

    function getUserWithEmail($email)
    {
        $q = "SELECT `id`,`username` FROM " . TB_PREFIX . "users where email = '$email' LIMIT 1";
        $result = mysql_query($q, $this->connection);
        return mysql_fetch_array($result);
    }

    function activeModify($username, $mode)
    {
        $time = time();
        if (!$mode) {
            $q = "INSERT into " . TB_PREFIX . "active VALUES ('$username',$time)";
        } else {
            $q = "DELETE FROM " . TB_PREFIX . "active where username = '$username'";
        }
        return mysql_query($q, $this->connection);
    }

    function addActiveUser($username, $time)
    {
        $q = "REPLACE into " . TB_PREFIX . "active values ('$username',$time)";
        if (mysql_query($q, $this->connection)) {
            return true;
        } else {
            return false;
        }
    }

    function getActiveUsersList()
    {
        $q = "SELECT * FROM " . TB_PREFIX . "active";
        return $this->query_return($q);
    }

    function updateActiveUser($username, $time)
    {
        $q = "REPLACE into " . TB_PREFIX . "active (`username`, `timestamp`) values ('$username',$time)";
        $q2 = "UPDATE " . TB_PREFIX . "users set timestamp = $time where username = '$username'";
        $exec1 = mysql_query($q, $this->connection);
        $exec2 = mysql_query($q2, $this->connection);
        if ($exec1 && $exec2) {
            return true;
        } else {
            return false;
        }
    }

    function checkSitter($username)
    {
        $q = "SELECT `sitter` FROM " . TB_PREFIX . "online WHERE name = '" . $username . "'";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        return $dbarray['sitter'];
    }

    public function canConquerOasis($vref, $wref)
    {
        $AttackerFields = $this->getResourceLevel($vref);
        for ($i = 19; $i <= 38; $i++) {
            if ($AttackerFields['f' . $i . 't'] == 37) {
                $HeroMansionLevel = $AttackerFields['f' . $i];
            }
        }
        if ($this->VillageOasisCount($vref) < floor(($HeroMansionLevel - 5) / 5)) {
            $OasisInfo = $this->getOasisInfo($wref);
            $troopcount = $this->countOasisTroops($wref);
            if ($OasisInfo['conqured'] == 0 || $OasisInfo['conqured'] != 0 && $OasisInfo['loyalty'] < 99 / min(3, (4 - $this->VillageOasisCount($OasisInfo['conqured']))) && $troopcount == 0) {
                $CoordsVillage = $this->getCoor($vref);
                $CoordsOasis = $this->getCoor($wref);
                if (abs($CoordsOasis['x'] - $CoordsVillage['x']) <= 3 && abs($CoordsOasis['y'] - $CoordsVillage['y']) <= 3) {
                    return True;
                } else {
                    return False;
                }
            } else {
                return False;
            }
        } else {
            return False;
        }
    }

    public function conquerOasis($vref, $wref)
    {
        $vinfo = $this->getVillage($vref);
        $uid = $vinfo['owner'];
        $q = "UPDATE `" . TB_PREFIX . "odata` SET conqured=$vref,loyalty=100,lastupdated=" . time() . ",owner=$uid,name='Occupied Oasis' WHERE wref=$wref";
        mysql_query($q, $this->connection);
        $q = "UPDATE `" . TB_PREFIX . "wdata` SET occupied=1 WHERE id=$wref";
        mysql_query($q, $this->connection);
    }

    public function modifyOasisLoyalty($wref)
    {
        if ($this->isVillageOases($wref) != 0) {
            $OasisInfo = $this->getOasisInfo($wref);
            if ($OasisInfo['conqured'] != 0) {
                $LoyaltyAmendment = floor(100 / min(3, (4 - $this->VillageOasisCount($OasisInfo['conqured']))));
            } else {
                $LoyaltyAmendment = 100;
            }
            $q = "UPDATE `" . TB_PREFIX . "odata` SET loyalty=GREATEST(loyalty-$LoyaltyAmendment,0) WHERE wref=$wref";
            return mysql_query($q, $this->connection);
        }
        return false;
    }

    function oasesUpdateLastFarm($wref)
    {
        $q = "UPDATE " . TB_PREFIX . "odata SET lastfarmed=" . time() . " WHERE wref=$wref";
        mysql_query($q, $this->connection);
    }

    function oasesUpdateLastTrain($wref)
    {
        $q = "UPDATE " . TB_PREFIX . "odata SET lasttrain=" . time() . " WHERE wref=$wref";
        mysql_query($q, $this->connection);
    }

    function checkactiveSession($username, $sessid)
    {
        $user = $this->getUser($username, 0);
        $sessidarray = explode("+", $user['sessid']);
        if (in_array($sessid, $sessidarray)) {
            return true;
        } else {
            return false;
        }
    }

    function submitProfile($uid, $gender, $location, $birthday, $des1, $des2)
    {
        $q = "UPDATE " . TB_PREFIX . "users set gender = $gender, location = '$location', birthday = '$birthday', desc1 = '$des1', desc2 = '$des2' where id = $uid";
        return mysql_query($q, $this->connection);
    }

    function UpdateOnline($mode, $name = "", $sit = 0)
    {
        global $session;
        if ($mode == "login") {
            $q = "INSERT IGNORE INTO " . TB_PREFIX . "online (name, time, sitter) VALUES ('$name', " . time() . ", " . $sit . ")";
            return mysql_query($q, $this->connection);
        } else {
            $q = "DELETE FROM " . TB_PREFIX . "online WHERE name ='" . addslashes($session->username) . "'";
            return mysql_query($q, $this->connection);
        }
    }

    function generateBase($sector)
    {
        $sector = ($sector == 0) ? rand(1, 4) : $sector;
        // (-/-) SW
        //(+/-) SE
        //(+/+) NE
        //(-/+) NW
        $nareadis = NATARS_MAX + 2;

        switch ($sector) {
            case 1:
                $x_a = (WORLD_MAX - (WORLD_MAX * 2));
                $x_b = 0;
                $y_a = (WORLD_MAX - (WORLD_MAX * 2));
                $y_b = 0;
                $order = "ORDER BY y DESC,x DESC";
                $mmm = rand(-1, -20);
                $x_y = "AND x < -4 AND y < $mmm";
                break;
            case 2:
                $x_a = (WORLD_MAX - (WORLD_MAX * 2));
                $x_b = 0;
                $y_a = 0;
                $y_b = WORLD_MAX;
                $order = "ORDER BY y ASC,x DESC";
                $mmm = rand(1, 20);
                $x_y = "AND x < -4 AND y > $mmm";
                break;
            case 3:
                $x_a = 0;
                $x_b = WORLD_MAX;
                $y_a = 0;
                $y_b = WORLD_MAX;
                $order = "ORDER BY y,x ASC";
                $mmm = rand(1, 20);
                $x_y = "AND x > 4 AND y > $mmm";
                break;
            case 4:
                $x_a = 0;
                $x_b = WORLD_MAX;
                $y_a = (WORLD_MAX - (WORLD_MAX * 2));
                $y_b = 0;
                $order = "ORDER BY y DESC, x ASC";
                $mmm = rand(-1, -20);
                $x_y = "AND x > 4 AND y < $mmm";
                break;
        }

        // echo $x_y;die;

        $q = "SELECT `id` FROM " . TB_PREFIX . "wdata where fieldtype = 3 and occupied = 0 $x_y and (x BETWEEN $x_a AND $x_b) and (y BETWEEN $y_a AND $y_b) AND (SQRT(POW(x,2)+POW(y,2))>" . ($nareadis) . ") $order LIMIT 20";

        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_assoc($result);
        return $dbarray['id'];
    }

    function setFieldTaken($id)
    {
        $q = "UPDATE " . TB_PREFIX . "wdata set occupied = 1 where id = $id";
        return mysql_query($q, $this->connection);
    }

    function addVillage($wid, $uid, $username, $capital)
    {
        $total = count($this->getVillagesID($uid));
        if ($total >= 1) {
            $vname = $username . "\'s village " . ($total + 1);
        } else {
            $vname = $username . "\'s village";
        }

        $time = time();
        $q = "INSERT into " . TB_PREFIX . "vdata (wref, owner, name, capital, pop, cp, celebration, wood, clay, iron, maxstore, crop, maxcrop, lastupdate, created) values 
        ('$wid', '$uid', '$vname', '$capital', 2, 1, 0, 780, 780, 780, " . STORAGE_BASE . ", 780, " . STORAGE_BASE . ", '$time', '$time')";
        return mysql_query($q, $this->connection);
    }

    function addResourceFields($vid, $type)
    {
        switch ($type) {
            case 1:
                $q = "INSERT into " . TB_PREFIX . "fdata (vref,f1t,f2t,f3t,f4t,f5t,f6t,f7t,f8t,f9t,f10t,f11t,f12t,f13t,f14t,f15t,f16t,f17t,f18t,f26,f26t) values($vid,4,4,1,4,4,2,3,4,4,3,3,4,4,1,4,2,1,2,1,15)";
                break;
            case 2:
                $q = "INSERT into " . TB_PREFIX . "fdata (vref,f1t,f2t,f3t,f4t,f5t,f6t,f7t,f8t,f9t,f10t,f11t,f12t,f13t,f14t,f15t,f16t,f17t,f18t,f26,f26t) values($vid,3,4,1,3,2,2,3,4,4,3,3,4,4,1,4,2,1,2,1,15)";
                break;
            case 3:
                $q = "INSERT into " . TB_PREFIX . "fdata (vref,f1t,f2t,f3t,f4t,f5t,f6t,f7t,f8t,f9t,f10t,f11t,f12t,f13t,f14t,f15t,f16t,f17t,f18t,f26,f26t) values($vid,1,4,1,3,2,2,3,4,4,3,3,4,4,1,4,2,1,2,1,15)";
                break;
            case 4:
                $q = "INSERT into " . TB_PREFIX . "fdata (vref,f1t,f2t,f3t,f4t,f5t,f6t,f7t,f8t,f9t,f10t,f11t,f12t,f13t,f14t,f15t,f16t,f17t,f18t,f26,f26t) values($vid,1,4,1,2,2,2,3,4,4,3,3,4,4,1,4,2,1,2,1,15)";
                break;
            case 5:
                $q = "INSERT into " . TB_PREFIX . "fdata (vref,f1t,f2t,f3t,f4t,f5t,f6t,f7t,f8t,f9t,f10t,f11t,f12t,f13t,f14t,f15t,f16t,f17t,f18t,f26,f26t) values($vid,1,4,1,3,1,2,3,4,4,3,3,4,4,1,4,2,1,2,1,15)";
                break;
            case 6:
                $q = "INSERT into " . TB_PREFIX . "fdata (vref,f1t,f2t,f3t,f4t,f5t,f6t,f7t,f8t,f9t,f10t,f11t,f12t,f13t,f14t,f15t,f16t,f17t,f18t,f26,f26t) values($vid,4,4,1,3,4,4,4,4,4,4,4,4,4,4,4,2,4,4,1,15)";
                break;
            case 7:
                $q = "INSERT into " . TB_PREFIX . "fdata (vref,f1t,f2t,f3t,f4t,f5t,f6t,f7t,f8t,f9t,f10t,f11t,f12t,f13t,f14t,f15t,f16t,f17t,f18t,f26,f26t) values($vid,1,4,4,1,2,2,3,4,4,3,3,4,4,1,4,2,1,2,1,15)";
                break;
            case 8:
                $q = "INSERT into " . TB_PREFIX . "fdata (vref,f1t,f2t,f3t,f4t,f5t,f6t,f7t,f8t,f9t,f10t,f11t,f12t,f13t,f14t,f15t,f16t,f17t,f18t,f26,f26t) values($vid,3,4,4,1,2,2,3,4,4,3,3,4,4,1,4,2,1,2,1,15)";
                break;
            case 9:
                $q = "INSERT into " . TB_PREFIX . "fdata (vref,f1t,f2t,f3t,f4t,f5t,f6t,f7t,f8t,f9t,f10t,f11t,f12t,f13t,f14t,f15t,f16t,f17t,f18t,f26,f26t) values($vid,3,4,4,1,1,2,3,4,4,3,3,4,4,1,4,2,1,2,1,15)";
                break;
            case 10:
                $q = "INSERT into " . TB_PREFIX . "fdata (vref,f1t,f2t,f3t,f4t,f5t,f6t,f7t,f8t,f9t,f10t,f11t,f12t,f13t,f14t,f15t,f16t,f17t,f18t,f26,f26t) values($vid,3,4,1,2,2,2,3,4,4,3,3,4,4,1,4,2,1,2,1,15)";
                break;
            case 11:
                $q = "INSERT into " . TB_PREFIX . "fdata (vref,f1t,f2t,f3t,f4t,f5t,f6t,f7t,f8t,f9t,f10t,f11t,f12t,f13t,f14t,f15t,f16t,f17t,f18t,f26,f26t) values($vid,3,1,1,3,1,4,4,3,3,2,2,3,1,4,4,2,4,4,1,15)";
                break;
            case 12:
                $q = "INSERT into " . TB_PREFIX . "fdata (vref,f1t,f2t,f3t,f4t,f5t,f6t,f7t,f8t,f9t,f10t,f11t,f12t,f13t,f14t,f15t,f16t,f17t,f18t,f26,f26t) values($vid,1,4,1,1,2,2,3,4,4,3,3,4,4,1,4,2,1,2,1,15)";
                break;
        }
        return mysql_query($q, $this->connection);
    }

    function isVillageOases($wref)
    {
        $q = "SELECT oasistype FROM " . TB_PREFIX . "wdata where id = $wref LIMIT 1";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        return $dbarray['oasistype'];
    }

    public function VillageOasisCount($vref)
    {
        $q = "SELECT count(*) FROM " . TB_PREFIX . "odata WHERE conqured=$vref";
        $result = mysql_query($q, $this->connection);
        $row = mysql_fetch_row($result);
        return $row[0];
    }

    function populateOasis()
    {
        $q = "SELECT id FROM " . TB_PREFIX . "wdata where oasistype != 0";
        $result = mysql_query($q, $this->connection);
        while ($row = mysql_fetch_array($result)) {
            $wid = $row['id'];

            $this->addUnits($wid);

        }
    }


    /***************************
     * Function to retrieve type of village via ID
     * References: Village ID
     ***************************/
   function getVillageOasis($list, $limit, $order)
    {
		$wref = $this->getVilWref($order['x'], $order['y']);
        $where = ' WHERE TRUE and conqured = '.$wref;
        /*foreach($list as $k=>$v){
					if ($k != 'extra') $where .= " AND $k = $v ";
				}
				$where .= ' AND '.$list['extra'].' ';
				*/
        if (isset($limit)) $limit = " LIMIT $limit ";
        if (isset($order) && $order['by'] != '') $orderby = " ORDER BY " . $order['by'] . ' ';
        $q = 'SELECT ';
        if ($order['by'] == 'distance') {
            $q .= " *,(ROUND(SQRT(POW(LEAST(ABS(" . $order['x'] . " - " . TB_PREFIX . "wdata.x), ABS(" . $order['max'] . " - ABS(" . $order['x'] . " - " . TB_PREFIX . "wdata.x))), 2) + POW(LEAST(ABS(" . $order['y'] . " - " . TB_PREFIX . "wdata.y), ABS(" . $order['max'] . " - ABS(" . $order['y'] . " - " . TB_PREFIX . "wdata.y))), 2)),3)) AS distance FROM ";
        } else {
            $q .= " * FROM ";
        }
        $q .= TB_PREFIX . "odata LEFT JOIN " . TB_PREFIX . "wdata ON " . TB_PREFIX . "wdata.id=" . TB_PREFIX . "odata.wref " . $where . $orderby . $limit;

        return $this->query_return($q);
    }

    function getVillageType($wref)
    {
        $q = "SELECT fieldtype FROM " . TB_PREFIX . "wdata where id = $wref LIMIT 1";
        $result = mysql_query($q, $this->connection);
        if ($result) {
            $dbarray = mysql_fetch_array($result);
            return $dbarray['fieldtype'];
        } else {
            return false;
        }
    }

    function getVilWref($x, $y)
    {
        $q = "SELECT id FROM " . TB_PREFIX . "wdata where x = $x AND y = $y LIMIT 1";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        return $dbarray['id'];
    }

    function checkVilExist($wref)
    {
        $q = "SELECT wref FROM " . TB_PREFIX . "vdata where wref = '$wref' LIMIT 1";
        $result = mysql_query($q, $this->connection);
        if (mysql_num_rows($result)) {
            return true;
        } else {
            return false;
        }
    }

    function getVillageState($wref)
    {
        $q = "SELECT oasistype,occupied FROM " . TB_PREFIX . "wdata where id = $wref LIMIT 1";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        if ($dbarray['occupied'] != 0 || $dbarray['oasistype'] != 0) {
            return true;
        } else {
            return false;
        }
    }

    function getVillageStateForSettle($wref)
    {
        $q = "SELECT `oasistype`,`occupied`,`fieldtype` FROM " . TB_PREFIX . "wdata where id = $wref LIMIT 1";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        if ($dbarray['occupied'] == 0 && $dbarray['oasistype'] == 0 && $dbarray['fieldtype'] == 0) {
            return true;
        } else {
            return false;
        }
    }

    function getProfileVillages($uid)
    {
        $q = "SELECT `wref`,`maxstore`,`maxcrop`,`pop`,`name`,`capital` from " . TB_PREFIX . "vdata where owner = $uid order by pop desc";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function getProfileMedal($uid)
    {
        $q = "SELECT id,categorie,plaats,week,img,points from " . TB_PREFIX . "medal where userid = $uid order by id desc";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);

    }

    function getProfileMedalAlly($uid)
    {
        $q = "SELECT id,categorie,plaats,week,img,points from " . TB_PREFIX . "allimedal where allyid = $uid order by id desc";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);

    }

    function getVillageID($uid)
    {
        $q = "SELECT wref FROM " . TB_PREFIX . "vdata WHERE owner = $uid";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        return $dbarray['wref'];
    }

    function getVillagesID($uid)
    {
        $q = "SELECT wref from " . TB_PREFIX . "vdata where owner = $uid order by capital DESC";
        $result = mysql_query($q, $this->connection);
        $array = $this->mysql_fetch_all($result);
        $newarray = array();
        for ($i = 0; $i < count($array); $i++) {
            array_push($newarray, $array[$i]['wref']);
        }
        return $newarray;
    }

    function getVillagesList($list, $limit, $order)
    {
        $where = ' WHERE TRUE ';
        foreach ($list as $k => $v) {
            if ($k != 'extra') $where .= " AND $k = $v ";
        }
        if (isset($list['extra'])) $where .= ' AND ' . $list['extra'] . ' ';
        if (isset($limit)) $limit = " LIMIT $limit ";
        if (isset($order) && $order['by'] != '') $orderby = " ORDER BY " . $order['by'] . ' ';
        $q = 'SELECT ';
        if ($order['by'] == 'distance') {
            $q .= " *,(ROUND(SQRT(POW(LEAST(ABS(" . $order['x'] . " - x), ABS(" . $order['max'] . " - ABS(" . $order['x'] . " - x))), 2) + POW(LEAST(ABS(" . $order['y'] . " - y), ABS(" . $order['max'] . " - ABS(" . $order['y'] . " - y))), 2)),3)) AS distance FROM ";
        } else {
            $q .= " * FROM ";
        }
        $q .= TB_PREFIX . "wdata " . $where . $orderby . $limit;
        return $this->query_return($q);
    }

    function getVillagesListCount($list)
    {
        $where = ' WHERE TRUE ';
        foreach ($list as $k => $v) {
            if ($k != 'extra') $where .= " AND $k = $v ";
        }
        if (isset($list['extra'])) $where .= ' AND ' . $list['extra'] . ' ';
        $q = "SELECT id FROM " . TB_PREFIX . "wdata " . $where;
        $result = mysql_query($q, $this->connection);
        return mysql_num_rows($result);
    }

    function getVillage($vid)
    {
        $q = "SELECT `wref`,`capital`,`name`,`celebration`,`owner`,`wood`,`woodp`,`clay`,`clayp`,`iron`,`ironp`,`crop`,`cropp`,`pop`,`upkeep`,`maxstore`,`maxcrop`,`loyalty`,`natar` FROM " . TB_PREFIX . "vdata where wref = $vid LIMIT 1";
        $result = $this->query_return($q);
        if (!empty($result) && count($result) > 0) {
            return $result[0];
        } else {
            return array();
        }
    }

    function getOasisV($vid)
    {
        $q = "SELECT `wref` FROM " . TB_PREFIX . "odata where wref = $vid LIMIT 1";
        $result = mysql_query($q, $this->connection);
        return mysql_fetch_array($result);
    }

    function getAInfo($id)
    {
        $q = "SELECT `x`,`y` FROM " . TB_PREFIX . "wdata where id = $id LIMIT 1";
        $result = mysql_query($q, $this->connection);
        return mysql_fetch_array($result);
    }

    function getMInfo($id)
    {
        $q = "SELECT * FROM " . TB_PREFIX . "wdata left JOIN " . TB_PREFIX . "vdata ON " . TB_PREFIX . "vdata.wref = " . TB_PREFIX . "wdata.id where " . TB_PREFIX . "wdata.id = $id";
        $result = mysql_query($q, $this->connection);
        return mysql_fetch_assoc($result);
    }

    function getOMInfo($id)
    {
        $q = "SELECT * FROM " . TB_PREFIX . "wdata left JOIN " . TB_PREFIX . "odata ON " . TB_PREFIX . "odata.wref = " . TB_PREFIX . "wdata.id where " . TB_PREFIX . "wdata.id = $id";
        $result = mysql_query($q, $this->connection);
        return mysql_fetch_array($result);
    }

    function getOasis($vid)
    {
        $q = "SELECT `type`,`wref` FROM " . TB_PREFIX . "odata where conqured = $vid";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function getOasisInfo($wid)
    {
        $q = "SELECT `conqured`,`loyalty` FROM " . TB_PREFIX . "odata where wref = $wid LIMIT 1";
        $result = mysql_query($q, $this->connection);
        return mysql_fetch_assoc($result);
    }

    function getVillageField($ref, $field)
    {
        $q = "SELECT $field FROM " . TB_PREFIX . "vdata where wref = $ref LIMIT 1";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        return $dbarray[$field];

    }

    function getOasisField($ref, $field)
    {
        $q = "SELECT $field FROM " . TB_PREFIX . "odata where wref = $ref LIMIT 1";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        return $dbarray[$field];
    }

    function setVillageField($ref, $field, $value)
    {
        if ((stripos($field, 'name') !== false) && ($value == '')) return false;
        $q = "UPDATE " . TB_PREFIX . "vdata set $field = '$value' where wref = $ref";
        return mysql_query($q, $this->connection);
    }

    function setVillageLevel($ref, $field, $value)
    {
        $q = "UPDATE " . TB_PREFIX . "fdata set " . $field . " = '" . $value . "' where vref = " . $ref . "";
        return mysql_query($q, $this->connection);
    }

    function removeTribeSpecificFields($vref)
    {
        $fields = $this->getResourceLevel($vref);
        $tribeSpecificArray = array(31, 32, 33, 35, 36, 41);
        for ($i = 19; $i <= 40; $i++) {
            if (in_array($fields['f' . $i . 't'], $tribeSpecificArray)) {
                $q = "UPDATE " . TB_PREFIX . "fdata set " . ('f' . $i) . " = '0', " . ('f' . $i . 't') . " = '0' WHERE vref = " . $vref;
                mysql_query($q, $this->connection);
            }
        }
        $q = 'UPDATE ' . TB_PREFIX . 'units SET u199=0 WHERE `vref`=' . $vref;
        mysql_query($q, $this->connection);
        $q = 'DELETE FROM ' . TB_PREFIX . 'trapped WHERE `vref`=' . $vref;
        mysql_query($q, $this->connection);
        $q = 'DELETE FROM ' . TB_PREFIX . 'training WHERE `vref`=' . $vref;
        mysql_query($q, $this->connection);
    }

    function getResourceLevel($vid)
    {
        $q = "SELECT * from " . TB_PREFIX . "fdata where vref = $vid";
        $result = $this->query_return($q);
        if ($result) {
            return $result[0];
        } else {
            return false;
        }
    }

    function getAdminLog($limit = 5)
    {
        $q = "SELECT * FROM " . TB_PREFIX . "admin_log ORDER BY id DESC LIMIT $limit";
        return $this->query_return($q);
    }

    function delAdminLog($id)
    {
        $q = "DELETE FROM " . TB_PREFIX . "admin_log where id = $id";
        return mysql_query($q, $this->connection);
    }

    function getCoor($wref)
    {
        $q = "SELECT x,y FROM " . TB_PREFIX . "wdata where id = $wref LIMIT 1";
        $result = mysql_query($q, $this->connection);
        return mysql_fetch_array($result);
    }

    function CheckForum($id)
    {
        $q = "SELECT id from " . TB_PREFIX . "forum_cat where alliance = '$id'";
        $result = mysql_query($q, $this->connection);
        if (mysql_num_rows($result)) {
            return true;
        } else {
            return false;
        }
    }

    function CountCat($id)
    {
        $q = "SELECT count(id) FROM " . TB_PREFIX . "forum_topic where cat = '$id'";
        $result = mysql_query($q, $this->connection);
        $row = mysql_fetch_row($result);
        return $row[0];
    }

    function LastTopic($id)
    {
        $q = "SELECT `id` from " . TB_PREFIX . "forum_topic where cat = '$id' order by post_date";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function check_forumRules($id)
    {
        global $session;
        $q = "SELECT * FROM " . TB_PREFIX . "fpost_rules WHERE forum_id = $id";
        $z = mysql_query($q, $this->connection);
        $row = mysql_fetch_assoc($z);

        $ids = explode(',', $row['players_id']);
        foreach ($ids as $pid) {
            if ($pid == $session->uid) return false;
        }
        $idn = explode(',', $row['players_name']);
        foreach ($idn as $pid) {
            if ($pid == $_SESSION['username']) return false;
        }

        $aid = $session->alliance;
        $ids = explode(',', $row['ally_id']);
        foreach ($ids as $pid) {
            if ($pid == $aid) return false;
        }
        $q = "SELECT `tag` FROM " . TB_PREFIX . "alidata WHERE id = $aid";
        $z = mysql_query($q, $this->connection);
        $rows = mysql_fetch_assoc($z);

        $idn = explode(',', $row['ally_tag']);
        foreach ($idn as $pid) {
            if ($pid == $rows['tag']) return false;
        }

        return true;

    }

    function CheckLastTopic($id)
    {
        $q = "SELECT id from " . TB_PREFIX . "forum_topic where cat = '$id'";
        $result = mysql_query($q, $this->connection);
        if (mysql_num_rows($result)) {
            return true;
        } else {
            return false;
        }
    }

    function CheckLastPost($id)
    {
        $q = "SELECT id from " . TB_PREFIX . "forum_post where topic = '$id'";
        $result = mysql_query($q, $this->connection);
        if (mysql_num_rows($result)) {
            return true;
        } else {
            return false;
        }
    }

    function LastPost($id)
    {
        $q = "SELECT `date`,`owner` from " . TB_PREFIX . "forum_post where topic = '$id'";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function CountTopic($id)
    {
        $q = "SELECT count(id) FROM " . TB_PREFIX . "forum_post where owner = '$id'";
        $result = mysql_query($q, $this->connection);
        $row = mysql_fetch_row($result);

        $qs = "SELECT count(id) FROM " . TB_PREFIX . "forum_topic where owner = '$id'";
        $results = mysql_query($qs, $this->connection);
        $rows = mysql_fetch_row($results);
        return $row[0] + $rows[0];
    }

    function CountPost($id)
    {
        $q = "SELECT count(id) FROM " . TB_PREFIX . "forum_post where topic = '$id'";
        $result = mysql_query($q, $this->connection);
        $row = mysql_fetch_row($result);
        return $row[0];
    }

    function ForumCat($id)
    {
        $q = "SELECT * from " . TB_PREFIX . "forum_cat where alliance = '$id' ORDER BY id";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function ForumCatEdit($id)
    {
        $q = "SELECT * from " . TB_PREFIX . "forum_cat where id = '$id'";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function ForumCatName($id)
    {
        $q = "SELECT forum_name from " . TB_PREFIX . "forum_cat where id = $id";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        return $dbarray['forum_name'];
    }

    function CheckCatTopic($id)
    {
        $q = "SELECT id from " . TB_PREFIX . "forum_topic where cat = '$id'";
        $result = mysql_query($q, $this->connection);
        if (mysql_num_rows($result)) {
            return true;
        } else {
            return false;
        }
    }

    function CheckResultEdit($alli)
    {
        $q = "SELECT id from " . TB_PREFIX . "forum_edit where alliance = '$alli'";
        $result = mysql_query($q, $this->connection);
        if (mysql_num_rows($result)) {
            return true;
        } else {
            return false;
        }
    }

    function CheckCloseTopic($id)
    {
        $q = "SELECT close from " . TB_PREFIX . "forum_topic where id = '$id'";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        return $dbarray['close'];
    }

    function CheckEditRes($alli)
    {
        $q = "SELECT result from " . TB_PREFIX . "forum_edit where alliance = '$alli'";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        return $dbarray['result'];
    }

    function CreatResultEdit($alli, $result)
    {
        $q = "INSERT into " . TB_PREFIX . "forum_edit values (0,'$alli','$result')";
        mysql_query($q, $this->connection);
        return mysql_insert_id($this->connection);
    }

    function UpdateResultEdit($alli, $result)
    {
        $date = time();
        $q = "UPDATE " . TB_PREFIX . "forum_edit set result = '$result' where alliance = '$alli'";
        return mysql_query($q, $this->connection);
    }

    function UpdateEditTopic($id, $title, $cat)
    {
        $q = "UPDATE " . TB_PREFIX . "forum_topic set title = '$title', cat = '$cat' where id = $id";
        return mysql_query($q, $this->connection);
    }

    function UpdateEditForum($id, $name, $des)
    {
        $q = "UPDATE " . TB_PREFIX . "forum_cat set forum_name = '$name', forum_des = '$des' where id = $id";
        return mysql_query($q, $this->connection);
    }

    function StickTopic($id, $mode)
    {
        $q = "UPDATE " . TB_PREFIX . "forum_topic set stick = '$mode' where id = '$id'";
        return mysql_query($q, $this->connection);
    }

    function ForumCatTopic($id)
    {
        $q = "SELECT * from " . TB_PREFIX . "forum_topic where cat = '$id' AND stick = '' ORDER BY post_date desc";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function ForumCatTopicStick($id)
    {
        $q = "SELECT * from " . TB_PREFIX . "forum_topic where cat = '$id' AND stick = '1' ORDER BY post_date desc";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function ShowTopic($id)
    {
        $q = "SELECT * from " . TB_PREFIX . "forum_topic where id = '$id'";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function ShowPost($id)
    {
        $q = "SELECT * from " . TB_PREFIX . "forum_post where topic = '$id'";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function ShowPostEdit($id)
    {
        $q = "SELECT * from " . TB_PREFIX . "forum_post where id = '$id'";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function CreatForum($owner, $alli, $name, $des, $area)
    {
        $q = "INSERT into " . TB_PREFIX . "forum_cat values (0,'$owner','$alli','$name','$des','$area')";
        mysql_query($q, $this->connection);
        return mysql_insert_id($this->connection);
    }

    function CreatTopic($title, $post, $cat, $owner, $alli, $ends)
    {
        $date = time();
        $q = "INSERT into " . TB_PREFIX . "forum_topic values (0,'$title','$post','$date','$date','$cat','$owner','$alli','$ends','','')";
        mysql_query($q, $this->connection);
        return mysql_insert_id($this->connection);
    }

    function CreatPost($post, $tids, $owner)
    {
        $date = time();
        $q = "INSERT into " . TB_PREFIX . "forum_post values (0,'$post','$tids','$owner','$date')";
        mysql_query($q, $this->connection);
        return mysql_insert_id($this->connection);
    }

    function UpdatePostDate($id)
    {
        $date = time();
        $q = "UPDATE " . TB_PREFIX . "forum_topic set post_date = '$date' where id = $id";
        return mysql_query($q, $this->connection);
    }

    function EditUpdateTopic($id, $post)
    {
        $q = "UPDATE " . TB_PREFIX . "forum_topic set post = '$post' where id = $id";
        return mysql_query($q, $this->connection);
    }

    function EditUpdatePost($id, $post)
    {
        $q = "UPDATE " . TB_PREFIX . "forum_post set post = '$post' where id = $id";
        return mysql_query($q, $this->connection);
    }

    function LockTopic($id, $mode)
    {
        $q = "UPDATE " . TB_PREFIX . "forum_topic set close = '$mode' where id = '$id'";
        return mysql_query($q, $this->connection);
    }

    function DeleteCat($id)
    {
        $qs = "DELETE from " . TB_PREFIX . "forum_cat where id = '$id'";
        $q = "DELETE from " . TB_PREFIX . "forum_topic where cat = '$id'";
        mysql_query($qs, $this->connection);
        return mysql_query($q, $this->connection);
    }

    function DeleteTopic($id)
    {
        $qs = "DELETE from " . TB_PREFIX . "forum_topic where id = '$id'";
        //  $q = "DELETE from ".TB_PREFIX."forum_post where topic = '$id'";//
        return mysql_query($qs, $this->connection); //
        // mysql_query($q,$this->connection);
    }

    function DeletePost($id)
    {
        $q = "DELETE from " . TB_PREFIX . "forum_post where id = '$id'";
        return mysql_query($q, $this->connection);
    }

    function getAllianceName($id)
    {
        if (!$id) return false;
        $q = "SELECT tag from " . TB_PREFIX . "alidata where id = $id";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        return $dbarray['tag'];
    }

    function getAlliancePermission($ref, $field, $mode)
    {
        if (!$mode) {
            $q = "SELECT $field FROM " . TB_PREFIX . "ali_permission where uid = '$ref'";
        } else {
            $q = "SELECT $field FROM " . TB_PREFIX . "ali_permission where username = '$ref'";
        }
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        return $dbarray[$field];
    }

    function ChangePos($id, $mode)
    { //??S-H=a-d=o-W??//
        $q = "SELECT `forum_area` from " . TB_PREFIX . "forum_cat where id = '$id'";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_assoc($result);
        if ($mode == '-1') {
            $q = "SELECT `id` from " . TB_PREFIX . "forum_cat WHERE forum_area = '" . $dbarray['forum_area'] . "' AND id < '$id' ORDER BY id DESC";
            $result2 = mysql_query($q, $this->connection);
            $dbarray2 = mysql_fetch_assoc($result2);
            if ($dbarray2) {
                $q = "UPDATE " . TB_PREFIX . "forum_cat set id = 0 where id = '" . $dbarray2['id'] . "'";
                mysql_query($q, $this->connection);
                $q = "UPDATE " . TB_PREFIX . "forum_cat set id = -1 where id = '" . $id . "'";
                mysql_query($q, $this->connection);
                $q = "UPDATE " . TB_PREFIX . "forum_cat set id = '" . $id . "' where id = '0'";
                mysql_query($q, $this->connection);
                $q = "UPDATE " . TB_PREFIX . "forum_cat set id = '" . $dbarray2['id'] . "' where id = '-1'";
                mysql_query($q, $this->connection);
            }
        } elseif ($mode == 1) {
            $q = "SELECT * from " . TB_PREFIX . "forum_cat where id > '$id' AND forum_area = '" . $dbarray['forum_area'] . "' LIMIT 0,1";
            $result2 = mysql_query($q, $this->connection);
            $dbarray2 = mysql_fetch_assoc($result2);
            if ($dbarray2) {
                $q = "UPDATE " . TB_PREFIX . "forum_cat set id = 0 where id = '" . $dbarray2['id'] . "'";
                mysql_query($q, $this->connection);
                $q = "UPDATE " . TB_PREFIX . "forum_cat set id = -1 where id = '" . $id . "'";
                mysql_query($q, $this->connection);
                $q = "UPDATE " . TB_PREFIX . "forum_cat set id = '" . $id . "' where id = '0'";
                mysql_query($q, $this->connection);
                $q = "UPDATE " . TB_PREFIX . "forum_cat set id = '" . $dbarray2['id'] . "' where id = '-1'";
                mysql_query($q, $this->connection);
            }
        }
    }

    function ForumCatAlliance($id)
    {
        $q = "SELECT `alliance` from " . TB_PREFIX . "forum_cat where id = $id";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_assoc($result);
        return $dbarray['alliance'];
    }

    function CreatPoll($id, $name, $p1_name, $p2_name, $p3_name, $p4_name)
    {
        $q = "INSERT into " . TB_PREFIX . "forum_poll values ('$id','$name','0','0','0','0','$p1_name','$p2_name','$p3_name','$p4_name','')";
        mysql_query($q, $this->connection);
        return mysql_insert_id($this->connection);
    }

    function CreatForum_rules($aid, $id, $users_id, $users_name, $alli_id, $alli_name)
    {
        $q = "INSERT into " . TB_PREFIX . "fpost_rules values ('$aid','$id','$users_id','$users_name', '$alli_id','$alli_name')";
        mysql_query($q, $this->connection);
        return mysql_insert_id($this->connection);
    }

    function getAlliance($id, $mod = 0)
    {
        if (!$id) return 0;
        switch ($mod) {
            case 0:
                $where = ' id = "' . $id . '"';
                break;
            case 1:
                $where = ' name = "' . $id . '"';
                break;
            case 2:
                $where = ' tag = "' . $id . '"';
                break;
        }
        $q = "SELECT `id`,`tag`,`desc`,`max`,`name`,`notice` from " . TB_PREFIX . "alidata where " . $where;
        $result = mysql_query($q, $this->connection);
        return mysql_fetch_assoc($result);
    }

    function setAlliName($aid, $name, $tag)
    {
        if (!$aid) return false;
        $q = "UPDATE " . TB_PREFIX . "alidata set name = '$name', tag = '$tag' where id = $aid";
        return mysql_query($q, $this->connection);
    }

    function isAllianceOwner($id)
    {
        if (!$id) return false;
        $q = "SELECT id from " . TB_PREFIX . "alidata where leader = '$id'";
        $result = mysql_query($q, $this->connection);
        if (mysql_num_rows($result)) {
            return true;
        } else {
            return false;
        }
    }

    function aExist($ref, $type)
    {
        $q = "SELECT $type FROM " . TB_PREFIX . "alidata where $type = '$ref'";
        $result = mysql_query($q, $this->connection);
        if (mysql_num_rows($result)) {
            return true;
        } else {
            return false;
        }
    }

    function createAlliance($tag, $name, $uid, $max)
    {
        $q = "INSERT into " . TB_PREFIX . "alidata values (0,'$name','$tag',$uid,0,0,0,'','',$max,'','','','','','','','')";
        mysql_query($q, $this->connection);
        return mysql_insert_id($this->connection);
    }

    /*****************************************
     * Function to insert an alliance new
     * References:
     *****************************************/
    function insertAlliNotice($aid, $notice)
    {
        $time = time();
        $q = "INSERT into " . TB_PREFIX . "ali_log values (0,'$aid','$notice',$time)";
        mysql_query($q, $this->connection);
        return mysql_insert_id($this->connection);
    }

    /*****************************************
     * Function to delete alliance if empty
     * References:
     *****************************************/
    function deleteAlliance($aid)
    {
        $result = mysql_query("SELECT id FROM " . TB_PREFIX . "users where alliance = $aid");
        $num_rows = mysql_num_rows($result);
        if ($num_rows == 0) {
            $q = "DELETE FROM " . TB_PREFIX . "alidata WHERE id = $aid";
        }
        mysql_query($q, $this->connection);
        return mysql_insert_id($this->connection);
    }

    /*****************************************
     * Function to read all alliance news
     * References:
     *****************************************/
    function readAlliNotice($aid)
    {
        $q = "SELECT * from " . TB_PREFIX . "ali_log where aid = $aid ORDER BY date DESC";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    /*****************************************
     * Function to create alliance permissions
     * References: ID, notice, description
     *****************************************/
    function createAlliPermissions($uid, $aid, $rank, $opt1, $opt2, $opt3, $opt4, $opt5, $opt6, $opt7, $opt8)
    {

        $q = "INSERT into " . TB_PREFIX . "ali_permission values(0,'$uid','$aid','$rank','$opt1','$opt2','$opt3','$opt4','$opt5','$opt6','$opt7','$opt8')";
        mysql_query($q, $this->connection);
        return mysql_insert_id($this->connection);
    }

    /*****************************************
     * Function to update alliance permissions
     * References:
     *****************************************/
    function deleteAlliPermissions($uid)
    {
        $q = "DELETE from " . TB_PREFIX . "ali_permission where uid = '$uid'";
        return mysql_query($q, $this->connection);
    }

    /*****************************************
     * Function to update alliance permissions
     * References:
     *****************************************/
    function updateAlliPermissions($uid, $aid, $rank, $opt1, $opt2, $opt3, $opt4, $opt5, $opt6, $opt7, $opt8 = 0)
    {

        $q = "UPDATE " . TB_PREFIX . "ali_permission SET rank = '$rank', opt1 = '$opt1', opt2 = '$opt2', opt3 = '$opt3', opt4 = '$opt4', opt5 = '$opt5', opt6 = '$opt6', opt7 = '$opt7', opt8 = '$opt8' where uid = $uid && alliance =$aid";
        return mysql_query($q, $this->connection);
    }

    /*****************************************
     * Function to read alliance permissions
     * References: ID, notice, description
     *****************************************/
    function getAlliPermissions($uid, $aid)
    {
        $q = "SELECT * FROM " . TB_PREFIX . "ali_permission where uid = $uid && alliance = $aid";
        $result = mysql_query($q, $this->connection);
        return mysql_fetch_assoc($result);
    }

    /*****************************************
     * Function to update an alliance description and notice
     * References: ID, notice, description
     *****************************************/
    function submitAlliProfile($aid, $notice, $desc)
    {
        if (!$aid) return false;
        $q = "UPDATE " . TB_PREFIX . "alidata SET `notice` = '$notice', `desc` = '$desc' where id = $aid";
        return mysql_query($q, $this->connection);
    }

    function diplomacyInviteAdd($alli1, $alli2, $type)
    {
        $q = "INSERT INTO " . TB_PREFIX . "diplomacy (alli1,alli2,type,accepted) VALUES ($alli1,$alli2," . (int)intval($type) . ",0)";
        return mysql_query($q, $this->connection);
    }

    function diplomacyOwnOffers($session_alliance)
    {
        $q = "SELECT * FROM " . TB_PREFIX . "diplomacy WHERE alli1 = $session_alliance AND accepted = 0";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function getAllianceID($name)
    {
        $q = "SELECT id FROM " . TB_PREFIX . "alidata WHERE tag ='" . $this->RemoveXSS($name) . "'";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        return $dbarray['id'];
    }

    function diplomacyCancelOffer($id)
    {
        $q = "DELETE FROM " . TB_PREFIX . "diplomacy WHERE id = $id";
        return mysql_query($q, $this->connection);
    }

    function diplomacyInviteAccept($id, $session_alliance)
    {
        $q = "UPDATE " . TB_PREFIX . "diplomacy SET accepted = 1 WHERE id = $id AND alli2 = $session_alliance";
        return mysql_query($q, $this->connection);
    }

    function diplomacyInviteDenied($id, $session_alliance)
    {
        $q = "DELETE FROM " . TB_PREFIX . "diplomacy WHERE id = $id AND alli2 = $session_alliance";
        return mysql_query($q, $this->connection);
    }

    function diplomacyInviteCheck($session_alliance)
    {
        $q = "SELECT * FROM " . TB_PREFIX . "diplomacy WHERE alli2 = $session_alliance AND accepted = 0";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function diplomacyExistingRelationships($session_alliance)
    {
        $q = "SELECT * FROM " . TB_PREFIX . "diplomacy WHERE alli2 = $session_alliance AND accepted = 1";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function diplomacyExistingRelationships2($session_alliance)
    {
        $q = "SELECT * FROM " . TB_PREFIX . "diplomacy WHERE alli1 = $session_alliance AND accepted = 1";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function diplomacyCancelExistingRelationship($id, $session_alliance)
    {
        $q = "DELETE FROM " . TB_PREFIX . "diplomacy WHERE id = $id AND alli2 = $session_alliance";
        return mysql_query($q, $this->connection);
    }

    function getUserAlliance($id)
    {
        if (!$id) return false;
        $q = "SELECT " . TB_PREFIX . "alidata.tag from " . TB_PREFIX . "users join " . TB_PREFIX . "alidata where " . TB_PREFIX . "users.alliance = " . TB_PREFIX . "alidata.id and " . TB_PREFIX . "users.id = $id";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        if ($dbarray['tag'] == "") {
            return "-";
        } else {
            return $dbarray['tag'];
        }
    }

    function modifyResource($vid, $wood, $clay, $iron, $crop, $mode)
    {
        if (!$mode) {
            $q = "UPDATE " . TB_PREFIX . "vdata set wood = wood - $wood, clay = clay - $clay, iron = iron - $iron, crop = crop - $crop where wref = $vid";
        } else {
            $q = "UPDATE " . TB_PREFIX . "vdata set wood = wood + $wood, clay = clay + $clay, iron = iron + $iron, crop = crop + $crop where wref = $vid";
        }
        return mysql_query($q, $this->connection);
    }

    function modifyProduction($vid, $woodp, $clayp, $ironp, $cropp, $upkeep)
    {
        $q = "UPDATE " . TB_PREFIX . "vdata set woodp = $woodp, clayp = $clayp, ironp = $ironp, cropp = $cropp, upkeep = $upkeep where wref = $vid";
        return mysql_query($q, $this->connection);
    }


    function modifyOasisResource($vid, $wood, $clay, $iron, $crop, $mode)
    {
        if (!$mode) {
            $q = "UPDATE " . TB_PREFIX . "odata set wood = wood - $wood, clay = clay - $clay, iron = iron - $iron, crop = crop - $crop where wref = $vid";
        } else {
            $q = "UPDATE " . TB_PREFIX . "odata set wood = wood + $wood, clay = clay + $clay, iron = iron + $iron, crop = crop + $crop where wref = $vid";
        }
        return mysql_query($q, $this->connection);
    }

    function getFieldLevel($vid, $field)
    {
        $q = "SELECT f" . $field . " from " . TB_PREFIX . "fdata where vref = $vid";
        $result = mysql_query($q, $this->connection);
        return mysql_result($result, 0);
    }

    function getFieldType($vid, $field)
    {
        $q = "SELECT f" . $field . "t from " . TB_PREFIX . "fdata where vref = $vid";
        $result = mysql_query($q, $this->connection);
        return mysql_result($result, 0);
    }

    function getVSumField($uid, $field)
    {
        $q = "SELECT sum(" . $field . ") FROM " . TB_PREFIX . "vdata where owner = $uid";
        $result = mysql_query($q, $this->connection);
        $row = mysql_fetch_row($result);
        return $row[0];
    }

    function updateVillage($vid)
    {
        $time = time();
        $q = "UPDATE " . TB_PREFIX . "vdata set lastupdate = $time where wref = $vid";
        return mysql_query($q, $this->connection);
    }

    function updateOasis($vid)
    {
        $time = time();
        $q = "UPDATE " . TB_PREFIX . "odata set lastupdated = $time where wref = $vid";
        return mysql_query($q, $this->connection);
    }


    function setVillageName($vid, $name)
    {
        if ($name == '') return false;
        $q = "UPDATE " . TB_PREFIX . "vdata set name = '$name' where wref = $vid";
        return mysql_query($q, $this->connection);
    }

    function modifyPop($vid, $pop, $mode)
    {
        if (!$mode) {
            $q = "UPDATE " . TB_PREFIX . "vdata set pop = pop + $pop where wref = $vid";
        } else {
            $q = "UPDATE " . TB_PREFIX . "vdata set pop = pop - $pop where wref = $vid";
        }
        return mysql_query($q, $this->connection);
    }

    function addCP($ref, $cp)
    {
        $q = "UPDATE " . TB_PREFIX . "vdata set cp = cp + '$cp' where wref = '$ref'";
        return mysql_query($q, $this->connection);
    }

    function addCel($ref, $cel, $type)
    {
        $q = "UPDATE " . TB_PREFIX . "vdata set celebration = $cel, type= $type where wref = $ref";
        return mysql_query($q, $this->connection);
    }

    function getCel()
    {
        $time = time();
        $q = "SELECT `wref`,`type`,`owner` FROM " . TB_PREFIX . "vdata where celebration < $time AND celebration != 0";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function getActiveGCel($vref)
    {
        $time = time();
        $q = "SELECT * FROM " . TB_PREFIX . "vdata WHERE vref = $vref AND celebration > $time AND type=2";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function clearCel($ref)
    {
        $q = "UPDATE " . TB_PREFIX . "vdata set celebration = 0, type = 0 where wref = $ref";
        return mysql_query($q, $this->connection);
    }

    function setCelCp($user, $cp)
    {
        $q = "UPDATE " . TB_PREFIX . "users set cp = cp + $cp where id = $user";
        return mysql_query($q, $this->connection);
    }

    function getInvitation($uid,$ally)
    {
        $q = "SELECT * FROM " . TB_PREFIX . "ali_invite where uid = $uid AND alliance = $ally";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

	function getInvitation2($uid)
    {
        $q = "SELECT * FROM " . TB_PREFIX . "ali_invite where uid = $uid";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function getAliInvitations($aid)
    {
        $q = "SELECT * FROM " . TB_PREFIX . "ali_invite where alliance = $aid && accept = 0";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function sendInvitation($uid, $alli, $sender)
    {
        $time = time();
        $q = "INSERT INTO " . TB_PREFIX . "ali_invite values (0,$uid,$alli,$sender,$time,0)";
        return mysql_query($q, $this->connection);
    }

    function removeInvitation($id)
    {
        $q = "DELETE FROM " . TB_PREFIX . "ali_invite where id = $id";
        return mysql_query($q, $this->connection);
    }

    function delMessage($id)
    {
        $q = "DELETE FROM " . TB_PREFIX . "mdata WHERE id = $id";
        return mysql_query($q, $this->connection);
    }

    function delNotice($id, $uid)
    {
        $q = "DELETE FROM " . TB_PREFIX . "ndata WHERE id = $id AND uid = $uid";
        return mysql_query($q, $this->connection);
    }

    function sendMessage($client, $owner, $topic, $message, $send, $alliance, $player, $coor, $report)
    {
        $time = $_SERVER['REQUEST_TIME'];
        $q = "INSERT INTO " . TB_PREFIX . "mdata values (0,$client,$owner,'$topic',\"$message\",0,0,$send,$time,0,0,$alliance,$player,$coor,$report)";
        return mysql_query($q, $this->connection);
    }

    function setArchived($id)
    {
        $q = "UPDATE " . TB_PREFIX . "mdata set archived = 1 where id = $id";
        return mysql_query($q, $this->connection);
    }

    function setNorm($id)
    {
        $q = "UPDATE " . TB_PREFIX . "mdata set archived = 0 where id = $id";
        return mysql_query($q, $this->connection);
    }

    function getMessage($id, $mode)
    {
        global $session;
        switch ($mode) {
            case 1:
                $q = "SELECT `id`,`target`,`owner`,`topic`,`message`,`viewed`,`archived`,`send`,`time`,`deltarget`,`delowner`,`alliance`,`player`,`coor`,`report` FROM " . TB_PREFIX . "mdata WHERE target = $id and send = 0 and archived = 0 ORDER BY time DESC";
                break;
            case 2:
                $q = "SELECT `id`,`target`,`owner`,`topic`,`message`,`viewed`,`archived`,`send`,`time`,`deltarget`,`delowner`,`alliance`,`player`,`coor`,`report` FROM " . TB_PREFIX . "mdata WHERE owner = $id ORDER BY time DESC";
                break;
            case 3:
                $q = "SELECT `id`,`target`,`owner`,`topic`,`message`,`viewed`,`archived`,`send`,`time`,`deltarget`,`delowner`,`alliance`,`player`,`coor`,`report` FROM " . TB_PREFIX . "mdata where id = $id";
                break;
            case 4:
                $q = "UPDATE " . TB_PREFIX . "mdata set viewed = 1 where id = $id AND target = $session->uid";
                break;
            case 5:
                $q = "UPDATE " . TB_PREFIX . "mdata set deltarget = 1 ,viewed = 1 where id = $id";
                break;
            case 6:
                $q = "SELECT `id`,`target`,`owner`,`topic`,`message`,`viewed`,`archived`,`send`,`time`,`deltarget`,`delowner`,`alliance`,`player`,`coor`,`report` FROM " . TB_PREFIX . "mdata where target = $id and send = 0 and archived = 1";
                break;
            case 7:
                $q = "UPDATE " . TB_PREFIX . "mdata set delowner = 1 where id = $id";
                break;
            case 8:
                $q = "UPDATE " . TB_PREFIX . "mdata set deltarget = 1, delowner = 1, viewed = 1 where id = $id";
                break;
            case 9:
                $q = "SELECT `id`,`target`,`owner`,`topic`,`message`,`viewed`,`archived`,`send`,`time`,`deltarget`,`delowner`,`alliance`,`player`,`coor`,`report` FROM " . TB_PREFIX . "mdata WHERE target = $id and send = 0 and archived = 0 and deltarget = 0 and viewed = 0 ORDER BY time DESC";
                break;
            case 10:
                $q = "SELECT `id`,`target`,`owner`,`topic`,`message`,`viewed`,`archived`,`send`,`time`,`deltarget`,`delowner`,`alliance`,`player`,`coor`,`report` FROM " . TB_PREFIX . "mdata WHERE owner = $id and delowner = 0 ORDER BY time DESC";
                break;
            case 11:
                $q = "SELECT `id`,`target`,`owner`,`topic`,`message`,`viewed`,`archived`,`send`,`time`,`deltarget`,`delowner`,`alliance`,`player`,`coor`,`report` FROM " . TB_PREFIX . "mdata where target = $id and send = 0 and archived = 1 and deltarget = 0";
                break;
			case 12:
                $q = "SELECT `id`,`target`,`owner`,`topic`,`message`,`viewed`,`archived`,`send`,`time`,`deltarget`,`delowner`,`alliance`,`player`,`coor`,`report` FROM " . TB_PREFIX . "mdata WHERE target = $id and send = 0 and archived = 0 and deltarget = 0 and viewed = 0 ORDER BY time DESC LIMIT 1";
                break;
        }
        if ($mode <= 3 || $mode == 6 || $mode > 8) {
            $result = mysql_query($q, $this->connection);
            return $this->mysql_fetch_all($result);
        } else {
            return mysql_query($q, $this->connection);
        }
    }

    function unarchiveNotice($id)
    {
        $q = "UPDATE " . TB_PREFIX . "ndata set `archive` = 0 where id = $id";
        return mysql_query($q, $this->connection);
    }

    function archiveNotice($id)
    {
        $q = "update " . TB_PREFIX . "ndata set `archive` = 1 where id = $id";
        return mysql_query($q, $this->connection);
    }

    function removeNotice($id)
    {
        $q = "DELETE FROM " . TB_PREFIX . "ndata where id = $id";
        return mysql_query($q, $this->connection);
    }

    function noticeViewed($id)
    {
        $q = "UPDATE " . TB_PREFIX . "ndata set viewed = 1 where id = $id";
        return mysql_query($q, $this->connection);
    }

    function addNotice($uid, $toWref, $ally, $type, $topic, $data, $time = 0)
    {
        if ($time == 0) {
            $time = time();
        }
        $q = "INSERT INTO " . TB_PREFIX . "ndata (id, uid, toWref, ally, topic, ntype, data, time, viewed) values (0,'$uid','$toWref','$ally','$topic',$type,'$data',$time,0)";
        return mysql_query($q, $this->connection);
    }

    function getNotice($uid)
    {
        $q = "SELECT * FROM " . TB_PREFIX . "ndata where uid = $uid ORDER BY time DESC LIMIT 99";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function getNoticeReportBox($uid)
    {
        $q = "SELECT COUNT(`id`) as maxreport FROM " . TB_PREFIX . "ndata where uid = $uid ORDER BY time DESC LIMIT 200";
        $result = mysql_query($q, $this->connection);
        $result = mysql_fetch_assoc($result);
        return $result['maxreport'];
    }

    function addBuilding($wid, $field, $type, $loop, $time, $master, $level)
    {
        $x = "UPDATE " . TB_PREFIX . "fdata SET f" . $field . "t=" . $type . " WHERE vref=" . $wid;
        mysql_query($x, $this->connection);
        $q = "INSERT into " . TB_PREFIX . "bdata values (0,$wid,$field,$type,$loop,$time,$master,$level)";
        return mysql_query($q, $this->connection);
    }

    function removeBuilding($d)
    {
        global $building;
        $jobLoopconID = -1;
        $SameBuildCount = 0;
        $jobs = $building->buildArray;
        for ($i = 0; $i < sizeof($jobs); $i++) {
            if ($jobs[$i]['id'] == $d) {
                $jobDeleted = $i;
            }
            if ($jobs[$i]['loopcon'] == 1) {
                $jobLoopconID = $i;
            }
            if ($jobs[$i]['master'] == 1) {
                $jobMaster = $i;
            }
        }
        if (count($jobs) > 1 && ($jobs[0]['field'] == $jobs[1]['field'])) {
            $SameBuildCount = 1;
        }
        if (count($jobs) > 2 && ($jobs[0]['field'] == $jobs[2]['field'])) {
            $SameBuildCount = 2;
        }
        if (count($jobs) > 2 && ($jobs[1]['field'] == $jobs[2]['field'])) {
            $SameBuildCount = 3;
        }
        if (count($jobs) > 2 && ($jobs[0]['field'] == ($jobs[1]['field'] == $jobs[2]['field']))) {
            $SameBuildCount = 4;
        }
        if (count($jobs) > 3 && ($jobs[0]['field'] == ($jobs[1]['field'] == $jobs[3]['field']))) {
            $SameBuildCount = 5;
        }
        if (count($jobs) > 3 && ($jobs[0]['field'] == ($jobs[2]['field'] == $jobs[3]['field']))) {
            $SameBuildCount = 6;
        }
        if (count($jobs) > 3 && ($jobs[1]['field'] == ($jobs[2]['field'] == $jobs[3]['field']))) {
            $SameBuildCount = 7;
        }
        if (count($jobs) > 3 && ($jobs[0]['field'] == $jobs[3]['field'])) {
            $SameBuildCount = 8;
        }
        if (count($jobs) > 3 && ($jobs[1]['field'] == $jobs[3]['field'])) {
            $SameBuildCount = 9;
        }
        if (count($jobs) > 3 && ($jobs[2]['field'] == $jobs[3]['field'])) {
            $SameBuildCount = 10;
        }
        if ($SameBuildCount > 0) {
            if ($SameBuildCount > 3) {
                if ($SameBuildCount == 4 or $SameBuildCount == 5) {
                    if ($jobDeleted == 0) {
                        $uprequire = $building->resourceRequired($jobs[1]['field'], $jobs[1]['type'], 1);
                        $time = $uprequire['time'];
                        $timestamp = $time + time();
                        $q = "UPDATE " . TB_PREFIX . "bdata SET loopcon=0,level=level-1,timestamp=" . $timestamp . " WHERE id=" . $jobs[1]['id'] . "";
                        mysql_query($q, $this->connection);
                    }
                } else if ($SameBuildCount == 6) {
                    if ($jobDeleted == 0) {
                        $uprequire = $building->resourceRequired($jobs[2]['field'], $jobs[2]['type'], 1);
                        $time = $uprequire['time'];
                        $timestamp = $time + time();
                        $q = "UPDATE " . TB_PREFIX . "bdata SET loopcon=0,level=level-1,timestamp=" . $timestamp . " WHERE id=" . $jobs[2]['id'] . "";
                        mysql_query($q, $this->connection);
                    }
                } else if ($SameBuildCount == 7) {
                    if ($jobDeleted == 1) {
                        $uprequire = $building->resourceRequired($jobs[2]['field'], $jobs[2]['type'], 1);
                        $time = $uprequire['time'];
                        $timestamp = $time + time();
                        $q = "UPDATE " . TB_PREFIX . "bdata SET loopcon=0,level=level-1,timestamp=" . $timestamp . " WHERE id=" . $jobs[2]['id'] . "";
                        mysql_query($q, $this->connection);
                    }
                }
                if ($SameBuildCount < 8) {
                    $uprequire1 = $building->resourceRequired($jobs[$jobMaster]['field'], $jobs[$jobMaster]['type'], 2);
                    $time1 = $uprequire1['time'];
                    $timestamp1 = $time1;
                    $q1 = "UPDATE " . TB_PREFIX . "bdata SET level=level-1,timestamp=" . $timestamp1 . " WHERE id=" . $jobs[$jobMaster]['id'] . "";
                    mysql_query($q1, $this->connection);
                } else {
                    $uprequire1 = $building->resourceRequired($jobs[$jobMaster]['field'], $jobs[$jobMaster]['type'], 1);
                    $time1 = $uprequire1['time'];
                    $timestamp1 = $time1;
                    $q1 = "UPDATE " . TB_PREFIX . "bdata SET level=level-1,timestamp=" . $timestamp1 . " WHERE id=" . $jobs[$jobMaster]['id'] . "";
                    mysql_query($q1, $this->connection);
                }
            } else if ($d == $jobs[floor($SameBuildCount / 3)]['id'] || $d == $jobs[floor($SameBuildCount / 2) + 1]['id']) {
                $q = "UPDATE " . TB_PREFIX . "bdata SET loopcon=0,level=level-1,timestamp=" . $jobs[floor($SameBuildCount / 3)]['timestamp'] . " WHERE master = 0 AND id > " . $d . " and (ID=" . $jobs[floor($SameBuildCount / 3)]['id'] . " OR ID=" . $jobs[floor($SameBuildCount / 2) + 1]['id'] . ")";
                mysql_query($q, $this->connection);
            }
        } else {
            if ($jobs[$jobDeleted]['field'] >= 19) {
                $x = "SELECT f" . $jobs[$jobDeleted]['field'] . " FROM " . TB_PREFIX . "fdata WHERE vref=" . $jobs[$jobDeleted]['wid'];
                $result = mysql_query($x, $this->connection);
                $fieldlevel = mysql_fetch_row($result);
                if ($fieldlevel[0] == 0) {
                    $x = "UPDATE " . TB_PREFIX . "fdata SET f" . $jobs[$jobDeleted]['field'] . "t=0 WHERE vref=" . $jobs[$jobDeleted]['wid'];
                    mysql_query($x, $this->connection);
                }
            }
            if (($jobLoopconID >= 0) && ($jobs[$jobDeleted]['loopcon'] != 1)) {
                if (($jobs[$jobLoopconID]['field'] <= 18 && $jobs[$jobDeleted]['field'] <= 18) || ($jobs[$jobLoopconID]['field'] >= 19 && $jobs[$jobDeleted]['field'] >= 19) || sizeof($jobs) < 3) {
                    $uprequire = $building->resourceRequired($jobs[$jobLoopconID]['field'], $jobs[$jobLoopconID]['type']);
                    $x = "UPDATE " . TB_PREFIX . "bdata SET loopcon=0,timestamp=" . (time() + $uprequire['time']) . " WHERE wid=" . $jobs[$jobDeleted]['wid'] . " AND loopcon=1 AND master=0";
                    mysql_query($x, $this->connection);
                }
            }
        }
        $q = "DELETE FROM " . TB_PREFIX . "bdata where id = $d";
        return mysql_query($q, $this->connection);
    }

    function addDemolition($wid, $field)
    {
        global $building, $village;
        $q = "DELETE FROM " . TB_PREFIX . "bdata WHERE field=$field AND wid=$wid";
        mysql_query($q, $this->connection);
        $uprequire = $building->resourceRequired($field - 1, $village->resarray['f' . $field . 't']);
        $q = "INSERT INTO " . TB_PREFIX . "demolition VALUES (" . $wid . "," . $field . "," . ($this->getFieldLevel($wid, $field) - 1) . "," . (time() + floor($uprequire['time'] / 2)) . ")";
        return mysql_query($q, $this->connection);
    }


    function getDemolition($wid = 0)
    {
        if ($wid) {
            $q = "SELECT `vref`,`buildnumber`,`timetofinish` FROM " . TB_PREFIX . "demolition WHERE vref=" . $wid;
        } else {
            $q = "SELECT `vref`,`buildnumber`,`timetofinish` FROM " . TB_PREFIX . "demolition WHERE timetofinish<=" . time();
        }
        $result = mysql_query($q, $this->connection);
        if (!empty($result)) {
            return $this->mysql_fetch_all($result);
        } else {
            return NULL;
        }
    }

    function finishDemolition($wid)
    {
        $q = "UPDATE " . TB_PREFIX . "demolition SET timetofinish=0 WHERE vref=" . $wid;
        return mysql_query($q, $this->connection);
    }

    function delDemolition($wid)
    {
        $q = "DELETE FROM " . TB_PREFIX . "demolition WHERE vref=" . $wid;
        return mysql_query($q, $this->connection);
    }

    function getJobs($wid)
    {
        $q = "SELECT * FROM " . TB_PREFIX . "bdata where wid = $wid order by ID ASC";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function FinishWoodcutter($wid)
    {
        $time = time() - 1;
        $q = "SELECT id FROM " . TB_PREFIX . "bdata where wid = $wid and type = 1 order by master,timestamp ASC";
        $result = mysql_query($q);
        $dbarray = mysql_fetch_array($result);
        $q = "UPDATE " . TB_PREFIX . "bdata SET timestamp = $time WHERE id = '" . $dbarray['id'] . "'";
        $this->query($q);
    }

    function FinishCropLand($wid)
    {
        $time = $_SERVER['REQUEST_TIME'] - 1;
        $q = "SELECT `id`,`timestamp` FROM " . TB_PREFIX . "bdata where wid = $wid and type = 4 order by master,timestamp ASC";
        $result = mysql_query($q);
        $dbarray = mysql_fetch_assoc($result);
        $q = "UPDATE " . TB_PREFIX . "bdata SET timestamp = $time WHERE id = '" . $dbarray['id'] . "'";
        $this->query($q);
        $q2 = "SELECT `id` FROM " . TB_PREFIX . "bdata where wid = $wid and loopcon = 1 and field <= 18 order by master,timestamp ASC";
        if (mysql_num_rows($q2) > 0) {
            $result2 = mysql_query($q2);
            $dbarray2 = mysql_fetch_assoc($result2);
            $wc_time = $dbarray['timestamp'];
            $q2 = "UPDATE " . TB_PREFIX . "bdata SET timestamp = timestamp - $wc_time WHERE id = '" . $dbarray2['id'] . "'";
            $this->query($q2);
        }
    }

    function finishBuildings($wid)
    {
        $time = time() - 1;
        $q = "SELECT id FROM " . TB_PREFIX . "bdata where wid = $wid order by master,timestamp ASC";
        $result = mysql_query($q);
        while ($row = mysql_fetch_assoc($result)) {
            $q = "UPDATE " . TB_PREFIX . "bdata SET timestamp = $time WHERE id = '" . $row['id'] . "'";
            $this->query($q);
        }
    }

    function getMasterJobs($wid)
    {
        $q = "SELECT `id` FROM " . TB_PREFIX . "bdata where wid = $wid and master = 1 order by master,timestamp ASC";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function getBuildingByField($wid, $field)
    {
        $q = "SELECT `id` FROM " . TB_PREFIX . "bdata where wid = $wid and field = $field and master = 0";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function getBuildingByType($wid, $type)
    {
        $q = "SELECT `id` FROM " . TB_PREFIX . "bdata where wid = $wid and type = $type and master = 0";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function getDorf1Building($wid)
    {
        $q = "SELECT `timestamp` FROM " . TB_PREFIX . "bdata where wid = $wid and field < 19 and master = 0";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function getDorf2Building($wid)
    {
        $q = "SELECT `timestamp` FROM " . TB_PREFIX . "bdata where wid = $wid and field > 18 and master = 0";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function updateBuildingWithMaster($id, $time, $loop)
    {
        $q = "UPDATE " . TB_PREFIX . "bdata SET master = 0, timestamp = " . $time . ",loopcon = " . $loop . " WHERE id = " . $id . "";
        return mysql_query($q, $this->connection);
    }

    function getVillageByName($name)
    {
        $name = mysql_real_escape_string($name, $this->connection);
        $q = "SELECT wref FROM " . TB_PREFIX . "vdata where name = '$name' limit 1";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        return $dbarray['wref'];
    }

    /***************************
     * Function to set accept flag on market
     * References: id
     ***************************/
    function setMarketAcc($id)
    {
        $q = "UPDATE " . TB_PREFIX . "market set accept = 1 where id = $id";
        return mysql_query($q, $this->connection);
    }

    /***************************
     * Function to send resource to other village
     * Mode 0: Send
     * Mode 1: Cancel
     * References: Wood/ID, Clay, Iron, Crop, Mode
     ***************************/
    function sendResource($wood, $clay, $iron, $crop, $merchant)
    {
        $q = "INSERT INTO " . TB_PREFIX . "send (`wood`, `clay`, `iron`, `crop`, `merchant`) values ($wood,$clay,$iron,$crop,$merchant)";
        mysql_query($q, $this->connection);
        return mysql_insert_id($this->connection);
    }

    function sendResourceMORE($wood, $clay, $iron, $crop, $send)
    {
        $q = "INSERT INTO " . TB_PREFIX . "send (`wood`, `clay`, `iron`, `crop`, `send`) values ($wood,$clay,$iron,$crop,$send)";
        mysql_query($q, $this->connection);
        return mysql_insert_id($this->connection);
    }

    function removeSend($ref)
    {
        $q = "DELETE FROM " . TB_PREFIX . "send WHERE id = " . $ref;
        mysql_query($q, $this->connection);
    }

    /***************************
     * Function to get resources back if you delete offer
     * References: VillageRef (vref)
     * Made by: Dzoki
     ***************************/

    function getResourcesBack($vref, $gtype, $gamt)
    {
        //Xtype (1) = wood, (2) = clay, (3) = iron, (4) = crop
        if ($gtype == 1) {
            $q = "UPDATE " . TB_PREFIX . "vdata SET `wood` = `wood` + '$gamt' WHERE wref = $vref";
            return mysql_query($q, $this->connection);
        } else
            if ($gtype == 2) {
                $q = "UPDATE " . TB_PREFIX . "vdata SET `clay` = `clay` + '$gamt' WHERE wref = $vref";
                return mysql_query($q, $this->connection);
            } else
                if ($gtype == 3) {
                    $q = "UPDATE " . TB_PREFIX . "vdata SET `iron` = `iron` + '$gamt' WHERE wref = $vref";
                    return mysql_query($q, $this->connection);
                } else
                    if ($gtype == 4) {
                        $q = "UPDATE " . TB_PREFIX . "vdata SET `crop` = `crop` + '$gamt' WHERE wref = $vref";
                        return mysql_query($q, $this->connection);
                    }
    }

    /***************************
     * Function to get info about offered resources
     * References: VillageRef (vref)
     * Made by: Dzoki
     ***************************/

    function getMarketField($vref, $field)
    {
        $q = "SELECT $field FROM " . TB_PREFIX . "market where vref = '$vref'";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        return $dbarray[$field];
    }

    function removeAcceptedOffer($id)
    {
        $q = "DELETE FROM " . TB_PREFIX . "market where id = $id";
        $result = mysql_query($q, $this->connection);
        return mysql_fetch_assoc($result);
    }

    /***************************
     * Function to add market offer
     * Mode 0: Add
     * Mode 1: Cancel
     * References: Village, Give, Amt, Want, Amt, Time, Alliance, Mode
     ***************************/
    function addMarket($vid, $gtype, $gamt, $wtype, $wamt, $time, $alliance, $merchant, $mode)
    {
        if (!$mode) {
            $q = "INSERT INTO " . TB_PREFIX . "market values (0,$vid,$gtype,$gamt,$wtype,$wamt,0,$time,$alliance,$merchant)";
            mysql_query($q, $this->connection);
            return mysql_insert_id($this->connection);
        } else {
            $q = "DELETE FROM " . TB_PREFIX . "market where id = $gtype and vref = $vid";
            return mysql_query($q, $this->connection);
        }
    }

    /***************************
     * Function to get market offer
     * References: Village, Mode
     ***************************/
    function getMarket($vid, $mode)
    {
        $alliance = $this->getUserField($this->getVillageField($vid, "owner"), "alliance", 0);
        if (!$mode) {
            $q = "SELECT * FROM " . TB_PREFIX . "market where vref = $vid and accept = 0 ORDER BY id DESC";
        } else {
            $q = "SELECT * FROM " . TB_PREFIX . "market where vref != $vid and alliance = $alliance or vref != $vid and alliance = 0 and accept = 0 ORDER BY id DESC";
        }
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    /***************************
     * Function to get market offer
     * References: ID
     ***************************/
    function getMarketInfo($id)
    {
        $q = "SELECT `vref`,`gtype`,`wtype`,`merchant`,`wamt` FROM " . TB_PREFIX . "market where id = $id";
        $result = mysql_query($q, $this->connection);
        return mysql_fetch_assoc($result);
    }

    function setMovementProc($moveid)
    {
        $q = "UPDATE " . TB_PREFIX . "movement set proc = 1 where moveid = $moveid";
        return mysql_query($q, $this->connection);
    }

    /***************************
     * Function to retrieve used merchant
     * References: Village
     ***************************/
    function totalMerchantUsed($vid)
    {
        //$time = time();
        $q = "SELECT sum(" . TB_PREFIX . "send.merchant) from " . TB_PREFIX . "send, " . TB_PREFIX . "movement where " . TB_PREFIX . "movement.from = $vid and " . TB_PREFIX . "send.id = " . TB_PREFIX . "movement.ref and " . TB_PREFIX . "movement.proc = 0 and sort_type = 0";
        $result = mysql_query($q, $this->connection);
        $row = mysql_fetch_row($result);
        $q2 = "SELECT sum(" . TB_PREFIX . "send.merchant) from " . TB_PREFIX . "send, " . TB_PREFIX . "movement where " . TB_PREFIX . "movement.to = $vid and " . TB_PREFIX . "send.id = " . TB_PREFIX . "movement.ref and " . TB_PREFIX . "movement.proc = 0 and sort_type = 1";
        $result2 = mysql_query($q2, $this->connection);
        $row2 = mysql_fetch_row($result2);
        $q3 = "SELECT sum(merchant) from " . TB_PREFIX . "market where vref = $vid and accept = 0";
        $result3 = mysql_query($q3, $this->connection);
        $row3 = mysql_fetch_row($result3);
        return $row[0] + $row2[0] + $row3[0];
    }

    /***************************
     * Function to retrieve movement of village
     * Type 0: Send Resource
     * Type 1: Send Merchant
     * Type 2: Return Resource
     * Type 3: Attack
     * Type 4: Return
     * Type 5: Settler
     * Type 6: Bounty
     * Type 7: Reinf.
     * Type 9: Adventure
     * Mode 0: Send/Out
     * Mode 1: Recieve/In
     * References: Type, Village, Mode
     ***************************/
    function getMovement($type, $village, $mode)
    {
        //$time = time();
        if (!$mode) {
            $where = "`from`";
        } else {
            $where = "`to`";
        }
        switch ($type) {
            case 0:
                $q = "SELECT * FROM " . TB_PREFIX . "movement, " . TB_PREFIX . "send where " . TB_PREFIX . "movement." . $where . " = $village and " . TB_PREFIX . "movement.ref = " . TB_PREFIX . "send.id and " . TB_PREFIX . "movement.proc = 0 and " . TB_PREFIX . "movement.sort_type = 0";
                break;
            case 1:
                $q = "SELECT * FROM " . TB_PREFIX . "movement, " . TB_PREFIX . "send where " . TB_PREFIX . "movement." . $where . " = $village and " . TB_PREFIX . "movement.ref = " . TB_PREFIX . "send.id and " . TB_PREFIX . "movement.proc = 0 and " . TB_PREFIX . "movement.sort_type = 1";
                break;
            case 2:
                $q = "SELECT * FROM " . TB_PREFIX . "movement where " . TB_PREFIX . "movement." . $where . " = $village and " . TB_PREFIX . "movement.proc = 0 and " . TB_PREFIX . "movement.sort_type = 2";
                break;
            case 3:
                $q = "SELECT * FROM " . TB_PREFIX . "movement, " . TB_PREFIX . "attacks where " . TB_PREFIX . "movement." . $where . " = $village and " . TB_PREFIX . "movement.ref = " . TB_PREFIX . "attacks.id and " . TB_PREFIX . "movement.proc = 0 and " . TB_PREFIX . "movement.sort_type = 3 ORDER BY endtime ASC";
                break;
            case 4:
                $q = "SELECT * FROM " . TB_PREFIX . "movement, " . TB_PREFIX . "attacks where " . TB_PREFIX . "movement." . $where . " = $village and " . TB_PREFIX . "movement.ref = " . TB_PREFIX . "attacks.id and " . TB_PREFIX . "movement.proc = 0 and " . TB_PREFIX . "movement.sort_type = 4 ORDER BY endtime ASC";
                break;
            case 5:
                $q = "SELECT * FROM " . TB_PREFIX . "movement where " . TB_PREFIX . "movement." . $where . " = $village and sort_type = 5 and proc = 0";
                break;
            case 6:
                $q = "SELECT * FROM " . TB_PREFIX . "movement," . TB_PREFIX . "odata, " . TB_PREFIX . "attacks where " . TB_PREFIX . "odata.conqured = $village and " . TB_PREFIX . "movement.to = " . TB_PREFIX . "odata.wref and " . TB_PREFIX . "movement.ref = " . TB_PREFIX . "attacks.id and " . TB_PREFIX . "movement.proc = 0 and " . TB_PREFIX . "movement.sort_type = 3 ORDER BY endtime ASC";
                break;
            case 9:
                $q = "SELECT * FROM " . TB_PREFIX . "movement where " . TB_PREFIX . "movement." . $where . " = $village and sort_type = 9 and proc = 0";
                break;
            case 34:
                $q = "SELECT * FROM " . TB_PREFIX . "movement, " . TB_PREFIX . "attacks where (" . TB_PREFIX . "movement." . $where . " = $village and " . TB_PREFIX . "movement.ref = " . TB_PREFIX . "attacks.id and " . TB_PREFIX . "movement.proc = 0) and (" . TB_PREFIX . "movement.sort_type = 3 or  " . TB_PREFIX . "movement.sort_type = 4) ORDER BY endtime ASC";
                break;
        }
        $result = mysql_query($q, $this->connection);
        $array = $this->mysql_fetch_all($result);
        return $array;
    }

    function getMovementById($id)
    {
        $q = "SELECT `starttime`,`to`,`from` FROM " . TB_PREFIX . "movement where moveid = " . $id;
        $result = mysql_query($q, $this->connection);
        $array = $this->mysql_fetch_all($result);
        if (count($array) > 0) {
            return $array[0];
        } else {
            return array();
        }
    }

    function cancelMovement($id, $newfrom, $newto)
    {
        $refstr = '';
        $q = "SELECT ref FROM " . TB_PREFIX . "movement WHERE moveid=$id";
        $amove = $this->query_return($q);
        if (count($amove) > 0) $mov = $amove[0];
        if ($mov['ref'] == 0) {
            $ref = $this->addAttack($newto, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0);
            $refstr = ',`ref`=' . $ref;
        }
        $q = "UPDATE " . TB_PREFIX . "movement SET `from`=" . $newfrom . ", `to`=" . $newto . ", `sort_type`=4, `endtime`=(" . (2 * time()) . "-`starttime`),`starttime`=" . time() . " " . $refstr . " WHERE moveid = " . $id;
        $this->query($q);
    }

    function getAdvMovement($village)
    {
        $where = "from";
        $q = "SELECT `moveid` FROM " . TB_PREFIX . "movement where " . TB_PREFIX . "movement." . $where . " = $village and sort_type = 9";
        $result = mysql_query($q, $this->connection);
        $array = $this->mysql_fetch_all($result);
        return $array;
    }

    function getCompletedAdvMovement($village)
    {
        $where = "from";
        $q = "SELECT `moveid` FROM " . TB_PREFIX . "movement where " . TB_PREFIX . "movement." . $where . " = $village and sort_type = 9 and proc = 1";
        $result = mysql_query($q, $this->connection);
        $array = $this->mysql_fetch_all($result);
        return $array;
    }

    function addA2b($ckey, $timestamp, $to, $t1, $t2, $t3, $t4, $t5, $t6, $t7, $t8, $t9, $t10, $t11, $type)
    {
        $q = "INSERT INTO " . TB_PREFIX . "a2b (ckey,time_check,to_vid,u1,u2,u3,u4,u5,u6,u7,u8,u9,u10,u11,type) VALUES ('$ckey', '$timestamp', '$to', '$t1', '$t2', '$t3', '$t4', '$t5', '$t6', '$t7', '$t8', '$t9', '$t10', '$t11', '$type')";
        mysql_query($q, $this->connection);
        return mysql_insert_id($this->connection);
    }

    function getA2b($ckey, $check)
    {
        $q = "SELECT * from " . TB_PREFIX . "a2b where ckey = '" . $ckey . "' AND time_check = '" . $check . "'";
        $result = mysql_query($q, $this->connection);
        if ($result) {
            return mysql_fetch_assoc($result);
        } else {
            return false;
        }
    }

    function removeA2b($ckey, $check)
    {
        $q = "DELETE FROM " . TB_PREFIX . "a2b where ckey = '" . $ckey . "' AND time_check = '" . $check . "'";
        $result = mysql_query($q, $this->connection);
        if ($result) {
            return mysql_fetch_assoc($result);
        } else {
            return false;
        }
    }

    function addMovement($type, $from, $to, $ref, $data, $endtime)
    {
        $q = "INSERT INTO " . TB_PREFIX . "movement values (0,$type,$from,$to,$ref,'$data'," . time() . ",$endtime,0)";
        return mysql_query($q, $this->connection);
    }

    function addAttack($vid, $t1, $t2, $t3, $t4, $t5, $t6, $t7, $t8, $t9, $t10, $t11, $type, $ctar1, $ctar2, $spy)
    {
        $q = "INSERT INTO " . TB_PREFIX . "attacks values (0,$vid,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$t10,$t11,$type,$ctar1,$ctar2,$spy)";
        mysql_query($q, $this->connection);
        return mysql_insert_id($this->connection);
    }

    function modifyAttack($aid, $unit, $amt)
    {
        $unit = 't' . $unit;
        $q = "SELECT $unit FROM " . TB_PREFIX . "attacks WHERE id = " . $aid;
        $result = mysql_query($q, $this->connection);
        $result = $this->mysql_fetch_all($result);
        $row = $result[0];
        $amt = min($row[$unit], $amt);
        $q = "UPDATE " . TB_PREFIX . "attacks SET `$unit` = `$unit` - $amt WHERE id = $aid";
        return mysql_query($q, $this->connection);
    }

    function getRanking()
    {
        $q = "SELECT id,username,alliance,ap,apall,dp,dpall,access FROM " . TB_PREFIX . "users WHERE tribe<=3 AND access<" . (INCLUDE_ADMIN ? "10" : "8");
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function getBuildList($type, $wid = 0)
    {
        $q = "SELECT `id` FROM " . TB_PREFIX . "bdata WHERE TRUE "
            . ($type ? " AND type = $type " : '')
            . ($wid ? " AND wid = $wid " : '');
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function getVRanking()
    {
        $q = "SELECT v.wref,v.name,v.owner,v.pop FROM " . TB_PREFIX . "vdata AS v," . TB_PREFIX . "users AS u WHERE v.owner=u.id AND u.tribe<=3 AND v.wref != '' AND u.access<" . (INCLUDE_ADMIN ? "10" : "8");
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function getARanking()
    {
        $q = "SELECT id,name,tag FROM " . TB_PREFIX . "alidata where id != ''";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function getHeroRanking($limit = '')
    {
        $q = "SELECT `uid`,`level`,`experience` FROM " . TB_PREFIX . "hero ORDER BY `experience` DESC $limit";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function getAllMember($aid)
    {
        $q = "SELECT `id`,`username`,`timestamp` FROM " . TB_PREFIX . "users where alliance = $aid order  by (SELECT sum(pop) FROM " . TB_PREFIX . "vdata WHERE owner =  " . TB_PREFIX . "users.id) desc";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function addUnits($vid)
    {
        $q = "INSERT into " . TB_PREFIX . "units (vref) values ($vid)";
        return mysql_query($q, $this->connection);
    }

    function getUnit($vid)
    {
        $q = "SELECT * FROM " . TB_PREFIX . "units where vref = " . $vid . "";
        $result = mysql_query($q, $this->connection);
        if (!empty($result)) {
            return mysql_fetch_assoc($result);
        } else {
            return NULL;
        }
    }

    function getHUnit($vid)
    {
        $q = "SELECT hero FROM " . TB_PREFIX . "units where vref = " . $vid . "";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        if ($dbarray['hero'] != 0) {
            return true;
        } else {
            return false;
        }
    }

    function getHero($uid = 0, $id = 0, $dead = 2)
    {
        $q = "SELECT * FROM " . TB_PREFIX . "hero WHERE TRUE "
            . ($uid ? " AND uid=$uid " : "")
            . ($id ? " AND id=$id " : "")
            . ($dead == 2 ? "" : " AND dead=$dead ")
            . " LIMIT 1";
        $result = mysql_query($q, $this->connection);
        return mysql_fetch_array($result);
    }

    function modifyHero($uid = 0, $id = 0, $column, $value, $mode = 0)
    {
        $cmd = '';
        switch ($mode) {
            case 0:
                $cmd .= " $column = $value ";
                break;
            case 1:
                $cmd .= " $column = $column + $value ";
                break;
            case 2:
                $cmd .= " $column = $column - $value ";
                break;
            case 3:
                $cmd .= " $column = $column * $value ";
                break;
            case 4:
                $cmd .= " $column = $column / $value ";
                break;
        }

        switch ($column) {
            case 'r0':
            case 'r1':
            case 'r2':
            case 'r3':
            case 'r4':
                $cmd .= " ,rc = 1 ";
                break;
        }
        $q = "UPDATE " . TB_PREFIX . "hero SET $cmd WHERE TRUE "
            . ($uid ? " AND uid = $uid " : '')
            . ($id ? " AND heroid = $id " : '');
        return mysql_query($q, $this->connection);
    }

    function addTech($vid)
    {
        $q = "INSERT into " . TB_PREFIX . "tdata (vref) values ($vid)";
        return mysql_query($q, $this->connection);
    }

    function clearTech($vref)
    {
        $q = "DELETE from " . TB_PREFIX . "tdata WHERE vref = $vref";
        mysql_query($q, $this->connection);
        return $this->addTech($vref);
    }

    function addABTech($vid)
    {
        $q = "INSERT into " . TB_PREFIX . "abdata (vref) values ($vid)";
        return mysql_query($q, $this->connection);
    }

    function clearABTech($vref)
    {
        $q = "DELETE FROM " . TB_PREFIX . "abdata WHERE vref = $vref";
        mysql_query($q, $this->connection);
        return $this->addABTech($vref);
    }

    function getABTech($vid)
    {
        $q = "SELECT `vref`,`a1`,`a2`,`a3`,`a4`,`a5`,`a6`,`a7`,`a8`,`a9`,`a10`,`b1`,`b2`,`b3`,`b4`,`b5`,`b6`,`b7`,`b8`,`b9`,`b10` FROM " . TB_PREFIX . "abdata where vref = $vid";
		$result = mysql_query($q, $this->connection);
        return mysql_fetch_assoc($result);
    }

    function addResearch($vid, $tech, $time)
    {
        $q = "INSERT into " . TB_PREFIX . "research values (0,$vid,'$tech',$time)";
        return mysql_query($q, $this->connection);
    }

    function getResearching($vid)
    {
        $q = "SELECT * FROM " . TB_PREFIX . "research where vref = $vid";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function checkIfResearched($vref, $unit)
    {
        $q = "SELECT $unit FROM " . TB_PREFIX . "tdata WHERE vref = $vref";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        return $dbarray[$unit];
    }

    function getTech($vid)
    {
        $q = "SELECT * from " . TB_PREFIX . "tdata where vref = $vid";
        $result = mysql_query($q, $this->connection);
        return mysql_fetch_assoc($result);
    }

    function getTraining($vid)
    {
        $q = "SELECT `amt`,`unit`,`endat`,`commence`,`id`,`vref`,`pop`,`timestamp`,`eachtime` FROM " . TB_PREFIX . "training where vref = $vid ORDER BY id";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function trainUnit($vid, $unit, $amt, $pop, $each, $commence, $mode)
    {
        global $technology;

        if (!$mode) {
            $barracks = array(1, 2, 3, 11, 12, 13, 14, 21, 22, 31, 32, 33, 34, 41, 42, 43, 44);
            $greatbarracks = array(61, 62, 63, 71, 72, 73, 84, 81, 82, 91, 92, 93, 94, 101, 102, 103, 104);
            $stables = array(4, 5, 6, 15, 16, 23, 24, 25, 26, 35, 36, 45, 46);
            $greatstables = array(64, 65, 66, 75, 76, 83, 84, 85, 86, 95, 96, 105, 106);
            $workshop = array(7, 8, 17, 18, 27, 28, 37, 38, 47, 48);
            $greatworkshop = array(67, 68, 77, 78, 87, 88, 97, 98, 107, 108);
            $residence = array(9, 10, 19, 20, 29, 30, 39, 40, 49, 50);
            $trap = array(199);

            if (in_array($unit, $barracks)) {
                $queued = $technology->getTrainingList(1);
            } elseif (in_array($unit, $stables)) {
                $queued = $technology->getTrainingList(2);
            } elseif (in_array($unit, $workshop)) {
                $queued = $technology->getTrainingList(3);
            } elseif (in_array($unit, $residence)) {
                $queued = $technology->getTrainingList(4);
            } elseif (in_array($unit, $greatbarracks)) {
                $queued = $technology->getTrainingList(5);
            } elseif (in_array($unit, $greatstables)) {
                $queued = $technology->getTrainingList(6);
            } elseif (in_array($unit, $greatworkshop)) {
                $queued = $technology->getTrainingList(7);
            } elseif (in_array($unit, $trap)) {
                $queued = $technology->getTrainingList(8);
            }
            $timestamp = time();

            if ($queued[count($queued) - 1]['unit'] == $unit) {
                $endat = $each * $amt / 1000;
                $q = "UPDATE " . TB_PREFIX . "training SET amt = amt + $amt, timestamp = $timestamp,endat = endat + $endat WHERE id = " . $queued[count($queued) - 1]['id'] . "";
            } else {
                $endat = $timestamp + ($each * $amt / 1000);
                $q = "INSERT INTO " . TB_PREFIX . "training values (0,$vid,$unit,$amt,$pop,$timestamp,$each,$commence,$endat)";
            }

        } else {
            $q = "DELETE FROM " . TB_PREFIX . "training where id = $vid";
        }
        return mysql_query($q, $this->connection);
    }

    function removeZeroTrain()
    {
        $q = "DELETE FROM " . TB_PREFIX . "training where `unit`<>0 AND amt <= 0 ";
        return mysql_query($q, $this->connection);
    }

    function getHeroTrain($vid)
    {
        $q = "SELECT `id`,`eachtime` from " . TB_PREFIX . "training where vref = $vid and unit = 0";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        if (empty($result)) {
            return false;
        } else {
            return $dbarray;
        }
    }

    function trainHero($vid, $each, $endat, $mode)
    {
        if (!$mode) {
            $time = time();
            $q = "INSERT INTO " . TB_PREFIX . "training values (0,$vid,0,1,6,$time,$each,$time,$endat)";
        } else {
            $q = "DELETE FROM " . TB_PREFIX . "training where id = $vid";
        }
        return mysql_query($q, $this->connection);
    }

    function updateTraining($id, $trained)
    {
        $time = time();
        $q = "UPDATE " . TB_PREFIX . "training set amt = GREATEST(amt - $trained,0), timestamp = $time where id = $id";
        return mysql_query($q, $this->connection);
    }

    function modifyUnit($vref, $unit, $amt, $mode)
    {
        if ($unit == 230) {
            $unit = 30;
        }
        if ($unit == 231) {
            $unit = 31;
        }
        if ($unit == 120) {
            $unit = 20;
        }
        if ($unit == 121) {
            $unit = 21;
        }
        if ($unit == 'hero') {
            $unit = 'hero';
        } else {
            $unit = 'u' . $unit;
        }
        switch ($mode) {
            case 0:
                $q = "SELECT $unit FROM " . TB_PREFIX . "units WHERE vref = $vref";
                $result = mysql_query($q, $this->connection);
                $row = mysql_fetch_assoc($result);
                $amt = min($row[$unit], $amt);
                $q = "UPDATE " . TB_PREFIX . "units set $unit = ($unit - $amt) where vref = $vref";
                break;
            case 1:
                $q = "UPDATE " . TB_PREFIX . "units set $unit = $unit + $amt where vref = $vref";
                break;
            case 2:
                $q = "UPDATE " . TB_PREFIX . "units set $unit = $amt where vref = $vref";
                break;
        }
        return mysql_query($q, $this->connection);
    }

    function getFilledTrapCount($vref)
    {
        $result = 0;
        $q = "SELECT * FROM " . TB_PREFIX . "trapped WHERE `vref` = $vref";
        $trapped = $this->query_return($q);
        if (count($trapped) > 0) {
            foreach ($trapped as $k => $v) {
                for ($i = 1; $i <= 50; $i++) {
                    if ($v['u' . $i] > 0) $result += $v['u' . $i];
                }
                if ($v['hero'] > 0) $result += 1;
            }
        }
        return $result;
    }

    function getTrapped($id)
    {
        $q = "SELECT * FROM " . TB_PREFIX . "trapped WHERE `id` = $id";
        $result = mysql_query($q);
        return mysql_fetch_assoc($result);
    }

    function hasTrapped($vref, $from)
    {
        $q = "SELECT id FROM " . TB_PREFIX . "trapped WHERE `vref` = $vref AND `from` = $from";
        $result = mysql_query($q, $this->connection);
        $result = mysql_fetch_assoc($result);
        if (isset($result['id'])) {
            return $result['id'];
        } else {
            return false;
        }
    }


    function getTrappedIn($vref)
    {
        $q = "SELECT * from " . TB_PREFIX . "trapped where `vref` = '$vref'";
        return $this->query_return($q);
    }

    function getTrappedFrom($from)
    {
        $q = "SELECT * from " . TB_PREFIX . "trapped where `from` = '$from'";
        return $this->query_return($q);
    }

    function addTrapped($vref, $from)
    {
        $id = $this->hasTrapped($vref, $from);
        if (!$id) {
            $q = "INSERT into " . TB_PREFIX . "trapped (vref,`from`) values (" . $vref . "," . $from . ")";
            mysql_query($q, $this->connection);
            $id = mysql_insert_id($this->connection);
        }
        return $id;
    }

    function modifyTrapped($id, $unit, $amt, $mode)
    {
        if (!$mode) {
            $q = "SELECT $unit FROM " . TB_PREFIX . "trapped WHERE id = $id";
            $result = mysql_query($q, $this->connection);
            $result = $this->mysql_fetch_all($result);
            $row = $result[0];
            $amt = min($row['u' . $unit], $amt);
            $q = "UPDATE " . TB_PREFIX . "trapped set $unit = $unit - $amt where id = $id";
        } else {
            $q = "UPDATE " . TB_PREFIX . "trapped set $unit = $unit + $amt where id = $id";
        }
        mysql_query($q, $this->connection);
    }

    function removeTrapped($id)
    {
        $q = "DELETE FROM " . TB_PREFIX . "trapped WHERE `id`=$id";
        mysql_query($q, $this->connection);
    }

    function removeAnimals($id)
    {
        $q = "DELETE FROM " . TB_PREFIX . "enforcement WHERE `id`=$id";
        mysql_query($q, $this->connection);
    }

    function checkEnforce($vid, $from)
    {
        $q = "SELECT `id` from " . TB_PREFIX . "enforcement where `from` = $from and vref = $vid";
        $result = $this->query_return($q);
        if (count($result)) {
            return $result[0];
        } else {
            return false;
        }
    }

    function addEnforce($data)
    {
        $q = "INSERT into " . TB_PREFIX . "enforcement (vref,`from`) values (" . $data['to'] . "," . $data['from'] . ")";
        mysql_query($q, $this->connection);
        $id = mysql_insert_id($this->connection);
        $isoasis = $this->isVillageOases($data['from']);
        if ($isoasis) {
            $fromVillage = $this->getOMInfo($data['from']);
        } else {
            $fromVillage = $this->getMInfo($data['from']);
        }
        $fromTribe = $this->getUserField($fromVillage["owner"], "tribe", 0);
        $start = ($fromTribe - 1) * 10 + 1;
        $end = ($fromTribe * 10);
        //add unit
        $j = '1';
        for ($i = $start; $i <= $end; $i++) {
            $this->modifyEnforce($id, $i, $data['t' . $j . ''], 1);
            $j++;
        }
        return mysql_insert_id($this->connection);
    }

    function addHeroEnforce($data)
    {
        $q = "INSERT into " . TB_PREFIX . "enforcement (`vref`,`from`,`hero`) values (" . $data['to'] . "," . $data['from'] . ",1)";
        mysql_query($q, $this->connection);
    }


    function modifyEnforce($id, $unit, $amt, $mode)
    {
        if ($unit == 'hero') {
            $unit = 'hero';
        } else {
            $unit = 'u' . $unit;
        }
        if (!$mode) {
            $q = "SELECT $unit FROM " . TB_PREFIX . "enforcement WHERE id = $id";
            $result = $this->query_return($q);
            if (isset($result) && !empty($result) && count($result) > 0) {
                $row = $result[0];
                $amt = min($row[$unit], $amt);
                $q = "UPDATE " . TB_PREFIX . "enforcement set $unit = $unit - $amt where id = $id";
                mysql_query($q, $this->connection);
            }
        } else {
            $q = "UPDATE " . TB_PREFIX . "enforcement set $unit = $unit + $amt where id = $id";
            mysql_query($q, $this->connection);
        }
    }

    function getEnforceArray($id, $mode)
    {
        if (!$mode) {
            $q = "SELECT * from " . TB_PREFIX . "enforcement where id = $id";
        } else {
            $q = "SELECT * from " . TB_PREFIX . "enforcement where `from` = $id";
        }
        $result = mysql_query($q, $this->connection);
        return mysql_fetch_assoc($result);
    }

    function getEnforceVillage($id, $mode)
    {
        if (!$mode) {
            $q = "SELECT * from " . TB_PREFIX . "enforcement where `vref` = '$id'";
        } else {
            $q = "SELECT * from " . TB_PREFIX . "enforcement where `from` = '$id'";
        }
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function getOasesEnforce($id)
    {
        $oasisowned = $this->getOasis($id);
        if (!empty($oasisowned) && count($oasisowned) > 0) {
            $inos = '(';
            foreach ($oasisowned as $oo) $inos .= $oo['wref'] . ',';
            $inos = substr($inos, 0, strlen($inos) - 1);
            $inos .= ')';
            $q = "SELECT * FROM " . TB_PREFIX . "enforcement WHERE `from` = '$id' AND `vref` IN " . $inos;
            $result = mysql_query($q, $this->connection);
            return $this->mysql_fetch_all($result);
        } else return null;
    }

    function getVillageMovement($id)
    {
        $vinfo = $this->getVillage($id);
        if (isset($vinfo['owner'])) {
            $vtribe = $this->getUserField($vinfo['owner'], "tribe", 0);
            $movingunits = array();
            $outgoingarray = $this->getMovement(3, $id, 0);
            for ($i = 1; $i <= 10; $i++) $movingunits['u' . (($vtribe - 1) * 10 + $i)] = 0;
            $movingunits['hero'] = 0;
            if (!empty($outgoingarray)) {
                foreach ($outgoingarray as $out) {
                    for ($i = 1; $i <= 10; $i++) {
                        $movingunits['u' . (($vtribe - 1) * 10 + $i)] += $out['t' . $i];
                    }
                    $movingunits['hero'] += $out['t11'];
                }
            }
            $returningarray = $this->getMovement(4, $id, 1);
            if (!empty($returningarray)) {
                foreach ($returningarray as $ret) {
                    if ($ret['attack_type'] != 1) {
                        for ($i = 1; $i <= 10; $i++) {
                            $movingunits['u' . (($vtribe - 1) * 10 + $i)] += $ret['t' . $i];
                        }
                        $movingunits['hero'] += $ret['t11'];
                    }
                }
            }
            $settlerarray = $this->getMovement(5, $id, 0);
            if (!empty($settlerarray)) {
                $movingunits['u' . ($vtribe * 10)] += 3 * count($settlerarray);
            }
            $advarray = $this->getMovement(9, $id, 0);
            if (!empty($advarray)) {
                $movingunits['hero'] += 1;
            }
            return $movingunits;
        } else {
            return array();
        }
    }

    function getVillageMovementArray($id)
    {
        $movingarray = array();
        $outgoingarray = $this->getMovement(3, $id, 0);
        if (!empty($outgoingarray)) $movingarray = array_merge($movingarray, $outgoingarray);
        $returningarray = $this->getMovement(4, $id, 1);
        if (!empty($returningarray)) $movingarray = array_merge($movingarray, $returningarray);
        return $movingarray;
    }

    function getWW()
    {
        $q = "SELECT vref FROM " . TB_PREFIX . "fdata WHERE f99t = 40";
        $result = mysql_query($q, $this->connection);
        if (mysql_num_rows($result)) {
            return true;
        } else {
            return false;
        }
    }

    /***************************
     * Function to get world wonder level!
     * Made by: Dzoki
     ***************************/

    function getWWLevel($vref)
    {
        $q = "SELECT f99 FROM " . TB_PREFIX . "fdata WHERE vref = $vref";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        return $dbarray['f99'];
    }

    /***************************
     * Function to get world wonder owner ID!
     * Made by: Dzoki
     ***************************/

    function getWWOwnerID($vref)
    {
        $q = "SELECT owner FROM " . TB_PREFIX . "vdata WHERE wref = $vref LIMIT 1";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        return $dbarray['owner'];
    }

    /***************************
     * Function to get user alliance name!
     * Made by: Dzoki
     ***************************/

    function getUserAllianceID($id)
    {
        $q = "SELECT alliance FROM " . TB_PREFIX . "users where id = $id LIMIT 1";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        return $dbarray['alliance'];
    }

    /***************************
     * Function to get WW name
     * Made by: Dzoki
     ***************************/

    function getWWName($vref)
    {
        $q = "SELECT wwname FROM " . TB_PREFIX . "fdata WHERE vref = $vref";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        return $dbarray['wwname'];
    }

    /***************************
     * Function to change WW name
     * Made by: Dzoki
     ***************************/

    function submitWWname($vref, $name)
    {
        $q = "UPDATE " . TB_PREFIX . "fdata SET `wwname` = '$name' WHERE " . TB_PREFIX . "fdata.`vref` = $vref";
        return mysql_query($q, $this->connection);
    }

    function modifyCommence($id, $commence = 0)
    {
        if ($commence == 0) $commence = time();
        $q = "UPDATE " . TB_PREFIX . "training set commence = $commence WHERE id=$id";

        return mysql_query($q, $this->connection);
    }

    function getTrainingList()
    {
        $q = "SELECT `id`,`vref`,`unit`,`eachtime`,`endat`,`commence`,`amt` FROM " . TB_PREFIX . "training where amt != 0 LIMIT 500";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function getNeedDelete()
    {
        $time = time();
        $q = "SELECT uid FROM " . TB_PREFIX . "deleting where timestamp <= $time";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function countUser()
    {
        $q = "SELECT count(id) FROM " . TB_PREFIX . "users where id != 0";
        $result = mysql_query($q, $this->connection);
        $row = mysql_fetch_row($result);
        return $row[0];
    }

    function countAlli()
    {
        $q = "SELECT count(id) FROM " . TB_PREFIX . "alidata where id != 0";
        $result = mysql_query($q, $this->connection);
        $row = mysql_fetch_row($result);
        return $row[0];
    }

    /***************************
     * Function to process MYSQLi->fetch_all (Only exist in MYSQL)
     * References: Result
     ***************************/
    function mysql_fetch_all($result)
    {
        $all = array();
        if ($result) {
            while ($row = mysql_fetch_assoc($result)) {
                $all[] = $row;
            }
            return $all;
        }
    }

    function query_return($q)
    {
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    /***************************
     * Function to do free query
     * References: Query
     ***************************/
    function query($query)
    {
        return mysql_query($query, $this->connection);
    }

    function RemoveXSS($val)
    {
        return htmlspecialchars($val, ENT_QUOTES);
    }

    //MARKET FIXES
    function getWoodAvailable($wref)
    {
        $q = "SELECT wood FROM " . TB_PREFIX . "vdata WHERE wref = $wref LIMIT 1";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        return $dbarray['wood'];
    }

    function getClayAvailable($wref)
    {
        $q = "SELECT clay FROM " . TB_PREFIX . "vdata WHERE wref = $wref LIMIT 1";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        return $dbarray['clay'];
    }

    function getIronAvailable($wref)
    {
        $q = "SELECT iron FROM " . TB_PREFIX . "vdata WHERE wref = $wref LIMIT 1";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        return $dbarray['iron'];
    }

    function getCropAvailable($wref)
    {
        $q = "SELECT crop FROM " . TB_PREFIX . "vdata WHERE wref = $wref LIMIT 1";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        return $dbarray['crop'];
    }

    function poulateOasisdata()
    {
        $q2 = "SELECT id FROM " . TB_PREFIX . "wdata where oasistype != 0";
        $result2 = mysql_query($q2, $this->connection);
        while ($row = mysql_fetch_array($result2)) {
            $wid = $row['id'];
            $time = time();
            $t1 = 750 * SPEED / 10;
            $t2 = 750 * SPEED / 10;
            $t3 = 750 * SPEED / 10;

            $t4 = 800 * SPEED / 10;
            $t5 = 750 * SPEED / 10;
            $t6 = 800 * SPEED / 10;

            $tt = "$t1,$t2,$t3,0,0,0,$t4,$t5,0,$t6,$time,$time,$time";
            $basearray = $this->getOMInfo($wid);
            //We switch type of oasis and instert record with apropriate infomation.
            $q = "INSERT into " . TB_PREFIX . "odata VALUES ('" . $basearray['id'] . "'," . $basearray['oasistype'] . ",0," . $tt . ",100,3,'Unoccupied oasis')";
            mysql_query($q, $this->connection);
        }
    }

    public function getAvailableExpansionTraining()
    {
        global $building, $session, $technology, $village;
        $q = "SELECT (IF(exp1=0,1,0)+IF(exp2=0,1,0)+IF(exp3=0,1,0)) FROM " . TB_PREFIX . "vdata WHERE wref = $village->wid";
        $result = mysql_query($q, $this->connection);
        $row = mysql_fetch_row($result);
        $maxslots = $row[0];
        $residence = $building->getTypeLevel(25);
        $palace = $building->getTypeLevel(26);
        if ($residence > 0) {
            $maxslots -= (3 - floor($residence / 10));
        }
        if ($palace > 0) {
            $maxslots -= (3 - floor(($palace - 5) / 5));
        }

        $q = "SELECT (u10+u20+u30) FROM " . TB_PREFIX . "units WHERE vref = $village->wid";
        $result = mysql_query($q, $this->connection);
        $row = mysql_fetch_row($result);
        $settlers = $row[0];
        $q = "SELECT (u9+u19+u29) FROM " . TB_PREFIX . "units WHERE vref = $village->wid";
        $result = mysql_query($q, $this->connection);
        $row = mysql_fetch_row($result);
        $chiefs = $row[0];

        $settlers += 3 * count($this->getMovement(5, $village->wid, 0));
        $current_movement = $this->getMovement(3, $village->wid, 0);
        if (!empty($current_movement)) {
            foreach ($current_movement as $build) {
                $settlers += $build['t10'];
                $chiefs += $build['t9'];
            }
        }
        $current_movement = $this->getMovement(3, $village->wid, 1);
        if (!empty($current_movement)) {
            foreach ($current_movement as $build) {
                $settlers += $build['t10'];
                $chiefs += $build['t9'];
            }
        }
        $current_movement = $this->getMovement(4, $village->wid, 0);
        if (!empty($current_movement)) {
            foreach ($current_movement as $build) {
                $settlers += $build['t10'];
                $chiefs += $build['t9'];
            }
        }
        $current_movement = $this->getMovement(4, $village->wid, 1);
        if (!empty($current_movement)) {
            foreach ($current_movement as $build) {
                $settlers += $build['t10'];
                $chiefs += $build['t9'];
            }
        }
        $q = "SELECT (u10+u20+u30) FROM " . TB_PREFIX . "enforcement WHERE `from` = " . $village->wid;
        $result = mysql_query($q, $this->connection);
        $row = mysql_fetch_row($result);
        if (!empty($row)) {
            foreach ($row as $reinf) {
                $settlers += $reinf[0];
            }
        }
        $q = "SELECT (u10+u20+u30) FROM " . TB_PREFIX . "trapped WHERE `from` = " . $village->wid;
        $result = mysql_query($q, $this->connection);
        $row = mysql_fetch_row($result);
        if (!empty($row)) {
            foreach ($row as $trapped) {
                $settlers += $trapped[0];
            }
        }
        $q = "SELECT (u9+u19+u29) FROM " . TB_PREFIX . "enforcement WHERE `from` = " . $village->wid;
        $result = mysql_query($q, $this->connection);
        $row = mysql_fetch_row($result);
        if (!empty($row)) {
            foreach ($row as $reinf) {
                $chiefs += $reinf[0];
            }
        }
        $q = "SELECT (u9+u19+u29) FROM " . TB_PREFIX . "trapped WHERE `from` = " . $village->wid;
        $result = mysql_query($q, $this->connection);
        $row = mysql_fetch_row($result);
        if (!empty($row)) {
            foreach ($row as $trapped) {
                $chiefs += $trapped[0];
            }
        }
        $trainlist = $technology->getTrainingList(4);
        if (!empty($trainlist)) {
            foreach ($trainlist as $train) {
                if ($train['unit'] % 10 == 0) {
                    $settlers += $train['amt'];
                }
                if ($train['unit'] % 10 == 9) {
                    $chiefs += $train['amt'];
                }
            }
        }
        // trapped settlers/chiefs calculation required

        $settlerslots = $maxslots * 3 - $settlers - $chiefs * 3;
        $chiefslots = $maxslots - $chiefs - floor(($settlers + 2) / 3);

        if (!$technology->getTech(($session->tribe - 1) * 10 + 9)) {
            $chiefslots = 0;
        }
        $slots = array("chiefs" => $chiefslots, "settlers" => $settlerslots);
        return $slots;
    }

    function addArtefact($vref, $owner, $type, $size, $name, $desc, $effecttype, $effect, $aoe, $img)
    {
        $q = "INSERT INTO `" . TB_PREFIX . "artefacts` (`vref`, `owner`, `type`, `size`, `conquered`, `name`, `desc`, `effecttype`, `effect`, `aoe`, `img`) VALUES ('$vref', '$owner', '$type', '$size', '" . time() . "', '$name', '$desc', '$effecttype', '$effect', '$aoe', '$img')";
        return mysql_query($q, $this->connection);
    }

    function getOwnArtefactInfo($vref)
    {
        $q = "SELECT * FROM " . TB_PREFIX . "artefacts WHERE vref = $vref";
        return $this->query_return($q);
    }

    function getArtefactInfo($sizes)
    {
        if (count($sizes) != 0) {
            $sizestr = ' AND ( FALSE ';
            foreach ($sizes as $s) {
                $sizestr .= ' OR `' . TB_PREFIX . 'artefacts`.`size` = ' . $s . ' ';
            }
            $sizestr .= ' ) ';
        } else {
            $sizestr = '';
        }
        $q = "SELECT * FROM " . TB_PREFIX . "artefacts WHERE true " . $sizestr . ' ORDER BY type';
        return $this->query_return($q);
    }

    function getArtefactInfoByDistance($coor, $distance, $sizes)
    {
        if (count($sizes) != 0) {
            $sizestr = ' AND ( FALSE ';
            foreach ($sizes as $s) {
                $sizestr .= ' OR ' . TB_PREFIX . 'artefacts.size = ' . $s . ' ';
            }
            $sizestr .= ' ) ';
        } else {
            $sizestr = '';
        }
        $q = "SELECT *,"
            . " (ROUND(SQRT(POW(LEAST(ABS(" . $coor['x'] . " - " . TB_PREFIX . "wdata.x), ABS(" . $coor['max'] . " - ABS(" . $coor['x'] . " - " . TB_PREFIX . "wdata.x))), 2) + POW(LEAST(ABS(" . $coor['y'] . " - " . TB_PREFIX . "wdata.y), ABS(" . $coor['max'] . " - ABS(" . $coor['y'] . " - " . TB_PREFIX . "wdata.y))), 2)),3)) AS distance "
            . " FROM " . TB_PREFIX . "wdata, " . TB_PREFIX . "artefacts WHERE " . TB_PREFIX . "artefacts.vref = " . TB_PREFIX . "wdata.id"
            . " AND (ROUND(SQRT(POW(LEAST(ABS(" . $coor['x'] . " - " . TB_PREFIX . "wdata.x), ABS(" . $coor['max'] . " - ABS(" . $coor['x'] . " - " . TB_PREFIX . "wdata.x))), 2) + POW(LEAST(ABS(" . $coor['y'] . " - " . TB_PREFIX . "wdata.y), ABS(" . $coor['max'] . " - ABS(" . $coor['y'] . " - " . TB_PREFIX . "wdata.y))), 2)),3)) <= " . $distance
            . $sizestr
            . ' ORDER BY distance';
        return $this->query_return($q);
    }

    function arteIsMine($id, $newvref, $newowner)
    {
        $q = "UPDATE " . TB_PREFIX . "artefacts SET `owner` = " . $newowner . " WHERE id = " . $id;
        $this->query($q);
        $this->captureArtefact($id, $newvref, $newowner);
    }

    function captureArtefact($id, $newvref, $newowner)
    {
        // get the artefact
        $currentArte = $this->getArtefactDetails($id);

        // set new active artes for new owner

        #---------first inactive large and uinque artes if this currentArte is large/unique
        if ($currentArte['size'] == 2 || $currentArte['size'] == 3) {
            $ulArts = $this->query_return('SELECT * FROM ' . TB_PREFIX . 'artefacts WHERE `owner`=' . $newowner . ' AND `status`=1 AND `size`<>1');
            if (!empty($ulArts) && count($ulArts) > 0) {
                foreach ($ulArts as $art) $this->query("UPDATE " . TB_PREFIX . "artefacts SET `status` = 2 WHERE id = " . $art['id']);
            }
        }
        #---------then check extra artes
        $vArts = $this->query_return('SELECT * FROM ' . TB_PREFIX . 'artefacts WHERE `vref`=' . $newvref . ' AND `status`=1');
        if (!empty($vArts) && count($vArts) > 0) {
            foreach ($vArts as $art) $this->query("UPDATE " . TB_PREFIX . "artefacts SET `status` = 2 WHERE id = " . $art['id']);
        } else {
            $uArts = $this->query_return('SELECT * FROM ' . TB_PREFIX . 'artefacts WHERE `owner`=' . $newowner . ' AND `status`=1 ORDER BY conquered DESC');
            if (!empty($uArts) && count($uArts) > 2) {
                for ($i = 2; $i < count($uArts); $i++) $this->query("UPDATE " . TB_PREFIX . "artefacts SET `status` = 2 WHERE id = " . $uArts[$i]['id']);
            }
        }
        // set currentArte -> owner,vref,conquered,status
        $time = time();
        $q = "UPDATE " . TB_PREFIX . "artefacts SET vref = $newvref, owner = $newowner, conquered = $time, `status` = 1 WHERE id = $id";
        $this->query($q);
        // set new active artes for old user
        if ($currentArte['status'] == 1) {
            #--- get olduser's active artes
            $ouaArts = $this->query_return('SELECT * FROM ' . TB_PREFIX . 'artefacts WHERE `owner`=' . $currentArte['owner'] . ' AND `status`=1');
            $ouiArts = $this->query_return('SELECT * FROM ' . TB_PREFIX . 'artefacts WHERE `owner`=' . $currentArte['owner'] . ' AND `status`=2 ORDER BY conquered DESC');
            if (!empty($ouaArts) && count($ouaArts) < 3 && !empty($ouiArts) && count($ouiArts) > 0) {
                $ouiaCount = count($ouiArts);
                for ($i = 0; $i < $ouiaCount; $i++) {
                    $ia = $ouiArts[$i];
                    if (count($ouaArts) < 3) {
                        $accepted = true;
                        foreach ($ouaArts as $aa) {
                            if ($ia['vref'] == $aa['vref']) {
                                $accepted = false;
                                break;
                            }
                            if (($ia['size'] == 2 || $ia['size'] == 3) && ($aa['size'] == 2 || $aa['size'] == 3)) {
                                $accepted = false;
                                break;
                            }
                        }
                        if ($accepted) {
                            $ouaArts[] = $ia;
                            $q = "UPDATE " . TB_PREFIX . "artefacts SET `status` = 1 WHERE id = " . $ia['id'];
                            $this->query($q);
                        }
                    } else {
                        break;
                    }
                }
            }
        }
    }

    function getArtefactDetails($id)
    {
        $q = "SELECT * FROM " . TB_PREFIX . "artefacts WHERE id = " . $id;
        $result = mysql_query($q, $this->connection);
        return mysql_fetch_array($result);
    }

    function getHeroFace($uid)
    {
        $q = "SELECT * FROM " . TB_PREFIX . "heroface WHERE uid = " . $uid;
        $result = mysql_query($q, $this->connection);
        return mysql_fetch_array($result);
    }

    function addHeroFace($uid, $bread, $ear, $eye, $eyebrow, $face, $hair, $mouth, $nose, $color)
    {

        $q = "INSERT INTO `" . TB_PREFIX . "heroface` (`uid`, `beard`, `ear`, `eye`, `eyebrow`, `face`, `hair`, `mouth`, `nose`, `color`) VALUES ('$uid', '$bread', '$ear', '$eye', '$eyebrow', '$face', '$hair', '$mouth', '$nose', '$color')";
        return mysql_query($q, $this->connection);
    }

    function modifyHeroFace($uid, $column, $value)
    {
        $hash = md5("$uid" . time());
        $q = "UPDATE " . TB_PREFIX . "heroface SET `$column`='$value',`hash`='$hash' WHERE `uid` = '$uid'";
        return mysql_query($q, $this->connection);
    }

    function modifyWholeHeroFace($uid, $face, $color, $hair, $ear, $eyebrow, $eye, $nose, $mouth, $beard)
    {
        $hash = md5("$uid" . time());
        $q = "UPDATE " . TB_PREFIX . "heroface SET `face`=$face,`color`=$color,`hair`=$hair,`ear`=$ear,`eyebrow`=$eyebrow,`eye`=$eye,`nose`=$nose,`mouth`=$mouth,`beard`=$beard,`hash`='$hash' WHERE uid = $uid";

        return mysql_query($q, $this->connection);
    }

    function populateOasisUnitsLow()
    {
        $q2 = "SELECT * FROM " . TB_PREFIX . "wdata where oasistype != 0";
        $result2 = mysql_query($q2, $this->connection);
        while ($row = mysql_fetch_array($result2)) {
            $wid = $row['id'];
            $basearray = $this->getMInfo($wid);
            //each Troop is a Set for oasis type like mountains have rats spiders and snakes fields tigers elphants clay wolves so on stonger one more not so less
            switch ($basearray['oasistype']) {
                case 1:
                case 2:
                    // Oasis Random populate
                    $UP35 = rand(5, 30) * (SPEED / 10);
                    $UP36 = rand(5, 30) * (SPEED / 10);
                    $UP37 = rand(0, 30) * (SPEED / 10);
                    //+25% lumber per hour
                    $q = "UPDATE " . TB_PREFIX . "units SET u35 = u35 +  '" . $UP35 . "', u36 = u36 + '" . $UP36 . "', u37 = u37 + '" . $UP37 . "' WHERE vref = '" . $wid . "'";
                    $result = mysql_query($q, $this->connection);
                    break;
                case 3:
                    // Oasis Random populate
                    $UP35 = rand(5, 30) * (SPEED / 10);
                    $UP36 = rand(5, 30) * (SPEED / 10);
                    $UP37 = rand(1, 30) * (SPEED / 10);
                    $UP39 = rand(0, 10) * (SPEED / 10);
                    $fil = rand(0, 20);
                    if ($fil == 1) {
                        $UP40 = rand(0, 31) * (SPEED / 10);
                    } else {
                        $UP40 = 0;
                    }
                    //+25% lumber per hour
                    $q = "UPDATE " . TB_PREFIX . "units SET u35 = u35 +  '" . $UP35 . "', u36 = u36 + '" . $UP36 . "', u37 = u37 + '" . $UP37 . "', u39 = u39 + '" . $UP39 . "', u40 = u40 + '" . $UP40 . "' WHERE vref = '" . $wid . "'";
                    $result = mysql_query($q, $this->connection);
                    break;
                case 4:
                case 5:
                    // Oasis Random populate
                    $UP31 = rand(5, 40) * (SPEED / 10);
                    $UP32 = rand(5, 30) * (SPEED / 10);
                    $UP35 = rand(0, 25) * (SPEED / 10);
                    //+25% lumber per hour
                    $q = "UPDATE " . TB_PREFIX . "units SET u31 = u31 +  '" . $UP31 . "', u32 = u32 + '" . $UP32 . "', u35 = u35 + '" . $UP35 . "' WHERE vref = '" . $wid . "'";
                    $result = mysql_query($q, $this->connection);
                    break;
                case 6:
                    // Oasis Random populate
                    $UP31 = rand(5, 40) * (SPEED / 10);
                    $UP32 = rand(5, 30) * (SPEED / 10);
                    $UP35 = rand(1, 25) * (SPEED / 10);
                    $UP38 = rand(0, 15) * (SPEED / 10);
                    $fil = rand(0, 20);
                    if ($fil == 1) {
                        $UP40 = rand(0, 31) * (SPEED / 10);
                    } else {
                        $UP40 = 0;
                    }
                    //+25% lumber per hour
                    $q = "UPDATE " . TB_PREFIX . "units SET u31 = u31 +  '" . $UP31 . "', u32 = u32 + '" . $UP32 . "', u35 = u35 + '" . $UP35 . "', u38 = u38 + '" . $UP38 . "', u40 = u40 + '" . $UP40 . "' WHERE vref = '" . $wid . "'";
                    $result = mysql_query($q, $this->connection);
                    break;
                case 7:
                case 8:
                    // Oasis Random populate
                    $UP31 = rand(5, 40) * (SPEED / 10);
                    $UP32 = rand(5, 30) * (SPEED / 10);
                    $UP34 = rand(0, 25) * (SPEED / 10);
                    //+25% lumber per hour
                    $q = "UPDATE " . TB_PREFIX . "units SET u31 = u31 +  '" . $UP31 . "', u32 = u32 + '" . $UP32 . "', u34 = u34 + '" . $UP34 . "' WHERE vref = '" . $wid . "'";
                    $result = mysql_query($q, $this->connection);
                    break;
                case 9:
                    // Oasis Random populate
                    $UP31 = rand(5, 40) * (SPEED / 10);
                    $UP32 = rand(5, 30) * (SPEED / 10);
                    $UP34 = rand(1, 25) * (SPEED / 10);
                    $UP37 = rand(0, 15) * (SPEED / 10);
                    $fil = rand(0, 20);
                    if ($fil == 1) {
                        $UP40 = rand(0, 31) * (SPEED / 10);
                    } else {
                        $UP40 = 0;
                    }
                    //+25% lumber per hour
                    $q = "UPDATE " . TB_PREFIX . "units SET u31 = u31 +  '" . $UP31 . "', u32 = u32 + '" . $UP32 . "', u34 = u34 + '" . $UP34 . "', u37 = u37 + '" . $UP37 . "', u40 = u40 + '" . $UP40 . "' WHERE vref = '" . $wid . "'";
                    $result = mysql_query($q, $this->connection);
                    break;
                case 10:
                case 11:
                    // Oasis Random populate
                    $UP31 = rand(5, 40) * (SPEED / 10);
                    $UP33 = rand(5, 30) * (SPEED / 10);
                    $UP37 = rand(1, 25) * (SPEED / 10);
                    $UP39 = rand(0, 25) * (SPEED / 10);
                    //+25% lumber per hour
                    $q = "UPDATE " . TB_PREFIX . "units SET u31 = u31 +  '" . $UP31 . "', u33 = u33 + '" . $UP33 . "', u37 = u37 + '" . $UP37 . "', u39 = u39 + '" . $UP39 . "' WHERE vref = '" . $wid . "'";
                    $result = mysql_query($q, $this->connection);
                    break;
                case 12:
                    // Oasis Random populate
                    $UP31 = rand(5, 40) * (SPEED / 10);
                    $UP33 = rand(5, 30) * (SPEED / 10);
                    $UP38 = rand(1, 25) * (SPEED / 10);
                    $UP39 = rand(0, 25) * (SPEED / 10);
                    $fil = rand(0, 20);
                    if ($fil == 1) {
                        $UP40 = rand(0, 31) * (SPEED / 10);
                    } else {
                        $UP40 = 0;
                    }
                    //+25% lumber per hour
                    $q = "UPDATE " . TB_PREFIX . "units SET u31 = u31 +  '" . $UP31 . "', u33 = u33 + '" . $UP33 . "', u38 = u38 + '" . $UP38 . "', u39 = u39 + '" . $UP39 . "', u40 = u40 + '" . $UP40 . "' WHERE vref = '" . $wid . "'";
                    $result = mysql_query($q, $this->connection);
                    break;
            }
        }
    }

    public function hasBeginnerProtection($vid)
    {
        $q = "SELECT u.protect FROM " . TB_PREFIX . "users u," . TB_PREFIX . "vdata v WHERE u.id=v.owner AND v.wref=" . $vid;
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        if (!empty($dbarray)) {
            if (time() < $dbarray[0]) {
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

    function addCLP($uid, $clp)
    {
        $q = "UPDATE " . TB_PREFIX . "users set clp = clp + $clp where id = $uid";
        return mysql_query($q, $this->connection);
    }

    function sendwlcMessage($client, $owner, $topic, $message, $send)
    {
        $time = time();
        $q = "INSERT INTO " . TB_PREFIX . "mdata values (0,$client,$owner,'$topic',\"$message\",1,0,$send,$time)";
        return mysql_query($q, $this->connection);
    }

    function getLinks($id)
    {
        $q = 'SELECT `url`,`name` FROM ' . TB_PREFIX . 'links WHERE `userid` = ' . $id . ' ORDER BY `pos` ASC';
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function removeLinks($id, $uid)
    {
        $q = "DELETE FROM " . TB_PREFIX . "links WHERE `id` = " . $id . " and `userid` = " . $uid . "";
        return mysql_query($q, $this->connection);
    }

    function getFarmlist($uid)
    {
        $q = 'SELECT id FROM ' . TB_PREFIX . 'farmlist WHERE owner = ' . $uid . ' ORDER BY name ASC';
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);

        if ($dbarray['id'] != 0) {
            return true;
        } else {
            return false;
        }

    }

    function getRaidList($id)
    {
        $q = "SELECT * FROM " . TB_PREFIX . "raidlist WHERE id = " . $id . "";
        $result = mysql_query($q, $this->connection);
        return mysql_fetch_array($result);
    }

    function getAllAuction()
    {
        $q = "SELECT * FROM " . TB_PREFIX . "auction WHERE finish = 0";
        $result = mysql_query($q, $this->connection);
        return mysql_fetch_array($result);
    }

    function getVilFarmlist($wref)
    {
        $q = 'SELECT id FROM ' . TB_PREFIX . 'farmlist WHERE wref = ' . $wref . ' ORDER BY wref ASC';
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);

        if ($dbarray['id'] != 0) {
            return true;
        } else {
            return false;
        }

    }

    function delFarmList($id, $owner)
    {
        $q = "DELETE FROM " . TB_PREFIX . "farmlist where id = $id and owner = $owner";
        return mysql_query($q, $this->connection);
    }

    function delSlotFarm($id)
    {
        $q = "DELETE FROM " . TB_PREFIX . "raidlist where id = $id";
        return mysql_query($q, $this->connection);
    }


    function createFarmList($wref, $owner, $name)
    {
        $q = "INSERT INTO " . TB_PREFIX . "farmlist (`wref`, `owner`, `name`) VALUES ('$wref', '$owner', '$name')";
        return mysql_query($q, $this->connection);
    }

    function addSlotFarm($lid, $towref, $x, $y, $distance, $t1, $t2, $t3, $t4, $t5, $t6, $t7, $t8, $t9, $t10)
    {
        $q = "INSERT INTO " . TB_PREFIX . "raidlist (`lid`, `towref`, `x`, `y`, `distance`, `t1`, `t2`, `t3`, `t4`, `t5`, `t6`, `t7`, `t8`, `t9`, `t10`) VALUES ('$lid', '$towref', '$x', '$y', '$distance', '$t1', '$t2', '$t3', '$t4', '$t5', '$t6', '$t7', '$t8', '$t9', '$t10')";
        return mysql_query($q, $this->connection);
    }

    function editSlotFarm($eid, $lid, $wref, $x, $y, $dist, $t1, $t2, $t3, $t4, $t5, $t6, $t7, $t8, $t9, $t10)
    {

        $q = "UPDATE " . TB_PREFIX . "raidlist set lid = '$lid', towref = '$wref', x = '$x', y = '$y', t1 = '$t1', t2 = '$t2', t3 = '$t3', t4 = '$t4', t5 = '$t5', t6 = '$t6', t7 = '$t7', t8 = '$t8', t9 = '$t9', t10 = '$t10' WHERE id = $eid";
        return mysql_query($q, $this->connection);

    }

    function removeOases($wref)
    {
        $q = "UPDATE " . TB_PREFIX . "odata SET conqured = 0, owner = 3, name = '" . UNOCCUPIEDOASES . "' WHERE wref = $wref";
        $r = mysql_query($q, $this->connection);
        $q = "UPDATE " . TB_PREFIX . "wdata SET occupied = 0 WHERE id = $wref";
        $r2 = mysql_query($q, $this->connection);
        return ($r && $r2);
    }

    function getArrayMemberVillage($uid)
    {
        $q = 'SELECT a.wref, a.name, a.capital, b.x, b.y from ' . TB_PREFIX . 'vdata AS a left join ' . TB_PREFIX . 'wdata AS b ON b.id = a.wref where owner = ' . $uid . ' order by capital DESC,pop DESC';
        $result = mysql_query($q, $this->connection);
        $array = $this->mysql_fetch_all($result);
        return $array;
    }

    function getNoticeData($nid)
    {
        $q = "SELECT `data` FROM " . TB_PREFIX . "ndata where id = $nid";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        return $dbarray['data'];
    }

    function getUsersNotice($uid, $ntype = -1, $viewed = -1)
    {
        $q = "SELECT * FROM " . TB_PREFIX . "ndata where uid=$uid ";
        if ($ntype >= 0) {
            $q .= " and ntype=$ntype ";
        }
        if ($viewed >= 0) {
            $q .= " and viewed=$viewed ";
        }
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        return $dbarray;
    }

    function setSilver($uid, $silver, $mode)
    {
        if (!$mode) {
            $q = "UPDATE " . TB_PREFIX . "users set silver = silver - $silver where id = $uid";
            //Used Silver
            $q2 = "UPDATE " . TB_PREFIX . "users set usedsilver = usedsilver+" . $silver . " where id = $uid";
            mysql_query($q2, $this->connection);
        } else {
            $q = "UPDATE " . TB_PREFIX . "users set silver = silver + $silver where id = $uid";
            //Addgold gold
            $q2 = "UPDATE " . TB_PREFIX . "users set Addsilver = Addsilver+" . $silver . " where id = $uid";
            mysql_query($q2, $this->connection);
        }
        return mysql_query($q, $this->connection);
    }

    function getAuctionSilver($uid)
    {
        $q = "SELECT * FROM " . TB_PREFIX . "auction where uid = $uid and finish = 0";
        $result = mysql_query($q, $this->connection);
        return mysql_fetch_array($result);
    }

    function getAuctionData($id)
    {
        $q = "SELECT * FROM " . TB_PREFIX . "auction where id = $id";
        $result = mysql_query($q, $this->connection);
        return mysql_fetch_array($result);
    }

    function delAuction($id)
    {
        $aucData = $this->getAuctionData($id);
        $usedtime = AUCTIONTIME - ($aucData['time'] - time());
        if (($usedtime < (AUCTIONTIME / 10)) && !$aucData['bids']) {
            $this->modifyHeroItem($aucData['itemid'], 'num', $aucData['num'], 1);
            $this->modifyHeroItem($aucData['itemid'], 'proc', 0, 0);
            $q = "DELETE FROM " . TB_PREFIX . "auction where id = $id and finish = 0";
            return mysql_query($q, $this->connection);
        } else {
            return false;
        }
    }

    function getAuctionUser($uid)
    {
        $q = "SELECT * FROM " . TB_PREFIX . "auction where owner = $uid";
        $result = mysql_query($q, $this->connection);
        return mysql_fetch_array($result);
    }

    function addAuction($owner, $itemid, $btype, $type, $amount)
    {
        $time = time() + AUCTIONTIME;
        $itemData = $this->getHeroItem($itemid);
        if ($amount >= $itemData['num']) {
            $amount = $itemData['num'];
            $this->modifyHeroItem($itemid, 'proc', 1, 0);
        }
        if ($amount <= 0) return false;
        $this->modifyHeroItem($itemid, 'num', $amount, 2);
        switch ($btype) {
            case 7:
            case 8:
            case 9:
            case 10:
            case 11:
            case 14:
                $silver = $amount;
                break;
            default:
                $silver = $amount * 100;
                break;
        }
        $q = "INSERT INTO " . TB_PREFIX . "auction (`owner`, `itemid`, `btype`, `type`, `num`, `uid`, `bids`, `silver`, `maxsilver`, `time`, `finish`) VALUES ('$owner', '$itemid', '$btype', '$type', '$amount', 0, 0, '$silver', '$silver', '$time', 0)";
        return mysql_query($q, $this->connection);
    }

    function addBid($id, $uid, $silver, $maxsilver, $time)
    {
        $q = "UPDATE " . TB_PREFIX . "auction set uid = $uid, silver = $silver, maxsilver = $maxsilver, bids = bids + 1, time = $time where id = $id";
        return mysql_query($q, $this->connection);
    }

    function removeBidNotice($id)
    {
        $q = "DELETE FROM " . TB_PREFIX . "auction where id = $id";
        return mysql_query($q, $this->connection);
    }

    function addHeroItem($uid, $btype, $type, $num)
    {
        $q = "INSERT INTO " . TB_PREFIX . "heroitems (`uid`, `btype`, `type`, `num`, `proc`) VALUES ('$uid', '$btype', '$type', '$num', 0)";
        return mysql_query($q, $this->connection);
    }

    function checkHeroItem($uid, $btype, $type = 0, $proc = 2)
    {
        $q = "SELECT id,btype FROM " . TB_PREFIX . "heroitems WHERE TRUE "
            . ($uid ? " AND uid = '$uid'" : '')
            . ($btype ? " AND btype = '$btype'" : '')
            . ($type ? " AND type = '$type'" : '')
            . ($proc != 2 ? " AND proc = '$proc'" : '');
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        if (isset($dbarray['btype'])) {
            return $dbarray['id'];
        } else {
            return false;
        }
    }

    function getHeroItem($id = 0, $uid = 0, $btype = 0, $type = 0, $proc = 2)
    {
        $q = "SELECT * FROM " . TB_PREFIX . "heroitems WHERE TRUE "
            . ($id ? (" AND id = " . $id) : (""))
            . ($uid ? (" AND uid = " . $uid) : (""))
            . ($btype ? (" AND btype = " . $btype) : (""))
            . ($type ? (" AND type = " . $type) : (""))
            . ($proc != 2 ? (" AND proc = " . $proc) : (""));
        $result = $this->query_return($q);
        if ($id) $result = $result[0];
        return $result;
    }

    function modifyHeroItem($id, $column, $value, $mode)
    {
        // mode=0 set; 1 add; 2 sub; 3 mul; 4 div
        switch ($mode) {
            case 0:
                $cmd = " $column = $value ";
                break;
            case 1:
                $cmd = " $column = $column+$value ";
                break;
            case 2:
                $cmd = " $column = $column-$value ";
                break;
            case 3:
                $cmd = " $column = $column*$value ";
                break;
            case 4:
                $cmd = " $column = $column/$value ";
                break;
        }
        $q = "UPDATE " . TB_PREFIX . "heroitems set $cmd where id = $id";
        $result = mysql_query($q, $this->connection);
        return ($result ? true : false);
    }

    function editBid($id, $maxsilver,$minsilver)
    {
        $q = "UPDATE " . TB_PREFIX . "auction set maxsilver = $maxsilver, silver = $minsilver where id = $id";
        return mysql_query($q, $this->connection);
    }

    function getBidData($id)
    {
        $q = "SELECT * FROM " . TB_PREFIX . "auction WHERE id = $id";
        $result = mysql_query($q, $this->connection);
        return mysql_fetch_array($result);
    }

    function getFLData($id)
    {
        $q = "SELECT * FROM " . TB_PREFIX . "farmlist where id = $id";
        $result = mysql_query($q, $this->connection);
        return mysql_fetch_array($result);
    }

    function getHeroField($uid, $field)
    {
        $q = "SELECT " . $field . " FROM " . TB_PREFIX . "hero WHERE uid = $uid";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        return $dbarray[$field];
    }

    function getVFH($uid)
    {
        $q = "SELECT wref FROM " . TB_PREFIX . "vdata WHERE owner = $uid and capital = 1";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        return $dbarray['wref'];
    }

    function getCapBrewery($uid)
    {
        $capWref = $this->getVFH($uid);
        if ($capWref) {
            $q = "SELECT * FROM " . TB_PREFIX . "fdata WHERE vref = " . $capWref;
            $result = mysql_query($q, $this->connection);
            if ($result) {
                $dbarray = mysql_fetch_assoc($result);
                if (!empty($dbarray)) {
                    for ($i = 19; $i <= 40; $i++) {
                        if ($dbarray['f' . $i . 't'] == 35) {
                            return $dbarray['f' . $i];
                        }
                    }
                }
            }
        }
        return 0;
    }

    function getNotice2($id, $field)
    {
        $q = "SELECT " . $field . " FROM " . TB_PREFIX . "ndata where `id` = '$id'";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_array($result);
        return $dbarray[$field];
    }

    function addAdventure($wref, $uid, $time = 0, $dif = 0)
    {
        if ($time == 0) $time = time();
        // $ddd = rand(0,3);
        // if($ddd == 1){ $dif = 1; }else{ $dif = 0; }
        $sql = mysql_query("SELECT id FROM " . TB_PREFIX . "wdata ORDER BY id DESC LIMIT 1");
        $myvar = mysql_fetch_assoc($sql);
        // print_r($myvar);die;
        $lastw = $myvar['id'];
        if (($wref - 10000) <= 10) {
            $w1 = rand(10, ($wref + 10000));
        } elseif (($wref + 10000) >= $lastw) {
            $w1 = rand(($wref - 10000), ($lastw - 10000));
        } else {
            $w1 = rand(($wref - 10000), ($wref + 10000));
        }
        $q = "INSERT into " . TB_PREFIX . "adventure (`wref`, `uid`, `dif`, `time`, `end`) values ('$w1', '$uid', '$dif', '$time', 0)";
        return mysql_query($q, $this->connection);
    }

    function addHero($uid)
    {
        $time = time();
        $hash = md5($time);
        switch ($this->getUserField($uid, 'tribe', 0)) {
            case 0:
                $cpproduction = 0;
                $speed = 7;
                $rob = 0;
                $fsperpoint = 100;
                $extraresist = 0;
                $vsnatars = 0;
                $autoregen = 10;
                $extraexpgain = 0;
                $accountmspeed = 0;
                $allymspeed = 0;
                $longwaymspeed = 0;
                $returnmspeed = 0;
                break;
            case 1:
                $cpproduction = 5;
                $speed = 6;
                $rob = 0;
                $fsperpoint = 100;
                $extraresist = 4;
                $vsnatars = 25;
                $autoregen = 20;
                $extraexpgain = 0;
                $accountmspeed = 0;
                $allymspeed = 0;
                $longwaymspeed = 0;
                $returnmspeed = 0;
                break;
            case 2:
                $cpproduction = 0;
                $speed = 8;
                $rob = 10;
                $fsperpoint = 90;
                $extraresist = 0;
                $vsnatars = 0;
                $autoregen = 10;
                $extraexpgain = 15;
                $accountmspeed = 0;
                $allymspeed = 0;
                $longwaymspeed = 0;
                $returnmspeed = 0;
                break;
            case 3:
                $cpproduction = 0;
                $speed = 10;
                $rob = 0;
                $fsperpoint = 80;
                $extraresist = 0;
                $vsnatars = 0;
                $autoregen = 10;
                $extraexpgain = 0;
                $accountmspeed = 30;
                $allymspeed = 15;
                $longwaymspeed = 25;
                $returnmspeed = 30;
                break;
            case 4:
                $cpproduction = 0;
                $speed = 7;
                $rob = 0;
                $fsperpoint = 100;
                $extraresist = 0;
                $vsnatars = 0;
                $autoregen = 10;
                $extraexpgain = 0;
                $accountmspeed = 0;
                $allymspeed = 0;
                $longwaymspeed = 0;
                $returnmspeed = 0;
                break;
            case 5:
                $cpproduction = 0;
                $speed = 7;
                $rob = 0;
                $fsperpoint = 100;
                $extraresist = 0;
                $vsnatars = 0;
                $autoregen = 10;
                $extraexpgain = 0;
                $accountmspeed = 0;
                $allymspeed = 0;
                $longwaymspeed = 0;
                $returnmspeed = 0;
                break;
            default:
                $cpproduction = 0;
                $speed = 7;
                $rob = 0;
                $fsperpoint = 100;
                $extraresist = 0;
                $vsnatars = 0;
                $autoregen = 10;
                $extraexpgain = 0;
                $accountmspeed = 0;
                $allymspeed = 0;
                $longwaymspeed = 0;
                $returnmspeed = 0;
                break;
        }
        $q = "INSERT into " . TB_PREFIX . "hero (`uid`, `wref`, `level`, `speed`, `points`, `experience`, `dead`, `health`, `power`, `fsperpoint`, `offBonus`, `defBonus`, `product`, `r0`, `autoregen`, `extraexpgain`, `cpproduction`, `rob`, `extraresist`, `vsnatars`, `accountmspeed`, `allymspeed`, `longwaymspeed`, `returnmspeed`, `lastupdate`, `lastadv`, `hash`) values 
				('$uid', 0, 0, '$speed', 0, '0', 0, '100', '0', '$fsperpoint', '0', '0', '4', '1', '$autoregen', '$extraexpgain', '$cpproduction', '$rob', '$extraresist', '$vsnatars', '$accountmspeed', '$allymspeed', '$longwaymspeed', '$returnmspeed', '$time', '0', '$hash')";
        return mysql_query($q, $this->connection);
    }

    // Add new password => mode:0
    // Add new email => mode: 1
    function addNewProc($uid, $npw, $nemail, $act, $mode)
    {
        $time = time();
        if (!$mode) {
            $q = "INSERT into " . TB_PREFIX . "newproc (uid, npw, act, time, proc) values ('$uid', '$npw', '$act', '$time', 0)";
        } else {
            $q = "INSERT into " . TB_PREFIX . "newproc (uid, nemail, act, time, proc) values ('$uid', '$nemail', '$act', '$time', 0)";
        }

        return mysql_query($q, $this->connection);
    }

    function checkProcExist($uid)
    {
        $q = "SELECT uid FROM " . TB_PREFIX . "newproc where uid = '$uid' and proc = 0";
        $result = mysql_query($q, $this->connection);
        if (mysql_num_rows($result)) {
            return false;
        } else {
            return true;
        }
    }

    function removeProc($uid)
    {
        $q = "DELETE FROM " . TB_PREFIX . "newproc where uid = $uid";
        return mysql_query($q, $this->connection);
    }

    function checkBan($uid)
    {
        $q = "SELECT access FROM " . TB_PREFIX . "users WHERE id = $uid LIMIT 1";
        $result = $this->query_return($q);
        if (!empty($result) && ($result[0]['access'] <= 1 /*|| $result[0]['access']>=7*/)) {
            return true;
        } else {
            return false;
        }
    }

    function getNewProc($uid)
    {
        $q = "SELECT `npw`,`act` FROM " . TB_PREFIX . "newproc WHERE uid = $uid";
        $result = mysql_query($q, $this->connection);
        if (mysql_num_rows($result)) {
            return mysql_fetch_array($result);
        } else {
            return false;
        }
    }

    function CheckAdventure($uid, $wref, $end)
    {
        $q = "SELECT `id` FROM " . TB_PREFIX . "adventure WHERE uid = $uid AND wref = $wref AND end = $end";
        $result = mysql_query($q, $this->connection);
        if ($result) {
            return mysql_fetch_array($result);
        } else {
            return false;
        }
    }

    function getAdventure($uid, $wref = 0, $end = 2)
    {
        $q = "SELECT `id`,`dif` FROM " . TB_PREFIX . "adventure WHERE uid = $uid "
            . ($wref != 0 ? " AND wref = '$wref'" : '')
            . ($end != 2 ? " AND end = $end" : '');
        $result = mysql_query($q, $this->connection);
        if ($result) {
            return mysql_fetch_array($result);
        } else {
            return false;
        }
    }

    function editTableField($table, $field, $value, $refField, $ref)
    {
        $q = "UPDATE " . TB_PREFIX . "" . $table . " set $field = '$value' where " . $refField . " = '$ref'";
        return mysql_query($q, $this->connection);
    }

    function config()
    {
        $q = "SELECT * FROM " . TB_PREFIX . "config";
        $result = mysql_query($q, $this->connection);
        return mysql_fetch_array($result);
    }

    function getAllianceDipProfile($aid, $type)
    {
        $q = "SELECT `alli2` FROM " . TB_PREFIX . "diplomacy WHERE alli1 = '$aid' AND type = '$type' AND accepted = '1'";
        $result = mysql_query($q, $this->connection);
        if (mysql_num_rows($result) == 0) {
            $q2 = "SELECT `alli1` FROM " . TB_PREFIX . "diplomacy WHERE alli2 = '$aid' AND type = '$type' AND accepted = '1'";
            $result2 = mysql_query($q2, $this->connection);
            while ($row = mysql_fetch_array($result2)) {
                $alliance = $this->getAlliance($row['alli1']);
                $text = "";
                $text .= "<a href=allianz.php?aid=" . $alliance['id'] . ">" . $alliance['tag'] . "</a><br> ";
            }
        } else {
            while ($row = mysql_fetch_array($result)) {
                $alliance = $this->getAlliance($row['alli2']);
                $text = "";
                $text .= "<a href=allianz.php?aid=" . $alliance['id'] . ">" . $alliance['tag'] . "</a><br> ";
            }
        }
        if (strlen($text) == 0) {
            $text = "-<br>";
        }
        return $text;
    }

    public function canClaimArtifact($vref, $type)
    {
        $DefenderFields = $this->getResourceLevel($vref);
        for ($i = 19; $i <= 38; $i++) {
            if ($DefenderFields['f' . $i . 't'] == 27) {
                $defcanclaim = FALSE;
                //$defTresuaryLevel = $DefenderFields['f' . $i];
            } else {
                $defcanclaim = TRUE;
            }
        }
        $AttackerFields = $this->getResourceLevel($vref);
        for ($i = 19; $i <= 38; $i++) {
            if ($AttackerFields['f' . $i . 't'] == 27) {
                $attTresuaryLevel = $AttackerFields['f' . $i];
                if ($attTresuaryLevel >= 10) {
                    $villageartifact = TRUE;
                } else {
                    $villageartifact = FALSE;
                }
                if ($attTresuaryLevel == 20) {
                    $accountartifact = TRUE;
                } else {
                    $accountartifact = FALSE;
                }
            }
        }
        if ($type == 1) {
            if ($defcanclaim == TRUE && $villageartifact == TRUE) {
                return TRUE;
            }
        } else if ($type == 2) {
            if ($defcanclaim == TRUE && $accountartifact == TRUE) {
                return TRUE;
            }
        } else if ($type == 3) {
            if ($defcanclaim == TRUE && $accountartifact == TRUE) {
                return TRUE;
            }
        } else {
            return FALSE;
        }
    }

    function imagecopymerge_alpha($dst_im, $src_im, $dst_x, $dst_y, $src_x, $src_y, $src_w, $src_h, $pct)
    {
        if (!isset($pct)) {
            return false;
        }
        $pct /= 100;
        // Get image width and height 
        $w = imagesx($src_im);
        $h = imagesy($src_im);
        // Turn alpha blending off 
        imagealphablending($src_im, false);
        // Find the most opaque pixel in the image (the one with the smallest alpha value) 
        $minalpha = 127;
        for ($x = 0; $x < $w; $x++)
            for ($y = 0; $y < $h; $y++) {
                $alpha = (imagecolorat($src_im, $x, $y) >> 24) & 0xFF;
                if ($alpha < $minalpha) {
                    $minalpha = $alpha;
                }
            }
        //loop through image pixels and modify alpha for each 
        for ($x = 0; $x < $w; $x++) {
            for ($y = 0; $y < $h; $y++) {
                //get current alpha value (represents the TANSPARENCY!) 
                $colorxy = imagecolorat($src_im, $x, $y);
                $alpha = ($colorxy >> 24) & 0xFF;
                //calculate new alpha 
                if ($minalpha !== 127) {
                    $alpha = 127 + 127 * $pct * ($alpha - 127) / (127 - $minalpha);
                } else {
                    $alpha += 127 * $pct;
                }
                //get the color index with new alpha 
                $alphacolorxy = imagecolorallocatealpha($src_im, ($colorxy >> 16) & 0xFF, ($colorxy >> 8) & 0xFF, $colorxy & 0xFF, $alpha);
                //set pixel with the new color + opacity 
                if (!imagesetpixel($src_im, $x, $y, $alphacolorxy)) {
                    return false;
                }
            }
        }
        // The image copy 
        imagecopy($dst_im, $src_im, $dst_x, $dst_y, $src_x, $src_y, $src_w, $src_h);
    }

    function getCropProdstarv($wref)
    {
        global $bid4, $bid8, $bid9;

        $basecrop = $grainmill = $bakery = 0;
        $owner = $this->getVillageField($wref, 'owner');
        $bonus = $this->getUserField($owner, 'b4', 0);

        $buildarray = $this->getResourceLevel($wref);
        $cropholder = array();
        for ($i = 1; $i <= 38; $i++) {
            if ($buildarray['f' . $i . 't'] == 4) {
                array_push($cropholder, 'f' . $i);
            }
            if ($buildarray['f' . $i . 't'] == 8) {
                $grainmill = $buildarray['f' . $i];
            }
            if ($buildarray['f' . $i . 't'] == 9) {
                $bakery = $buildarray['f' . $i];
            }
        }
        $q = "SELECT type FROM `" . TB_PREFIX . "odata` WHERE conqured = $wref";
        $oasis = $this->query_return($q);
        $cropo = 0;
        foreach ($oasis as $oa) {
            switch ($oa['type']) {
                case 3:
                    $cropo += 1;
                    break;
                case 6:
                    $cropo += 1;
                    break;
                case 9:
                    $cropo += 1;
                    break;
                case 10:
                case 11:
                    $cropo += 1;
                    break;
                case 12:
                    $cropo += 2;
                    break;
            }
        }
        for ($i = 0; $i <= count($cropholder) - 1; $i++) {
            $basecrop += $bid4[$buildarray[$cropholder[$i]]]['prod'];
        }
        $crop = $basecrop + $basecrop * 0.25 * $cropo;
        if ($grainmill >= 1 || $bakery >= 1) {
            $crop += $basecrop / 100 * ($bid8[$grainmill]['attri'] + $bid9[$bakery]['attri']);
        }
        if ($bonus > time()) {
            $crop *= 1.25;
        }
        $crop *= SPEED;
        return $crop;
    }

    public function getNatarsProgress()
    {
        $q = "SELECT * FROM " . TB_PREFIX . "natarsprogress";
        $sql = mysql_query($q);
        $result = mysql_fetch_array($sql);
        return $result;
    }

    public function setNatarsProgress($field, $value)
    {
        $q = "UPDATE " . TB_PREFIX . "natarsprogress SET `$field` = '$value'";
        return mysql_query($q, $this->connection);
    }

    public function getNatarsCapital()
    {
        $q = "SELECT `wref` FROM " . TB_PREFIX . "vdata WHERE owner=2 AND capital = 1 ORDER BY created ASC";
        $result = $this->query_return($q);
        return $result[0];
    }

    public function getNatarsWWVillages()
    {
        $q = "SELECT `owner` FROM " . TB_PREFIX . "vdata WHERE owner=2 AND name = 'WW Village' ORDER BY created ASC";
        $result = $this->query_return($q);
        return $result;
    }

    function addNatarsVillage($wid, $uid, $username, $capital)
    {
        $total = count($this->getVillagesID($uid));
        $vname = sprintf("[%05d] Natars", $total + 1);
        $time = time();
        $q = "INSERT into " . TB_PREFIX . "vdata "
            . " (wref, owner, name, capital, pop, cp, celebration, wood, clay, iron, maxstore, crop, maxcrop, lastupdate, created, natar)"
            . " values ('$wid', '$uid', '$vname', '$capital', 2, 1, 0, 780, 780, 780, 800, 780, 800, '$time', '$time', '1')";
        return mysql_query($q, $this->connection);
    }

    function instantTrain($vref)
    {
        $q = 'SELECT `id` FROM ' . TB_PREFIX . 'training WHERE `vref`=' . $vref;
        $count = count($this->query_return($q));
        $q = 'UPDATE ' . TB_PREFIX . 'training SET `commence`=0,`eachtime`=1,`endat`=0,`timestamp`=0 WHERE `vref`=' . $vref;
        $result = mysql_query($q, $this->connection);
        if ($result) {
            return $count;
        } else {
            return -1;
        }
    }

    function hasWinner()
    {
        $sql = mysql_query("SELECT vref FROM " . TB_PREFIX . "fdata WHERE f99 = '100' and f99t = '40'");
        $winner = mysql_num_rows($sql);
        return ($winner > 0 ? true : false);
    }

    function getVillageActiveArte($vref)
    {
        $q = 'SELECT * FROM ' . TB_PREFIX . 'artefacts WHERE `vref`=' . $vref . ' AND `status`=1 AND `conquered`<=' . (time() - max(86400 / SPEED, 600));
        return $this->query_return($q);
    }

    function getAccountActiveArte($owner)
    {
        $q = 'SELECT * FROM ' . TB_PREFIX . 'artefacts WHERE `owner`=' . $owner . ' AND `status`=1 AND `conquered`<=' . (time() - max(86400 / SPEED, 600));
        return $this->query_return($q);
    }

    function updateFoolArtes()
    {
        $q = 'SELECT `id`,`size` FROM ' . TB_PREFIX . 'artefacts WHERE `type`=3 AND `status`=1 AND `conquered`<=' . (time() - max(86400 / SPEED, 600)) . ' AND lastupdate<=' . (time() - max(86400 / SPEED, 600));
        $result = $this->query_return($q);
        if (!empty($result) && count($result) > 0) {
            foreach ($result as $r) {
                $effecttype = rand(3, 9);
                if ($effecttype == 3) $effecttype = 2;
                $aoerand = rand(1, 100);
                if ($aoerand <= 75) {
                    $aoe = 1;
                } elseif ($aoerand <= 95) {
                    $aoe = 2;
                } else {
                    $aoe = 3;
                }
                switch ($effecttype) {
                    case 2:
                        if ($r['size'] == 1) {
                            $effect = rand(100, 500) / 100;
                        } else {
                            $effect = rand(100, 1000) / 100;
                        }
                        break;
                    case 4:
                        if ($r['size'] == 1) {
                            $effect = rand(100, 300) / 100;
                        } else {
                            $effect = rand(100, 600) / 100;
                        }
                        break;
                    case 5:
                        if ($r['size'] == 1) {
                            $effect = rand(100, 1000) / 100;
                        } else {
                            $effect = rand(100, 2000) / 100;
                        }
                        break;
                    case 6:
                        if ($r['size'] == 1) {
                            $effect = rand(50, 100) / 100;
                        } else {
                            $effect = rand(25, 100) / 100;
                        }
                        break;
                    case 7:
                        if ($r['size'] == 1) {
                            $effect = rand(100, 50000) / 100;
                        } else {
                            $effect = rand(100, 100000) / 100;
                        }
                        break;
                    case 8:
                        if ($r['size'] == 1) {
                            $effect = rand(50, 100) / 100;
                        } else {
                            $effect = rand(25, 100) / 100;
                        }
                        break;
                    case 9:
                        if ($r['size'] == 1) {
                            $effect = 1;
                        }
                        break;
                }
                if ($r['size'] == 1 && rand(1, 100) <= 50) {
                    $effect = 1 / $effect;
                }
                $q = 'UPDATE ' . TB_PREFIX . 'artefacts SET `effecttype`=' . $effecttype . ',`effect`=' . $effect . ',`aoe`=' . $aoe . ' WHERE `id`=' . $r['id'];
                mysql_query($q, $this->connection);
            }
        }
    }

    function getArteEffectByType($wref, $type)
    {
        $artEff = 0;
        $this->updateFoolArtes();
        $vinfo = $this->getVillage($wref);
        if (!empty($vinfo) && isset($vinfo['owner'])) {
            $owner = $vinfo['owner'];
            $q = 'SELECT `vref`,`effect`,`aoe` FROM ' . TB_PREFIX . 'artefacts WHERE `owner`=' . $owner . ' AND `effecttype`=' . $type . ' AND `status`=1 AND `conquered`<=' . (time() - max(86400 / SPEED, 600)) . ' ORDER BY `conquered` DESC';
            $result = $this->query_return($q);
            if (!empty($result) && count($result) > 0) {
                $i = 0;
                foreach ($result as $r) {
                    if ($r['vref'] == $wref) {
                        return $r['effect'];
                    }
                    if ($r['aoe'] == 3) {
                        return $r['effect'];
                    }
                    $i += 1;
                    if ($i >= 3) break;
                }
            }
        }

        return $artEff;
    }

    function getArtEffMSpeed($wref)
    {
        $artEff = 1;
        $res = $this->getArteEffectByType($wref, 4);
        if ($res != 0) $artEff = $res;
        return $artEff;
    }

    function getArtEffDiet($wref)
    {
        $artEff = 1;
        $res = $this->getArteEffectByType($wref, 6);
        if ($res != 0) $artEff = $res;
        return $artEff;
    }

    function getArtEffGrt($wref)
    {
        $artEff = 0;
        $res = $this->getArteEffectByType($wref, 9);
        if ($res != 0) $artEff = $res;
        return $artEff;
    }

    function getArtEffArch($wref)
    {
        $artEff = 1;
        $res = $this->getArteEffectByType($wref, 2);
        if ($res != 0) $artEff = $res;
        return $artEff;
    }

    function getArtEffSpy($wref)
    {
        $artEff = 0;
        $res = $this->getArteEffectByType($wref, 5);
        if ($res != 0) $artEff = $res;
        return $artEff;
    }

    function getArtEffTrain($wref)
    {
        $artEff = 1;
        $res = $this->getArteEffectByType($wref, 8);
        if ($res != 0) $artEff = $res;
        return $artEff;
    }

    function getArtEffConf($wref)
    {
        $artEff = 1;
        $res = $this->getArteEffectByType($wref, 7);
        if ($res != 0) $artEff = $res;
        return $artEff;
    }

    function getArtEffBP($wref)
    {
        $artEff = 0;
        $vinfo = $this->getVillage($wref);
        $owner = $vinfo['owner'];
        $q = 'SELECT `id` FROM ' . TB_PREFIX . 'artefacts WHERE `owner`=' . $owner . ' AND `effecttype`=11 AND `status`=1 AND `conquered`<=' . (time() - max(86400 / SPEED, 600)) . ' ORDER BY `conquered` DESC';
        $result = $this->query_return($q);
        if (!empty($result) && count($result) > 0) {
            return $artEff = 1;
        }
        return $artEff;
    }

    function getArtEffAllyBP($uid)
    {
        $artEff = 0;
        $userAlli = $this->getUserField($uid, 'alliance', 0);
        $q = 'SELECT `alli1`,`alli2` FROM ' . TB_PREFIX . 'diplomacy WHERE alli1=' . $userAlli . ' OR alli2=' . $userAlli . ' AND accepted<>0';
        $diplos = $this->query_return($q);
        $diplos[] = array('alli1' => $userAlli, 'alli2' => $userAlli);
        if (!empty($diplos) && count($diplos) > 0) {
            $al = array();
            foreach ($diplos as $ds) {
                $al[] = $ds['alli1'];
                $al[] = $ds['alli2'];
            }
            $al = array_unique($al);
            $alstr = implode(',', $al);
            $q = 'SELECT `id` FROM ' . TB_PREFIX . 'users WHERE alliance IN (' . $alstr . ') AND id<>' . $uid;
            $mate = $this->query_return($q);
            if (!empty($mate) && count($mate) > 0) {
                $ml = array();
                foreach ($mate as $ms) {
                    $ml[] = $ms['id'];
                }
                $matestr = implode(',', $ml);
                $q = 'SELECT `id` FROM ' . TB_PREFIX . 'artefacts WHERE `owner` IN (' . $matestr . ') AND `effecttype`=11 AND `status`=1 AND `conquered`<=' . (time() - max(86400 / SPEED, 600)) . ' ORDER BY `conquered` DESC';
                $result = $this->query_return($q);
                if (!empty($result) && count($result) > 0) {
                    return $artEff = 1;
                }
            }
        }
        return $artEff;
    }

    function modifyExtraVillage($wid, $column, $value)
    {
        return $this->query("UPDATE " . TB_PREFIX . "vdata SET $column=$column+$value WHERE wref=$wid");
    }

    function modifyFieldLevel($wid, $field, $level, $mode)
    {
        $b = 'f' . $field;
        if (!$mode) {
            return $this->query("UPDATE " . TB_PREFIX . "fdata SET $b=$b-$level WHERE vref=" . $wid);
        }
        return $this->query("UPDATE " . TB_PREFIX . "fdata SET $b=$b+$level WHERE vref=" . $wid);
    }

    function modifyFieldType($wid, $field, $type)
    {
        $b = 'f' . $field . 't';
        return $this->query("UPDATE " . TB_PREFIX . "fdata SET $b=$type WHERE vref=" . $wid);
    }

    function resendact($mail)
    {
        $q = "SELECT `email`, `username`, `password`, `id` from " . TB_PREFIX . "users WHERE email = " . $mail . " LIMIT 0,1";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_assoc($result);
        return $dbarray;
    }

    function changemail($mail, $id)
    {
        $q = "UPDATE " . TB_PREFIX . "users set email= '$mail' WHERE id ='$id'";
        mysql_query($q, $this->connection);
    }

    function generateHash($plainText, $salt = 1)
    {
        $salt = substr($salt, 0, 9);
        return $salt . md5($salt . $plainText);
    }

    function register2($username, $password, $email, $act, $activateat)
    {
        $time = $_SERVER['REQUEST_TIME'];
        if (strtotime(START_TIME) > $_SERVER['REQUEST_TIME']) {
            $time = strtotime(START_TIME);
        }
        $timep = ($time + PROTECTION);
        $rand = rand(8900, 9000);
        $q = "INSERT INTO " . TB_PREFIX . "users (username,password,access,email,timestamp,act,protect,fquest,clp,cp,reg2,activateat) VALUES ('$username', '$password', " . USER . ", '$email', $time, '$act', $timep, '0,0,0,0,0,0,0,0,0,0,0', '$rand', 1, 1,$activateat)";
        if (mysql_query($q, $this->connection)) {
            return mysql_insert_id($this->connection);
        } else {
            return false;
        }
    }

    function checkname($id)
    {
        $q = "SELECT `username`, `email` FROM " . TB_PREFIX . "users WHERE id = $id  LIMIT 0,1";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_assoc($result);
        return $dbarray;
    }

    function settribe($tribe, $id)
    {
        $q = "UPDATE " . TB_PREFIX . "users set tribe= '$tribe' WHERE id ='$id' && reg2 = 1";
        mysql_query($q, $this->connection);
    }

    function checkreg($uid)
    {
        $q = "SELECT `reg2` FROM " . TB_PREFIX . "users WHERE id = '" . $uid . "'  LIMIT 0,1";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_assoc($result);
        return $dbarray;
    }

    function checkreg2($name)
    {
        $q = "SELECT `reg2` FROM " . TB_PREFIX . "users WHERE username = '" . $name . "'  LIMIT 0,1";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_assoc($result);
        return $dbarray;
    }

    function checkid($name)
    {
        $q = "SELECT `id` FROM " . TB_PREFIX . "users WHERE username = '" . $name . "'  LIMIT 0,1";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_assoc($result);
        return $dbarray;
    }

    function setreg2($id)
    {
        $q = "UPDATE " . TB_PREFIX . "users set reg2= 0 WHERE id ='$id' && reg2 = 1";
        mysql_query($q, $this->connection);
    }

    function getNotice5($uid)
    {
        $q = "SELECT `id` FROM " . TB_PREFIX . "ndata where uid = $uid and viewed = 0 ORDER BY time DESC LIMIT 1";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function setref($id, $name)
    {
        $q = "INSERT into " . TB_PREFIX . "refrence values (0,'$id','$name')";
        mysql_query($q, $this->connection);
        return mysql_insert_id($this->connection);
    }

    function getAttackCasualties($time)
    {
        $q = "SELECT `time` FROM " . TB_PREFIX . "general where shown = 1";
        $casualties = 0;
        $res = mysql_query($q);
        while ($general = mysql_fetch_assoc($res)) {
            if (date("j. M", $time) == date("j. M", $general['time'])) {
                $casualties += $general['casualties'];
            }
        }
        return $casualties;
    }

    function getAttackByDate($time)
    {
        $q = "SELECT `time` FROM " . TB_PREFIX . "general where shown = 1";
        $attack = 0;
        $res = mysql_query($q);
        while ($general = mysql_fetch_assoc($res)) {
            if (date("j. M", $time) == date("j. M", $general['time'])) {
                $attack += 1;
            }
        }
        return $attack * 100;
    }

    function getStatsinfo($uid, $time, $inf)
    {
        $q = "SELECT `$inf`,`time` FROM " . TB_PREFIX . "stats where owner = " . $uid . "";
        $t = 0;
        if ($inf == 'rank') {
            $res = mysql_query($q);
            while ($user = mysql_fetch_assoc($res)) {
                if (date("j. M", $time) == date("j. M", $user['time'])) {
                    $t = $user[$inf];
                    break;
                }
            }
        } else {
            $res = mysql_query($q);
            while ($user = mysql_fetch_assoc($res)) {
                if (date("j. M", $time) == date("j. M", $user['time'])) {
                    $t += $user[$inf];
                }
            }
        }
        return $t;
    }

    function modifyHero2($column, $value, $uid, $mode)
    {
        switch ($mode) {
            case 1:
                $q = "UPDATE " . TB_PREFIX . "hero SET $column = $column + $value WHERE uid = $uid";
                break;
            case 2:
                $q = "UPDATE " . TB_PREFIX . "hero SET $column = $column - $value WHERE uid = $uid";
                break;
            default:
                $q = "UPDATE " . TB_PREFIX . "hero SET $column = $value WHERE uid = $uid";
        }
        return mysql_query($q, $this->connection);
    }

    function createTradeRoute($uid, $wid, $from, $r1, $r2, $r3, $r4, $start, $deliveries, $merchant, $time)
    {
        $x = "UPDATE " . TB_PREFIX . "users SET gold = gold - 2 WHERE id = " . $uid . "";
        mysql_query($x, $this->connection) or die(mysql_error());
        $q = "INSERT into " . TB_PREFIX . "route values (0,$uid,$wid,$from,$r1,$r2,$r3,$r4,$start,$deliveries,$merchant,'$time')";
        return mysql_query($q, $this->connection) or die(mysql_error());
    }

    function getTradeRoute($uid)
    {
        $q = "SELECT * FROM " . TB_PREFIX . "route where uid = $uid ORDER BY timestamp ASC";
        $result = mysql_query($q, $this->connection);
        return $this->mysql_fetch_all($result);
    }

    function getTradeRoute2($id)
    {
        $q = "SELECT * FROM " . TB_PREFIX . "route where id = $id";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_assoc($result);
        return $dbarray;
    }

    function getTradeRouteUid($id)
    {
        $q = "SELECT `uid` FROM " . TB_PREFIX . "route where id = $id";
        $result = mysql_query($q, $this->connection);
        $dbarray = mysql_fetch_assoc($result);
        return $dbarray['uid'];
    }

    function editTradeRoute($id, $column, $value, $mode)
    {
        if (!$mode) {
            $q = "UPDATE " . TB_PREFIX . "route set $column = $value where id = $id";
        } else {
            $q = "UPDATE " . TB_PREFIX . "route set $column = $column + $value where id = $id";
        }
        return mysql_query($q, $this->connection);
    }

    function deleteTradeRoute($id)
    {
        $q = "DELETE FROM " . TB_PREFIX . "route where id = $id";
        return mysql_query($q, $this->connection);
    }

    function getHeroData($uid)
    {
        $q = "SELECT * FROM " . TB_PREFIX . "hero WHERE uid = $uid";
        $result = mysql_query($q, $this->connection);
        return mysql_fetch_assoc($result);
    }

    function getHeroData2($uid)
    {
        $q = "SELECT `heroid` FROM " . TB_PREFIX . "hero WHERE dead = 0 and uid = $uid LIMIT 0, 1";
        $result = mysql_query($q, $this->connection);
        return mysql_fetch_assoc($result);
    }

    function getHeroInVillid($uid, $mode)
    {
        $q = "SELECT `wref`, `name` FROM " . TB_PREFIX . "vdata WHERE owner = " . $uid . " ORDER BY owner";
        $result = mysql_query($q);
        while ($row = mysql_fetch_assoc($result)) {
            $q2 = "SELECT `hero` FROM " . TB_PREFIX . "units WHERE vref = " . $row['wref'] . " ORDER BY vref";
            $result2 = mysql_query($q2);
            while ($row2 = mysql_fetch_assoc($result2)) {
                if ($mode) {
                    if ($row2['hero'] == 1) {
                        $name = $row['name'];
                    }
                } else {
                    if ($row2['hero'] == 1) {
                        $name = $row['wref'];
                    }
                }
            }
        }
        return $name;
    }
}

$database = new MYSQL_DB;
?>