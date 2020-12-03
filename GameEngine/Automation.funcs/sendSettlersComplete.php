<?php
include_once(dirname(__FILE__) . "/../Database.php");
include_once(dirname(__FILE__) . "/../Generator.php");
include_once(dirname(__FILE__) . "/../Natars.php");
include_once(dirname(__FILE__) . "/../Data/unitdata.php");
function sendSettlersComplete()
{
    global $database, $generator, $natars;
    if (!$database->checkConnection()) {
        throw new Exception(__FILE__ . ' cant connect to database.');
    }
    $time = time();
    $q = "SELECT `to`,`from`,`moveid`,`endtime` FROM " . TB_PREFIX . "movement where proc = 0 and sort_type = 5 and endtime <= $time LIMIT 50";
    $dataarray = $database->query_return($q);
    foreach ($dataarray as $data) {
        $toMInfo = $database->getMInfo($data['to']);
        $fromMInfo = $database->getMInfo($data['from']);
        if (!isset($fromMInfo['owner']) || $fromMInfo['owner'] == 0 || !isset($fromMInfo['pop']) || $fromMInfo['pop'] <= 0) {
            // nothing to do
        } else {
            $user = $database->getUserField($fromMInfo['owner'], 'username', 0);
            $tribe = $database->getUserField($fromMInfo['owner'], 'tribe', 0);
            if ($toMInfo['occupied'] == 0) {
                $database->setFieldTaken($data['to']);
                $database->addVillage($data['to'], $fromMInfo['owner'], $user, '0');
                $database->addResourceFields($data['to'], $database->getVillageType($data['to']));
                $database->addUnits($data['to']);
                $database->addTech($data['to']);
                $database->addABTech($data['to']);
                $database->setVillageField($data['to'], 'expandedfrom', $data['from']);

                $exp1 = $database->getVillageField($data['from'], 'exp1');
                $exp2 = $database->getVillageField($data['from'], 'exp2');
                $exp3 = $database->getVillageField($data['from'], 'exp3');

                if ($exp1 == 0) {
                    $exp = 'exp1';
                } elseif ($exp2 == 0) {
                    $exp = 'exp2';
                } else {
                    $exp = 'exp3';
                }
                $database->setVillageField($data['from'], $exp, $data['to']);
                $natars->checkGrayAreaInvasion($data['to']);
            } else {
                // here must come movement from returning settlers
                $ref = $database->addAttack($data['from'], 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 3, 0, 0, 0);
                $AttackArrivalTime = $data['endtime'];
                $speeds = array();
                $settelerID = $tribe * 10;
                global ${'u' . $settelerID};
                $speeds[] = ${'u' . $settelerID}['speed'];
                $endtime = $generator->procDistanceTime($fromMInfo, $toMInfo, min($speeds), 1) + $AttackArrivalTime;
                $database->addMovement(4, $data['to'], $data['from'], $ref, '0,0,0,0,0', $endtime);
            }
        }
        $database->setMovementProc($data['moveid']);
    }
}

?>
