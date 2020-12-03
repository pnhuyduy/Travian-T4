<?php
include_once(dirname(__FILE__) . "/../Database.php");
function checkDB()
{


    $t = $_SERVER['REQUEST_TIME'];
    $q = 'SELECT `last_checkall`, `checkall_time` FROM ' . TB_PREFIX . 'config';
    $result = mysql_query($q);
    if (mysql_num_rows($result)) {
        $row = mysql_fetch_assoc($result);
        $last_checkall = $row['last_checkall'];
        $checkall_time = $row['checkall_time'];
    }
    $TimerM = $checkall_time + $last_checkall;
    if ($t > $TimerM) {
        $time = $t - 43200;
        mysql_query("DELETE FROM " . TB_PREFIX . "ndata WHERE viewed = 1 AND time < $time");
        mysql_query("DELETE FROM " . TB_PREFIX . "movement WHERE endtime < $time AND sort_type!=9");
        // mysql_query("DELETE FROM ".TB_PREFIX."mdata WHERE archived = 0 AND time < $time");
        mysql_query("DELETE FROM " . TB_PREFIX . "adventure WHERE end = 1");
        mysql_query("DELETE FROM " . TB_PREFIX . "auction WHERE finish = 1");
        mysql_query("DELETE FROM " . TB_PREFIX . "chat WHERE date < $time");
        $time = $t - 86400;
        mysql_query("DELETE FROM " . TB_PREFIX . "stats WHERE time < $time");

       /* global $database;
        $q = "SELECT * FROM " . TB_PREFIX . "movement, " . TB_PREFIX . "attacks where (" . TB_PREFIX . "movement.ref = " . TB_PREFIX . "attacks.id and " . TB_PREFIX . "movement.proc = 1) and ( " . TB_PREFIX . "movement.sort_type = 4) ORDER BY endtime DESC LIMIT 300";
        $query = mysql_query($q);

        while($row = mysql_fetch_assoc($query)){
            $database->deleteAttacksFrom($row['from']);
        }
       */

        mysql_query("UPDATE " . TB_PREFIX . "config SET `last_checkall` = '$t' ");
        $alltables = mysql_query("SHOW TABLES");
        // $i = 0;
        while ($table = mysql_fetch_assoc($alltables)) {
            foreach ($table as $db => $tablename) {
                mysql_query('OPTIMIZE TABLE ' . $tablename) or die(mysql_error());
mysql_query('REPAIR TABLE ' . $tablename) or die(mysql_error());
               // mysql_query('ALTER TABLE ' . $tablename . ' ENGINE=myisam' ) or die(mysql_error());
//mysql_query('ALTER TABLE ' . $tablename . ' ROW_FORMAT=FIXED' ) or die(mysql_error());
            }
        }
    }
}

?>