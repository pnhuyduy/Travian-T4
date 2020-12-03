<?php
    include_once(dirname(__FILE__) . "/../Database.php");

    function autoauction()
    {
        $t = $_SERVER['REQUEST_TIME'];
        $q = 'SELECT `time`,`lasttime`,`id`,`number` FROM ' . TB_PREFIX . 'autoauction WHERE active = 1';
        $result = mysql_query($q);

        while ($row = mysql_fetch_assoc($result)) {

            if (($row['time'] * 60 + $row['lasttime']) - $t < 0) {

                $btype = $y = $row['id'];

                $item_qty = $row['number'];

                $item_time = $row['time'] * 180;


                switch($btype){
                    case 1:
                        $type = rand(1, 15);
                        break;
                    case 2:
                        $type = rand(82, 93);
                        break;
                    case 3:
                        $type = rand(61, 81);
                        break;
                    case 4:
                        $type = rand(16, 60);
                        break;
                    case 5:
                        $type = rand(94, 102);
                        break;
                    case 6:
                        $type = rand(103, 105);
                        break;
                    case 7:
                        $type = 112;
                        break;
                    case 8:
                        $type = 113;
                        break;
                    case 9:
                        $type = 114;
                        break;
                    case 10:
                        $type = 107;
                        break;
                    case 11:
                        $type = 106;
                        break;
                    case 12:
                        $type = 108;
                        break;
                    case 13:
                        $type = 110;
                        break;
                    case 14:
                        $type = 109;
                        break;
                    case 15:
                        $type = 111;
                        break;

                }

                addAuctionNew(4, $btype, $type, $item_qty, $item_time);

            }
        }
    }

    function addAuctionNew($owner, $btype, $type, $amount, $mtime)
    {
        global $database;
        $time = time() + $mtime;
        $q = "INSERT INTO " . TB_PREFIX . "heroitems (`uid`, `btype`, `type`, `num`, `proc`) VALUES ('$owner', '$btype', '$type', '$amount', 1)";
        mysql_query($q, $database->connection);
        $item_id = mysql_insert_id($database->connection);

        if ($btype == 7 || $btype == 8 || $btype == 9 || $btype == 10 || $btype == 11 || $btype == 13 || $btype == 14) {
            $silver = $amount;
            $q = "INSERT INTO " . TB_PREFIX . "auction (`owner`, `itemid`, `btype`, `type`, `num`, `uid`, `bids`, `silver`, `time`, `finish`) VALUES ('$owner', '$item_id', '$btype', '$type', '$amount', 0, 0, '$silver', '$time', 0)";
            mysql_query($q);
        } else {
            $silver = 100;
            $q = "INSERT INTO " . TB_PREFIX . "auction (`owner`, `itemid`, `btype`, `type`, `num`, `uid`, `bids`, `silver`, `time`, `finish`) VALUES ('$owner', '$item_id', '$btype', '$type', '$amount', 0, 0, '$silver', '$time', 0)";
            mysql_query($q);
        }
        mysql_query("UPDATE " . TB_PREFIX . "autoauction SET lasttime = " . time() . " WHERE id =" . $btype) or die(mysql_error());
    }

?>