<?php
include_once(dirname(__FILE__) . "/../Database.php");
include_once(dirname(__FILE__) . "/updateResource.php");
function returnunitsComplete()
{
    global $database;
    if (!$database->checkConnection()) {
        throw new Exception(__FILE__ . ' cant connect to database.');
        return;
    }
    $time = $_SERVER['REQUEST_TIME'];
    $q = "SELECT * FROM " . TB_PREFIX . "movement, " . TB_PREFIX . "attacks where " . TB_PREFIX . "movement.proc = '0' and " . TB_PREFIX . "movement.ref = " . TB_PREFIX . "attacks.id and " . TB_PREFIX . "movement.sort_type = '4' and endtime <= $time LIMIT 100";
    $dataarray = $database->query_return($q);

    foreach ($dataarray as $data) {
        $isoasis = $database->isVillageOases($data['to']);
        if ($isoasis) {
            $toMInfo = $database->getOMInfo($data['to']);
        } else {
            $toMInfo = $database->getMInfo($data['to']);
        }
        if (!isset($toMInfo['owner']) || $toMInfo['owner'] == 0 || (!$isoasis && $toMInfo['owner'] != 3 && $toMInfo['pop'] <= 0)) {
            //nothing to do
        } else {
            $tribe = $database->getUserField($toMInfo["owner"], "tribe", 0);
            switch ($tribe) {
                case 1:
                    $u = '';
                    break;
                case 2:
                    $u = '1';
                    break;
                case 3:
                    $u = '2';
                    break;
                case 4:
                    $u = '3';
                    break;
                case 5:
                    $u = '4';
                    break;
            }
            $database->modifyUnit($data['to'], $u . "1", $data['t1'], 1);
            $database->modifyUnit($data['to'], $u . "2", $data['t2'], 1);
            $database->modifyUnit($data['to'], $u . "3", $data['t3'], 1);
            $database->modifyUnit($data['to'], $u . "4", $data['t4'], 1);
            $database->modifyUnit($data['to'], $u . "5", $data['t5'], 1);
            $database->modifyUnit($data['to'], $u . "6", $data['t6'], 1);
            $database->modifyUnit($data['to'], $u . "7", $data['t7'], 1);
            $database->modifyUnit($data['to'], $u . "8", $data['t8'], 1);
            $database->modifyUnit($data['to'], $u . "9", $data['t9'], 1);
            $database->modifyUnit($data['to'], $tribe . "0", $data['t10'], 1);
            $database->modifyUnit($data['to'], "hero", $data['t11'], 1);
        }
        $database->setMovementProc($data['moveid']);
    }

    // Recieve the bounty on type 6.
    $q = "SELECT `to`,`moveid`,`wood`,`clay`,`iron`,`crop` FROM " . TB_PREFIX . "movement, " . TB_PREFIX . "send where " . TB_PREFIX . "movement.ref = " . TB_PREFIX . "send.id and " . TB_PREFIX . "movement.proc = 0 and sort_type = 6 and endtime <= $time LIMIT 100";
    $dataarray = $database->query_return($q);
    foreach ($dataarray as $data) {
        $isoasis = $database->isVillageOases($data['to']);
        if ($isoasis) {
            $toMInfo = $database->getOMInfo($data['to']);
        } else {
            $toMInfo = $database->getMInfo($data['to']);
        }
        if (!isset($toMInfo['owner']) || $toMInfo['owner'] == 0 || ($toMInfo['owner'] != 3 && $toMInfo['pop'] <= 0)) {
            //nothing to do
        } else {
            $database->modifyResource($data['to'], $data['wood'], $data['clay'], $data['iron'], $data['crop'], 1);
        }
        $database->setMovementProc($data['moveid']);
       updateWrefResource($data['to']);
    }
}

?>
