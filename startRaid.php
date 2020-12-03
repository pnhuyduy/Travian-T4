<?php
/**********************************************
/ All Of the Copy Rights Of The Script Is Reserved For vikings.ir
/	You may have made some changes but You Have No Right To remove This Copy Right!
/	For Debug And Support Just Contact Me :09335751872 just sms
/	Yahoo ID: gorz1872@yahoo.com
/
*/
    include("GameEngine/Protection.php");
    include("GameEngine/Data/unitdata.php");
    // include ("GameEngine/Database.php");
    include("GameEngine/Session.php");

    if (time() - $_SESSION['LAST_RAID'] > 60 || !isset($_SESSION['LAST_RAID'])) {
        $winner = $database->hasWinner();
        if ($winner) {
            header("Location: winner.php");
            die;
        }
        if ($session->access < 2) {
            header("Location: banned.php");
            die;
        }

        $slots = $_POST['slot'];
        $lid = $_POST['lid'];
        $getFLData = $database->getFLData($lid);
        $tribe = $database->getUserField($getFLData["owner"], "tribe", 0);
        $start = ($tribe - 1) * 10;
        $end = ($tribe * 10);
        $q = "SELECT * FROM " . TB_PREFIX . "raidlist WHERE lid = " . $lid . "";
        $sql = mysql_query($q) or die(mysql_error());
        while ($row = mysql_fetch_array($sql)) {
            $sid = $row['id'];
            $wref = $row['towref'];

            if ($database->hasBeginnerProtection($wref) != 1) {
                if ($slots[$sid] == 'on') {
                    $avunits = $database->getUnit($getFLData['wref']);
                    $towref = $row['towref'];
                    $isoasis = $database->isVillageOases($towref);
                    $vdata['owner'] = 0;
                    if (!$isoasis) $vdata = $database->getMInfo($towref);
                    if (!$isoasis && $vdata['owner'] == 0) {
                        $database->delSlotFarm($sid);
                        continue;
                    }
                    $eigen = $database->getCoor($getFLData['wref']);
                    $fromXY = array('x' => $eigen['x'], 'y' => $eigen['y']);
                    $ander = $database->getCoor($towref);
                    $toXY = array('x' => $ander['x'], 'y' => $ander['y']);

                    $speeds = array();
                    $canRaid = FALSE;
                    //find slowest unit.
                    for ($i = 1; $i <= 10; $i++) {
                        if ($row['t' . $i] > 0) {
                            if ($avunits['u' . ($start + $i)] >= $row['t' . $i]) {
                                $avunits['u' . ($start + $i)] = $avunits['u' . ($start + $i)] - $row['t' . $i];
                                $database->modifyUnit($getFLData['wref'], ($start + $i), $row['t' . $i], 0);
                                if ($unitarray) {
                                    reset($unitarray);
                                }
                                $unitarray = $GLOBALS["u" . ($start + $i)];
                                $speeds[] = $unitarray['speed'];
                                $canRaid = TRUE;
                            } else {
                                $canRaid = FALSE;
                                break;
                            }
                        }
                    }
                    if ($canRaid == FALSE) continue;

                    $timedif = $generator->procDistanceTime($fromXY, $toXY, min($speeds), 1);
                    $reference = $database->addAttack($getFLData['wref'], $row['t1'], $row['t2'], $row['t3'], $row['t4'], $row['t5'],
                        $row['t6'], $row['t7'], $row['t8'], $row['t9'], $row['t10'], 0, 4, 255, 255, 0);

                    $database->addMovement(3, $getFLData['wref'], $towref, $reference, 0, ($timedif + time()));
                }
            }
        }
        unset($_SESSION['LAST_RAID']);
        $_SESSION['LAST_RAID'] = time();
        $_SESSION['NEXT_AVAILABE'] = time() + 60;
        header("Location: build.php?id=39&t=99");
        die;
    } else {
        header("Location: build.php?id=39&t=99");
        die;
    }
?>
