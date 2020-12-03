<?php
include_once(dirname(__FILE__) . "/../Database.php");
include_once(dirname(__FILE__) . "/../Data/buidata.php");
include_once(dirname(__FILE__) . "/../Data/unitdata.php");
include_once(dirname(__FILE__) . "/../Data/bounty.php");
include_once(dirname(__FILE__) . "/../Generator.php");
include_once(dirname(__FILE__) . "/../Logging.php");

function TradeRoute()
{
    global $database;
    $time = $_SERVER['REQUEST_TIME'];
    $res = mysql_query("SELECT `id`,`from`,`deliveries`,`wood`,`clay,`iron`,`crop`,`wid` FROM " . TB_PREFIX . "route where timestamp < $time");
    while ($data = mysql_fetch_assoc($res)) {
        $database->modifyResource($data['from'], $data['wood'], $data['clay'], $data['iron'], $data['crop'], 0);
        $targettribe = $database->getUserField($database->getVillageField($data['from'], "owner"), "tribe", 0);
        sendResource2($data['wood'], $data['clay'], $data['iron'], $data['crop'], $data['from'], $data['wid'], $targettribe, $data['deliveries']);
        $database->editTradeRoute($data['id'], 'timestamp', TRADE_TIME, 1);
    }
}

function sendResource2($wtrans, $ctrans, $itrans, $crtrans, $from, $to, $tribe, $send)
{
// echo "die";die;
    global $bid28, $database, $generator;
    $availableWood = $database->getWoodAvailable($from);
    $availableClay = $database->getClayAvailable($from);
    $availableIron = $database->getIronAvailable($from);
    $availableCrop = $database->getCropAvailable($from);
    if ($availableWood >= $wtrans AND $availableClay >= $ctrans AND $availableIron >= $itrans AND $availableCrop >= $crtrans) {
        $merchant2 = (getTypeLevel(17, $from) > 0) ? getTypeLevel(17, $from) : 0;
        $used2 = $database->totalMerchantUsed($from);
        $merchantAvail2 = $merchant2 - $used2;
        $maxcarry2 = ($tribe == 1) ? 500 : (($tribe == 2) ? 1000 : 750);
        $maxcarry2 *= TRADER_CAPACITY;
        if (getTypeLevel(28, $from) != 0) {
            $maxcarry2 *= $bid28[getTypeLevel(28, $from)]['attri'] / 100;
        }
        $resource = array($wtrans, $ctrans, $itrans, $crtrans);
        $reqMerc = ceil((array_sum($resource) - 0.1) / $maxcarry2);
        if ($merchantAvail2 != 0 && $reqMerc <= $merchantAvail2) {
            $coor = $database->getCoor($to);
            $coor2 = $database->getCoor($from);
            if ($database->getVillageState($to) == true) {
                $timetaken = $generator->procDistanceTime($coor, $coor2, $tribe, 0);
                $res = $resource[0] + $resource[1] + $resource[2] + $resource[3];
                if ($res != 0) {
                    $resdata = '' . $resource[0] . ',' . $resource[1] . ',' . $resource[2] . ',' . $resource[3];
                    $reference = $database->sendResource($resource[0], $resource[1], $resource[2], $resource[3], $reqMerc, 0);
                    $send = $send - 1;
                    $idi = mysql_insert_id();
                    mysql_query("UPDATE `" . TB_PREFIX . "send` set send='$send' WHERE id = $idi") or die(mysql_error());
                    $database->modifyResource($from, $resource[0], $resource[1], $resource[2], $resource[3], 0);
                    $database->addMovement(0, $from, $to, $reference, $resdata, $_SERVER['REQUEST_TIME'] + $timetaken);
                }
            }
        }
    }
}

?>
