<?php
    include_once(dirname(__FILE__) . "/../Database.php");

    function auctionComplete()
    {
        global $database;
        if (!$database->checkConnection()) {
            throw new Exception(__FILE__ . ' cant connect to database.');
        }
        $time = time();
        $q = "SELECT `owner`,`uid`,`silver`,`btype`,`type`,`maxsilver`,`silver`,`num`,`id` FROM " . TB_PREFIX . "auction where finish = 0 and time <= $time LIMIT 100";
        $dataarray = $database->query_return($q);
        foreach ($dataarray as $data) {
            $ownerID = $data['owner'];
            $biderID = $data['uid'];
            $silver = $data['silver'];
            $btype = $data['btype'];
            $type = $data['type'];
            $silverdiff = $data['maxsilver'] - $data['silver'];
            if ($silverdiff < 0) $silverdiff = 0;
            if ($biderID != 0) {
                $id = $database->checkHeroItem($biderID, $btype, $type);
                if ($id) {
                    $database->modifyHeroItem($id, 'num', $data['num'], 1);
                    $database->modifyHeroItem($id, 'proc', 0, 0);
                } else {
                    $database->addHeroItem($biderID, $data['btype'], $data['type'], $data['num']);
                }
                $database->setSilver($biderID, $silverdiff, 1);
                $q = 'UPDATE ' . TB_PREFIX . 'users SET bidsilver=bidsilver-' . $silverdiff . ' WHERE id=' . $biderID;
                mysql_query($q);
            }
            $database->setSilver($ownerID, $silver, 1);
            $q = 'UPDATE ' . TB_PREFIX . 'users SET ausilver=ausilver+' . $silver . ' WHERE id=' . $ownerID;
            mysql_query($q);
            $q = "UPDATE " . TB_PREFIX . "auction set finish=1 where id = " . $data['id'];
            $database->query($q);
        }
    }

?>
