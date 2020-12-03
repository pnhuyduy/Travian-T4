<?php

    include_once(dirname(__FILE__) . "/../Database.php");

    function reportbox()
    {
        global $database;
        if (!$database->checkConnection()) {
            throw new Exception(__FILE__ . ' cant connect to database.');
        }
        //throw new Exception(__FILE__.' thrower.');
        $time = $_SERVER['REQUEST_TIME'];

        $timestamp = $time - 21600;

        $q = "SELECT `id` FROM " . TB_PREFIX . "users WHERE reg2=0 AND timestamp > $timestamp";
        $uarray = $database->query_return($q);

        foreach($uarray as $udata){

            $id = $udata['id'];
            $q = "SELECT `id` FROM " . TB_PREFIX . "ndata WHERE uid=$id order by `time` ASC";
            $harray = $database->query_return($q);

            $counter = count($harray);

            if($counter > 200){
                $max = $counter-200;
                for($i = 0;$i<= $max;$i++){
                    $database->delNotice($harray[$i]['id'], $id);
                }
            }
        }
    }
?>