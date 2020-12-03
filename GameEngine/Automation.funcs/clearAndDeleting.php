<?php
function clearAndDeleting()
{
    global $database;
    if (!$database->checkConnection()) {
        throw new Exception(__FILE__ . ' cant connect to database.');
    }
    $needDelete = $database->getNeedDelete();
    if (count($needDelete) > 0) {
        foreach ($needDelete as $need) {
            $needVillage = $database->getVillagesID($need['uid']); //wref
            foreach ($needVillage as $village) {
                $q = "UPDATE " . TB_PREFIX . "vdata SET `pop`=0,`capital`=0 where wref = " . $village;
                $database->query($q);
            }
            $q = "DELETE FROM " . TB_PREFIX . "mdata where target = " . $need['uid'] . " or owner = " . $need['uid'];
            $database->query($q);
            $q = "DELETE FROM " . TB_PREFIX . "ndata where uid = " . $need['uid'];
            $database->query($q);

            $sitid = $need['uid'];

            /*$resultz = mysql_query("SELECT `id` FROM " . TB_PREFIX . "users WHERE sit1 = $sitid OR sit2 = $sitid");
            if (isset($resultz)) {
                while ($row = mysql_fetch_array($resultz)) {
                    mysql_query("UPDATE " . TB_PREFIX . "users SET `sit1` = 0, `sit2` = 0 WHERE `id` = " . $sitid . "") or die(mysql_error());
                }
            }*/

            $userData = $database->getUser($need['uid'], 1);
            $gold = min($userData['gold'],$userData['boughtgold']);

            if ($gold > 0) {

                include("../Database/connectionbank.php");
                $db_connect = mysql_connect($AppConfig['db']['host'], $AppConfig['db']['user'], $AppConfig['db']['password']);
                mysql_select_db($AppConfig['db']['database'], $db_connect);
                $result1 = mysql_query("SELECT `id` FROM bank");
                if (isset($result1)) {
                    while ($row = mysql_fetch_array($result1)) {
                        $id = $row['id'];
                    }
                    $id2 = ($id + 1);
                }

                $p = rand(1, 9) . rand(1, 9) . rand(1, 9) . rand(1, 9) . "-" . rand(1, 9) . rand(1, 9) . rand(1, 9) . rand(1, 9) . "-" . rand(1, 9) . rand(1, 9) . rand(1, 9) . rand(1, 9) . "-" . rand(1, 9) . rand(1, 9) . rand(1, 9) . rand(1, 9);

                $sql2 = "INSERT INTO `bank` (`id`, `code`, `gold`,`email`,`account`) VALUES ('{$id2}', '{$p}', '$gold','$email','$username')";

                if (!mysql_query($sql2)) {

                } else {

                    $topic = sprintf(PL_TRAVIANBANK, "Bank");
                    $message = sprintf(PL_RECIPTEXT, $userData['username'], $p, $gold);

                    include_once("../Database/connection.php");
                    mysql_connect(SQL_SERVER, SQL_USER, SQL_PASS);
                    mysql_select_db(SQL_DB);
                    mysql_query("UPDATE " . TB_PREFIX . "users SET boughtgold = boughtgold - " . $gold . " WHERE id = '" . $uid . "'");
                    mysql_query("UPDATE " . TB_PREFIX . "users SET gold = gold - " . $gold . " WHERE id = '" . $uid . "'");

                    $headers = "From: " . ADMIN_EMAIL . "\n";
                    mail($userData['email'], $topic, $message, $headers);
                }
            }
            $q = "DELETE FROM " . TB_PREFIX . "users where id = " . $need['uid'];
            $database->query($q);
        }
    }
    $q = "DELETE FROM " . TB_PREFIX . "hero WHERE (SELECT count(id) FROM " . TB_PREFIX . "users WHERE " . TB_PREFIX . "users.id=" . TB_PREFIX . "hero.uid)<=0";
    $database->query($q);
    $q = "DELETE FROM " . TB_PREFIX . "heroface WHERE (SELECT count(id) FROM " . TB_PREFIX . "users WHERE " . TB_PREFIX . "users.id=" . TB_PREFIX . "heroface.uid)<=0";
    $database->query($q);
    $q = "DELETE FROM " . TB_PREFIX . "heroitems WHERE (SELECT count(id) FROM " . TB_PREFIX . "users WHERE " . TB_PREFIX . "users.id=" . TB_PREFIX . "heroitems.uid)<=0";
    $database->query($q);
    $q = "DELETE FROM " . TB_PREFIX . "deleting where uid = " . $need['uid'];
    $database->query($q);
}

?>
