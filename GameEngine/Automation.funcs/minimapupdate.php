<?php
    include_once(dirname(__FILE__) . "/../Database.php");
    $row = mysql_fetch_assoc(mysql_query('SELECT `minimap_time` FROM ' . TB_PREFIX . 'config'));
    $minimap_time = $row['minimap_time'];

    if ($_SERVER['REQUEST_TIME'] > $minimap_time + 7200) {
        global $database;
        $query = "SELECT `wref` FROM " . TB_PREFIX . "vdata";
        $query = $database->query_return($query);
        mysql_query('TRUNCATE x_world');
        foreach ($query as $ss) {
            $query2 = mysql_query("SELECT `x`,`y` FROM " . TB_PREFIX . "wdata where id = " . $ss['wref']);
            $query2 = mysql_fetch_assoc($query2);
            mysql_query("INSERT into x_world (`id`, `x`, `y`) VALUES ('" . $ss['wref'] . "', '" . $query2['x'] . "', '" . $query2['y'] . "') ");
        }
        $time = $_SERVER['REQUEST_TIME'];
        mysql_query("UPDATE " . TB_PREFIX . "config SET `minimap_time` = '" . $time . "' ") or die(mysql_error());
    }
?>