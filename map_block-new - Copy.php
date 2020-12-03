<?php
/**********************************************
/ All Of the Copy Rights Of The Script Is Reserved For vikings.ir
/	You may have made some changes but You Have No Right To remove This Copy Right!
/	For Debug And Support Just Contact Me :09335751872 just sms
/	Yahoo ID: gorz1872@yahoo.com
/
*/

ob_start();
include('GameEngine/Database.php');

$t = 1;

if ($t == 1) {
    session_cache_limiter('public');
}

session_start();

if (
    (isset($_GET['tx0']) && $_GET['tx0'] <= WORLD_MAX && $_GET['tx0'] >= -WORLD_MAX)
    &&
    (isset($_GET['tx1']) && $_GET['tx1'] <= WORLD_MAX && $_GET['tx1'] >= -WORLD_MAX)
    &&
    (isset($_GET['ty0']) && $_GET['ty0'] <= WORLD_MAX && $_GET['ty0'] >= -WORLD_MAX)
    &&
    (isset($_GET['ty1']) && $_GET['ty1'] <= WORLD_MAX && $_GET['ty1'] >= -WORLD_MAX)

) {

    $srcImagePaths = Array();
    $x0 = $_GET['tx0'];
    $y0 = $_GET['ty0'];
    $x1 = $_GET['tx1'];
    $y1 = $_GET['ty1'];
    $i = 0;
    $x1 = $x1;
    $x2 = $x0;

    $til = $x1 - $x0;
    if ($x0 > 0 && $x1 < 0) {
        $x0 = -$x0;
        $til = $x1 - $x0;
        $x2 = -$x2;
        $x0--;
        $x1++;
        $til++;
    }

    if ($y0 > 0 && $y1 < 0) {
        $y0 = -$y0;
        $y0--;
    }

    function locations($loc, $t)
    {
        switch ($t) {
            case 'o1':
                $t3 = 'Ao1';
                break;
            case 'o1-s':
                $t3 = 'Ao1-s';
                break;
            case 'o2':
                $t3 = 'Ao2';
                break;
            case 'o2-s':
                $t3 = 'Ao2-s';
                break;
            case 'o3':
                $t3 = 'Ao3';
                break;
            case 'o3-s':
                $t3 = 'Ao3-s';
                break;
            case 'o4':
                $t3 = 'Ao4';
                break;
            case 'o4-s':
                $t3 = 'Ao4-s';
                break;
            case 'o5':
                $t3 = 'Ao5';
                break;
            case 'o5-s':
                $t3 = 'Ao5-s';
                break;
            case 'o6':
                $t3 = 'Ao6';
                break;
            case 'o6-s':
                $t3 = 'Ao6-s';
                break;
            case 'o7':
                $t3 = 'Ao7';
                break;
            case 'o7-s':
                $t3 = 'Ao7-s';
                break;
            case 'o8':
                $t3 = 'Ao8';
                break;
            case 'o8-s':
                $t3 = 'Ao8-s';
                break;
            case 'o9':
                $t3 = 'Ao9';
                break;
            case 'o9-s':
                $t3 = 'Ao9-s';
                break;
            case 'o10':
                $t3 = 'Ao10';
                break;
            case 'o10-s':
                $t3 = 'Ao11-s';
                break;
            case 'o11':
                $t3 = 'Ao11';
                break;
            case 'o11-s':
                $t3 = 'A12-s';
                break;
            case 'o12':
                $t3 = 'Ao12';
                break;
            case 'o12-s':
                $t3 = 'Ao12-s';
                break;
            case 'd00-1':
                $t3 = 'Ad00-1';
                break;
            case 'd00-2':
                $t3 = 'Ad00-2';
                break;
            case 'd00-3':
                $t3 = 'Ad00-3';
                break;
            case 'd14-1':
                $t3 = 'Ad00-1';
                break;
            case 'd14-2':
                $t3 = 'Ad10-2';
                break;
            case 'd14-3':
                $t3 = 'Ad10-3';
                break;
            case 'd14-4':
                $t3 = 'Ad10-4';
                break;
            case 'd20-1':
                $t3 = 'Ad20-1';
                break;
            case 'd20-2':
                $t3 = 'Ad20-2';
                break;
            case 'd20-3':
                $t3 = 'Ad20-3';
                break;
            case 'd20-4':
                $t3 = 'Ad20-4';
                break;
            case 'd24-1':
                $t3 = 'Ad10-1';
                break;
            case 'd24-2':
                $t3 = 'Ad10-2';
                break;
            case 'd24-3':
                $t3 = 'Ad10-3';
                break;
            case 'd34-1':
                $t3 = 'Ad20-1';
                break;
            case 'd34-2':
                $t3 = 'Ad00-2';
                break;
            case 'd34-3':
                $t3 = 'Ad20-3';
                break;
            case 'dnatars':
                $t3 = 'Ad00-4';
                break;
        }
        if (isset($t3)) return (GP_LOCATE . "/img/" . $loc . "/" . $t3 . ".gif");
    }

    while ($y1 >= $y0 && $x0 <= $x1) {
        $query = "SELECT `id` FROM " . TB_PREFIX . "wdata WHERE x='" . $x0 . "' AND y='" . $y1 . "' LIMIT 1";
        $result = mysql_query($query) or die(mysql_error());
        $row = mysql_fetch_assoc($result);

        $row = $database->getMInfo($row['id']);
        $tribe = $username = $targetalliance = $oasisowner = $friendarray = $enemyarray = $neutralarray = $row2 = '';

        $tribezz = $database->getUserField($row['owner'], "tribe", 0);

        if ($row['occupied'] > 0 && $row['fieldtype'] >= 0) {
            $targetalliance = $database->getUserField($row['owner'], "alliance", 0);
            $tribe = $database->getUserField($row['owner'], "tribe", 0);
            // echo $tribe;
            $username = $database->getUserField($row['owner'], "username", 0);
            $oasisowner = $database->getUserField($row['owner'], "username", 0);
            $friendarray = array();
            $enemyarray = array();
            $neutralarray = array();
            $row2 = $database->getOMInfo($row['id']);
        }
        $t3 = '';

        $t = null;
        $t = ($row['occupied'] == 1 && $row['fieldtype'] > 0) ? (($row['owner'] == $_SESSION['uid']) ? ($row['pop'] >= 100 ? $row['pop'] >= 250 ? $row['pop'] >= 500 ? 'd34-' . $tribe : 'd24-' . $tribe : 'd14-' . $tribe : 'd00-' . $tribe) : (($targetalliance != 0) ? (in_array($targetalliance, $friendarray) ? ($row['pop'] >= 100 ? $row['pop'] >= 250 ? $row['pop'] >= 500 ? 'd31-' . $tribe : 'd21-' . $tribe : 'd11-' . $tribe : 'd01-' . $tribe) : (in_array($targetalliance, $enemyarray) ? ($row['pop'] >= 100 ? $row['pop'] >= 250 ? $row['pop'] >= 500 ? 'd32-' . $tribe : 'd22-' . $tribe : 'd12-' . $tribe : 'd02-' . $tribe) : (in_array($targetalliance, $neutralarray) ? ($row['pop'] >= 100 ? $row['pop'] >= 250 ? $row['pop'] >= 500 ? 'd35-' . $tribe : 'd25-' . $tribe : 'd15-' . $tribe : 'd05-' . $tribe) : ($targetalliance == $session->alliance ? ($row['pop'] >= 100 ? $row['pop'] >= 250 ? $row['pop'] >= 500 ? 'd33-' . $tribe : 'd23-' . $tribe : 'd13-' . $tribe : 'd03-' . $tribe) : ($row['pop'] >= 100 ? $row['pop'] >= 250 ? $row['pop'] >= 500 ? 'd34-' . $tribe : 'd24-' . $tribe : 'd14-' . $tribe : 'd00-' . $tribe))))) : ($row['pop'] >= 100 ? $row['pop'] >= 250 ? $row['pop'] >= 500 ? 'd34-' . $tribe : 'd24-' . $tribe : 'd14-' . $tribe : 'd00-' . $tribe))) : $row['image'];
        if (strpos($t, '-') !== FALSE) {
            $loc = 'map';
        } else {
            $loc = 'm';
        }

        if ($row['owner'] == 2 || $tribezz == 5) {
            $t = 'dnatars';
        }
        if ($row['occupied'] == 1 && $loc == 'm') {
            $t .= '-s';
        }

        $t = 't0';
        $loc = 'm';

        $t2 = GP_LOCATE . "img/" . $loc . "/" . $t . ".gif";

        if ($y1 < 23 && $y1 > -23) {
            $text = preg_match("/o/i", $t);
            $text2 = preg_match("/d/i", $t);

            if ($text) {
                $t4 = 't1';
            } elseif ($text2) {
                $t4 = 't1';
            } else {
                $t4 = $t;
            }
            switch ($y1) {
                case 22:
                    if ($x0 < 4 && $x0 > -4) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -4) $t2 = GP_LOCATE . "/img/map/zxcasd.gif";
                    if ($x0 == 4) $t2 = GP_LOCATE . "/img/map/dasds2.gif";
                    if ($x0 <= 4 && $x0 >= -4) $t3 = locations($loc, $t);
                    break;
                case 21:
                    if ($x0 <= 5 && $x0 >= -5) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 4 && $x0 < 8) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -4 && $x0 > -8) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -8) $t2 = GP_LOCATE . "/img/map/zxcasd.gif";
                    if ($x0 == 8) $t2 = GP_LOCATE . "/img/map/dasds2.gif";
                    if ($x0 <= 8 && $x0 >= -8) $t3 = locations($loc, $t);
                    break;
                case 20:
                    if ($x0 <= 8 && $x0 >= -8) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 8 && $x0 < 10) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -8 && $x0 > -10) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -10) $t2 = GP_LOCATE . "/img/map/zxcasd.gif";
                    if ($x0 == 10) $t2 = GP_LOCATE . "/img/map/dasds2.gif";
                    if ($x0 <= 10 && $x0 >= -10) $t3 = locations($loc, $t);
                    break;
                case 19:
                    if ($x0 <= 10 && $x0 >= -10) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 10 && $x0 < 12) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -10 && $x0 > -12) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -12) $t2 = GP_LOCATE . "/img/map/zxcasd.gif";
                    if ($x0 == 12) $t2 = GP_LOCATE . "/img/map/dasds2.gif";
                    if ($x0 <= 12 && $x0 >= -12) $t3 = locations($loc, $t);
                    break;
                case 18:
                    if ($x0 <= 12 && $x0 >= -12) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 12 && $x0 < 13) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -12 && $x0 > -13) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -13) $t2 = GP_LOCATE . "/img/map/zxcasd.gif";
                    if ($x0 == 13) $t2 = GP_LOCATE . "/img/map/dasds2.gif";
                    if ($x0 <= 13 && $x0 >= -13) $t3 = locations($loc, $t);
                    break;
                case 17:
                    if ($x0 <= 13 && $x0 >= -13) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 13 && $x0 < 14) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -13 && $x0 > -14) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -14) $t2 = GP_LOCATE . "/img/map/zxcasd.gif";
                    if ($x0 == 14) $t2 = GP_LOCATE . "/img/map/dasds2.gif";
                    if ($x0 <= 14 && $x0 >= -14) $t3 = locations($loc, $t);
                    break;
                case 16:
                    if ($x0 <= 14 && $x0 >= -14) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 14 && $x0 < 15) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -14 && $x0 > -15) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -15) $t2 = GP_LOCATE . "/img/map/zxcasd.gif";
                    if ($x0 == 15) $t2 = GP_LOCATE . "/img/map/dasds2.gif";
                    if ($x0 <= 15 && $x0 >= -15) $t3 = locations($loc, $t);
                    break;
                case 15:
                    if ($x0 <= 15 && $x0 >= -15) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 15 && $x0 < 16) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -15 && $x0 > -16) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -16) $t2 = GP_LOCATE . "/img/map/zxcasd.gif";
                    if ($x0 == 16) $t2 = GP_LOCATE . "/img/map/dasds2.gif";
                    if ($x0 <= 16 && $x0 >= -16) $t3 = locations($loc, $t);
                    break;
                case 14:
                    if ($x0 <= 16 && $x0 >= -16) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 16 && $x0 < 17) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -16 && $x0 > -17) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -17) $t2 = GP_LOCATE . "/img/map/zxcasd.gif";
                    if ($x0 == 17) $t2 = GP_LOCATE . "/img/map/dasds2.gif";
                    if ($x0 <= 17 && $x0 >= -17) $t3 = locations($loc, $t);
                    break;
                case 13:
                    if ($x0 <= 17 && $x0 >= -17) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 17 && $x0 < 18) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -17 && $x0 > -18) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -18) $t2 = GP_LOCATE . "/img/map/zxcasd.gif";
                    if ($x0 == 18) $t2 = GP_LOCATE . "/img/map/dasds2.gif";
                    if ($x0 <= 18 && $x0 >= -18) $t3 = locations($loc, $t);
                    break;
                case 12:
                    if ($x0 <= 18 && $x0 >= -18) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 18 && $x0 < 19) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -18 && $x0 > -19) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -19) $t2 = GP_LOCATE . "/img/map/dasds2r.gif";
                    if ($x0 == 19) $t2 = GP_LOCATE . "/img/map/dasds2.gif";
                    if ($x0 <= 19 && $x0 >= -19) $t3 = locations($loc, $t);
                    break;
                case 11:
                    if ($x0 <= 18 && $x0 >= -18) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 18 && $x0 < 19) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -18 && $x0 > -19) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -19) $t2 = GP_LOCATE . "/img/map/xcas.gif";
                    if ($x0 == 19) $t2 = GP_LOCATE . "/img/map/asda22sd.gif";
                    if ($x0 <= 19 && $x0 >= -19) $t3 = locations($loc, $t);
                    break;
                case 10:
                    if ($x0 <= 19 && $x0 >= -19) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 19 && $x0 < 20) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -19 && $x0 > -20) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -20) $t2 = GP_LOCATE . "/img/map/dasds2r.gif";
                    if ($x0 == 20) $t2 = GP_LOCATE . "/img/map/dasds2.gif";
                    if ($x0 <= 20 && $x0 >= -20) $t3 = locations($loc, $t);
                    break;
                case 9:
                    if ($x0 <= 19 && $x0 >= -19) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 19 && $x0 < 20) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -19 && $x0 > -20) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -20) $t2 = GP_LOCATE . "/img/map/xcas.gif";
                    if ($x0 == 20) $t2 = GP_LOCATE . "/img/map/asda22sd.gif";
                    if ($x0 <= 20 && $x0 >= -20) $t3 = locations($loc, $t);
                    break;
                case 8:
                    if ($x0 <= 20 && $x0 >= -20) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 20 && $x0 < 21) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -20 && $x0 > -21) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -21) $t2 = GP_LOCATE . "/img/map/dasds2r.gif";
                    if ($x0 == 21) $t2 = GP_LOCATE . "/img/map/dasds2.gif";
                    if ($x0 <= 21 && $x0 >= -21) $t3 = locations($loc, $t);
                    break;
                case 7:
                    if ($x0 <= 20 && $x0 >= -20) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 20 && $x0 < 21) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -20 && $x0 > -21) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -21) $t2 = GP_LOCATE . "/img/map/xcas.gif";
                    if ($x0 == 21) $t2 = GP_LOCATE . "/img/map/asda22sd.gif";
                    if ($x0 <= 21 && $x0 >= -21) $t3 = locations($loc, $t);
                    break;
                case 6:
                    if ($x0 <= 20 && $x0 >= -20) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 20 && $x0 < 21) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -20 && $x0 > -21) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -21) $t2 = GP_LOCATE . "/img/map/xcas.gif";
                    if ($x0 == 21) $t2 = GP_LOCATE . "/img/map/asda22sd.gif";
                    if ($x0 <= 21 && $x0 >= -21) $t3 = locations($loc, $t);
                    break;
                case 5:
                    if ($x0 <= 20 && $x0 >= -20) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 20 && $x0 < 21) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -20 && $x0 > -21) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -21) $t2 = GP_LOCATE . "/img/map/xcas.gif";
                    if ($x0 == 21) $t2 = GP_LOCATE . "/img/map/asda22sd.gif";
                    if ($x0 <= 21 && $x0 >= -21) $t3 = locations($loc, $t);
                    break;
                case 4:
                    if ($x0 <= 21 && $x0 >= -21) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 21 && $x0 < 22) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -21 && $x0 > -22) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -22) $t2 = GP_LOCATE . "/img/map/dasds2r.gif";
                    if ($x0 == 22) $t2 = GP_LOCATE . "/img/map/dasds2.gif";
                    if ($x0 <= 22 && $x0 >= -22) $t3 = locations($loc, $t);
                    break;
                case 3:
                    if ($x0 <= 21 && $x0 >= -21) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 21 && $x0 < 22) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -21 && $x0 > -22) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -22) $t2 = GP_LOCATE . "/img/map/xcas.gif";
                    if ($x0 == 22) $t2 = GP_LOCATE . "/img/map/asda22sd.gif";
                    if ($x0 <= 22 && $x0 >= -22) $t3 = locations($loc, $t);
                    break;
                case 2:
                    if ($x0 <= 21 && $x0 >= -21) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 21 && $x0 < 22) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -21 && $x0 > -22) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -22) $t2 = GP_LOCATE . "/img/map/xcas.gif";
                    if ($x0 == 22) $t2 = GP_LOCATE . "/img/map/asda22sd.gif";
                    if ($x0 <= 22 && $x0 >= -22) $t3 = locations($loc, $t);
                    break;
                case 1:
                    if ($x0 <= 21 && $x0 >= -21) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 21 && $x0 < 22) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -21 && $x0 > -22) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -22) $t2 = GP_LOCATE . "/img/map/xcas.gif";
                    if ($x0 == 22) $t2 = GP_LOCATE . "/img/map/asda22sd.gif";
                    if ($x0 <= 22 && $x0 >= -22) $t3 = locations($loc, $t);
                    break;
                case 0:
                    if ($x0 <= 21 && $x0 >= -21) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 21 && $x0 < 22) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -21 && $x0 > -22) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -22) $t2 = GP_LOCATE . "/img/map/xcas.gif";
                    if ($x0 == 22) $t2 = GP_LOCATE . "/img/map/asda22sd.gif";
                    if ($x0 <= 22 && $x0 >= -22) $t3 = locations($loc, $t);
                    break;
                case -1:
                    if ($x0 <= 21 && $x0 >= -21) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 21 && $x0 < 22) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -21 && $x0 > -22) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -22) $t2 = GP_LOCATE . "/img/map/xcas.gif";
                    if ($x0 == 22) $t2 = GP_LOCATE . "/img/map/asda22sd.gif";
                    if ($x0 <= 22 && $x0 >= -22) $t3 = locations($loc, $t);
                    break;
                case -2:
                    if ($x0 <= 21 && $x0 >= -21) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 21 && $x0 < 22) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -21 && $x0 > -22) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -22) $t2 = GP_LOCATE . "/img/map/xcas.gif";
                    if ($x0 == 22) $t2 = GP_LOCATE . "/img/map/asda22sd.gif";
                    if ($x0 <= 22 && $x0 >= -22) $t3 = locations($loc, $t);
                    break;
                case -3:
                    if ($x0 <= 21 && $x0 >= -21) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 21 && $x0 < 22) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -21 && $x0 > -22) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -22) $t2 = GP_LOCATE . "/img/map/xcas.gif";
                    if ($x0 == 22) $t2 = GP_LOCATE . "/img/map/asda22sd.gif";
                    if ($x0 <= 22 && $x0 >= -22) $t3 = locations($loc, $t);
                    break;
                case -4:
                    if ($x0 <= 21 && $x0 >= -21) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 21 && $x0 < 22) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -21 && $x0 > -22) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -22) $t2 = GP_LOCATE . "/img/map/m1.gif";
                    if ($x0 == 22) $t2 = GP_LOCATE . "/img/map/m1sd.gif";
                    if ($x0 <= 22 && $x0 >= -22) $t3 = locations($loc, $t);
                    break;
                case -5:
                    if ($x0 <= 20 && $x0 >= -20) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 20 && $x0 < 21) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -20 && $x0 > -21) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -21) $t2 = GP_LOCATE . "/img/map/xcas.gif";
                    if ($x0 == 21) $t2 = GP_LOCATE . "/img/map/asda22sd.gif";
                    if ($x0 <= 21 && $x0 >= -21) $t3 = locations($loc, $t);
                    break;
                case -6:
                    if ($x0 <= 20 && $x0 >= -20) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 20 && $x0 < 21) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -20 && $x0 > -21) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -21) $t2 = GP_LOCATE . "/img/map/xcas.gif";
                    if ($x0 == 21) $t2 = GP_LOCATE . "/img/map/asda22sd.gif";
                    if ($x0 <= 21 && $x0 >= -21) $t3 = locations($loc, $t);
                    break;
                case -7:
                    if ($x0 <= 20 && $x0 >= -20) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 20 && $x0 < 21) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -20 && $x0 > -21) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -21) $t2 = GP_LOCATE . "/img/map/xcas.gif";
                    if ($x0 == 21) $t2 = GP_LOCATE . "/img/map/asda22sd.gif";
                    if ($x0 <= 21 && $x0 >= -21) $t3 = locations($loc, $t);
                    break;
                case -8:
                    if ($x0 <= 20 && $x0 >= -20) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 20 && $x0 < 21) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -20 && $x0 > -21) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -21) $t2 = GP_LOCATE . "/img/map/m1.gif";
                    if ($x0 == 21) $t2 = GP_LOCATE . "/img/map/m1sd.gif";
                    if ($x0 <= 21 && $x0 >= -21) $t3 = locations($loc, $t);
                    break;
                case -9:
                    if ($x0 <= 19 && $x0 >= -19) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 19 && $x0 < 20) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -19 && $x0 > -20) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -20) $t2 = GP_LOCATE . "/img/map/xcas.gif";
                    if ($x0 == 20) $t2 = GP_LOCATE . "/img/map/asda22sd.gif";
                    if ($x0 <= 20 && $x0 >= -20) $t3 = locations($loc, $t);
                    break;
                case -10:
                    if ($x0 <= 19 && $x0 >= -19) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 19 && $x0 < 20) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -19 && $x0 > -20) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -20) $t2 = GP_LOCATE . "/img/map/m1.gif";
                    if ($x0 == 20) $t2 = GP_LOCATE . "/img/map/m1sd.gif";
                    if ($x0 <= 20 && $x0 >= -20) $t3 = locations($loc, $t);
                    break;
                case -11:
                    if ($x0 <= 18 && $x0 >= -18) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 18 && $x0 < 19) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -18 && $x0 > -19) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -19) $t2 = GP_LOCATE . "/img/map/xcas.gif";
                    if ($x0 == 19) $t2 = GP_LOCATE . "/img/map/asda22sd.gif";
                    if ($x0 <= 19 && $x0 >= -19) $t3 = locations($loc, $t);
                    break;
                case -12:
                    if ($x0 <= 18 && $x0 >= -18) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 18 && $x0 < 19) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -18 && $x0 > -19) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -19) $t2 = GP_LOCATE . "/img/map/m1.gif";
                    if ($x0 == 19) $t2 = GP_LOCATE . "/img/map/m1sd.gif";
                    if ($x0 <= 19 && $x0 >= -19) $t3 = locations($loc, $t);
                    break;
                case -13:
                    if ($x0 <= 17 && $x0 >= -17) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 17 && $x0 < 18) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -17 && $x0 > -18) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -18) $t2 = GP_LOCATE . "/img/map/m1.gif";
                    if ($x0 == 18) $t2 = GP_LOCATE . "/img/map/m1sd.gif";
                    if ($x0 <= 18 && $x0 >= -18) $t3 = locations($loc, $t);
                    break;
                case -14:
                    if ($x0 <= 16 && $x0 >= -16) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 16 && $x0 < 17) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -16 && $x0 > -17) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -17) $t2 = GP_LOCATE . "/img/map/m1.gif";
                    if ($x0 == 17) $t2 = GP_LOCATE . "/img/map/m1sd.gif";
                    if ($x0 <= 17 && $x0 >= -17) $t3 = locations($loc, $t);
                    break;
                case -15:
                    if ($x0 <= 15 && $x0 >= -15) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 15 && $x0 < 16) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -15 && $x0 > -16) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -16) $t2 = GP_LOCATE . "/img/map/m1.gif";
                    if ($x0 == 16) $t2 = GP_LOCATE . "/img/map/m1sd.gif";
                    if ($x0 <= 16 && $x0 >= -16) $t3 = locations($loc, $t);
                    break;
                case -16:
                    if ($x0 <= 14 && $x0 >= -14) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 14 && $x0 < 15) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -14 && $x0 > -15) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -15) $t2 = GP_LOCATE . "/img/map/m1.gif";
                    if ($x0 == 15) $t2 = GP_LOCATE . "/img/map/m1sd.gif";
                    if ($x0 <= 15 && $x0 >= -15) $t3 = locations($loc, $t);
                    break;
                case -17:
                    if ($x0 <= 13 && $x0 >= -13) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 13 && $x0 < 14) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -13 && $x0 > -14) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -14) $t2 = GP_LOCATE . "/img/map/m1.gif";
                    if ($x0 == 14) $t2 = GP_LOCATE . "/img/map/m1sd.gif";
                    if ($x0 <= 14 && $x0 >= -14) $t3 = locations($loc, $t);
                    break;
                case -18:
                    if ($x0 <= 12 && $x0 >= -12) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 12 && $x0 < 13) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 < -12 && $x0 > -13) $t2 = GP_LOCATE . "/img/map/ddsd.gif";
                    if ($x0 == -13) $t2 = GP_LOCATE . "/img/map/m1.gif";
                    if ($x0 == 13) $t2 = GP_LOCATE . "/img/map/m1sd.gif";
                    if ($x0 <= 13 && $x0 >= -14) $t3 = locations($loc, $t);
                    break;
                case -19:
                    if ($x0 <= 10 && $x0 >= -10) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 10 && $x0 < 12) $t2 = GP_LOCATE . "/img/map/asdasd.gif";
                    if ($x0 < -10 && $x0 > -12) $t2 = GP_LOCATE . "/img/map/asdasd.gif";
                    if ($x0 == -12) $t2 = GP_LOCATE . "/img/map/m1.gif";
                    if ($x0 == 12) $t2 = GP_LOCATE . "/img/map/m1sd.gif";
                    if ($x0 <= 12 && $x0 >= -12) $t3 = locations($loc, $t);
                    break;
                case -20:
                    if ($x0 <= 8 && $x0 >= -8) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 8 && $x0 < 10) $t2 = GP_LOCATE . "/img/map/asdasd.gif";
                    if ($x0 < -8 && $x0 > -10) $t2 = GP_LOCATE . "/img/map/asdasd.gif";
                    if ($x0 == -10) $t2 = GP_LOCATE . "/img/map/m1.gif";
                    if ($x0 == 10) $t2 = GP_LOCATE . "/img/map/m1sd.gif";
                    if ($x0 <= 10 && $x0 >= -10) $t3 = locations($loc, $t);
                    break;
                case -21:
                    if ($x0 <= 5 && $x0 >= -5) $t2 = GP_LOCATE . "/img/map/A" . $t4 . ".gif";
                    if ($x0 > 4 && $x0 < 8) $t2 = GP_LOCATE . "/img/map/asdasd.gif";
                    if ($x0 < -4 && $x0 > -8) $t2 = GP_LOCATE . "/img/map/asdasd.gif";
                    if ($x0 == -8) $t2 = GP_LOCATE . "/img/map/m1.gif";
                    if ($x0 == 8) $t2 = GP_LOCATE . "/img/map/m1sd.gif";
                    if ($x0 <= 8 && $x0 >= -8) $t3 = locations($loc, $t);
                    break;
                case -22:
                    if ($x0 < 4 && $x0 > -4) $t2 = GP_LOCATE . "/img/map/asdasd.gif";
                    if ($x0 == -4) $t2 = GP_LOCATE . "/img/map/m1.gif";
                    if ($x0 == 4) $t2 = GP_LOCATE . "/img/map/m1sd.gif";
                    if ($x0 <= 4 && $x0 >= -4) $t3 = locations($loc, $t);
                    break;
            }
        }
        //volcano image
        switch ($y1) {
            case 1:
                switch ($x0) {
                    case -1:
                        $t2 = GP_LOCATE . "/img/map/v/v1.gif";
                        break;
                    case 0:
                        $t2 = GP_LOCATE . "/img/map/v/v2.gif";
                        break;
                    case 1:
                        $t2 = GP_LOCATE . "/img/map/v/v3.gif";
                        break;
                }
                break;
            case 0:
                switch ($x0) {
                    case -2:
                        $t2 = GP_LOCATE . "/img/map/v/v4.gif";
                        break;
                    case -1:
                        $t2 = GP_LOCATE . "/img/map/v/v5.gif";
                        break;
                    case 0:
                        $t2 = GP_LOCATE . "/img/map/v/v6.gif";
                        break;
                    case 1:
                        $t2 = GP_LOCATE . "/img/map/v/v7.gif";
                        break;
                    case 2:
                        $t2 = GP_LOCATE . "/img/map/v/v8.gif";
                        break;
                }
                break;
            case -1:
                switch ($x0) {
                    case -2:
                        $t2 = GP_LOCATE . "/img/map/v/v9.gif";
                        break;
                    case -1:
                        $t2 = GP_LOCATE . "/img/map/v/v10.gif";
                        break;
                    case 0:
                        $t2 = GP_LOCATE . "/img/map/v/v11.gif";
                        break;
                    case 1:
                        $t2 = GP_LOCATE . "/img/map/v/v12.gif";
                        break;
                    case 2:
                        $t2 = GP_LOCATE . "/img/map/v/v13.gif";
                        break;
                }
                break;
            case -2:
                switch ($x0) {
                    case -2:
                        $t2 = GP_LOCATE . "/img/map/v/v14.gif";
                        break;
                    case -1:
                        $t2 = GP_LOCATE . "/img/map/v/v15.gif";
                        break;
                    case 0:
                        $t2 = GP_LOCATE . "/img/map/v/v16.gif";
                        break;
                    case 1:
                        $t2 = GP_LOCATE . "/img/map/v/v17.gif";
                        break;
                    case 2:
                        $t2 = GP_LOCATE . "/img/map/v/v18.gif";
                        break;
                }
                break;
        }
        $srcImagePaths[$i] = $t2;
        $srcImagePaths2[$i] = $t3;
        // echo $t3;
        $i++;
        $x0++;
        // if($i ==2)break;
        if ($x0 > $x1) {
            $y1--;
            $x0 = $x2;
        }
    }

    $tileWidth = $tileHeight = 60;
    if ($til == 9) {
        $numberOfTiles = 10;
    } else {
        $numberOfTiles = 20;
    }
    $pxBetweenTiles = 0;
    $mapWidth = $mapHeight = ($tileWidth + $pxBetweenTiles) * $numberOfTiles;
    $mapImage = imagecreatetruecolor($mapWidth, $mapHeight);
    $bgColor = imagecolorallocate($mapImage, 50, 40, 0);
    imagefill($mapImage, 0, 0, $bgColor);


    function indexToCoords($index)
    {
        global $tileWidth, $pxBetweenTiles, $leftOffSet, $topOffSet, $numberOfTiles;
        $x = ($index % $numberOfTiles) * ($tileWidth + $pxBetweenTiles) + $leftOffSet;
        $y = floor($index / $numberOfTiles) * ($tileWidth + $pxBetweenTiles) + $topOffSet;

        return Array($x, $y);
    }

    foreach ($srcImagePaths as $index => $srcImagePath) {
        list ($x, $y) = indexToCoords($index);
        $tileImg = imagecreatefromgif($srcImagePath);
        imagecopy($mapImage, $tileImg, $x, $y, 0, 0, $tileWidth, $tileHeight);


        //die;
        //end test//
        imagecopy($mapImage, $tileImg, $x, $y, 0, 0, $tileWidth, $tileHeight);
        imagedestroy($tileImg);
    }

//test//

    $lists = array('lake4','clay6','hill6','lake5');

    for ($i = 0; $i <= 12; $i++) {
        unset($max,$max2);
        $img = GP_LOCATE . "img/mkarte/".$lists[$i].".png";
        $test = imagecreatefrompng($img);
        list($width, $height) = getimagesize($img);

        $width2 = $width - 60;
        $height2 = $height - 60;

        $pic_x_max = ($width) / 60;
        $pic_y_max = ($height) / 60;

        $maxwidth = ((540 - $width) / 60) + 1;
        $maxheight = ((540 - $height) / 60) + 1;

        $tile_list = array(0, 60, 120, 180, 240, 300, 360, 420, 480, 540);

        $start_x = $tile_list[rand(0, $maxwidth)];
        $start_y = $start_y_org = $tile_list[rand(0, $maxheight)];

        for ($ii = 0; $ii <= ($width2 / 60); $ii++) {

            for ($zz = 0; $zz <= ($height2 / 60); $zz++) {
                $max[] = array(0 => $start_x, 1 => $start_y);
                $newmax[$i][] = $start_x.' '.$start_y;
                $start_y += 60;
            }

            $start_x += 60;
            $start_y = $start_y_org;

        }

        if($i > 0) {
            $arraykol = $newmax[$i];

            foreach($newmax[$i] as $newloc => $llp) {
                //echo count($newmax[$i])."<br>";
                $tester = explode(' ',$llp);
                for ($ct = $i - 1; $ct >= 0; $ct--) {
                    foreach ($newmax[$ct] as $newloc2 => $llp2) {
                        $tester2 = explode(' ',$llp2);
                        if($tester2[0] == $tester[0] && $tester2[1] == $tester[1]){
                            $block = 1;
                        }
                    }
                }
            }
            if(isset($block) && $block == 1){
                $block = 0;
                unset($max,$max2);
                continue;
            }
        }

        $start_x = 0;
        $start_y = 0;

        for ($ii = 0; $ii <= ($width2 / 60); $ii++) {

            for ($zz = 0; $zz <= ($height2 / 60); $zz++) {
                $max2[] = array(0 => $start_x, 1 => $start_y--);
                $start_y += 60;
            }
            $start_x += 60;
            $start_y = 0;

        }

        $counter = 0;
        foreach ($max as $res) {

            $x = $max2[$counter][0];
            $y = $max2[$counter][1];
            //echo "'x' => $x, 'y' => $y<br>";
            $to_crop_array = array('x' => $x, 'y' => $y, 'width' => 60, 'height' => 61);
            $tileImg = imagecrop($test, $to_crop_array);
            imagecopy($mapImage, $tileImg, $res[0], $res[1], 0, 0, 60, 60);

            $counter++;
        }

    }

   //die;
    foreach ($srcImagePaths2 as $index => $srcImagePath2) {
        list ($x, $y) = indexToCoords($index);
        $tileImg = imagecreatefromgif($srcImagePath2);
        imagecopy($mapImage, $tileImg, $x, $y, 0, 0, $tileWidth, $tileHeight);
        imagedestroy($tileImg);
    }

    $thumbSize = 600;
    $thumbImage = imagecreatetruecolor($thumbSize, $thumbSize);
    imagecopyresampled($thumbImage, $mapImage, 0, 0, 0, 0, $thumbSize, $thumbSize, $mapWidth, $mapWidth);

    header('Content-type: image/jpeg');
    imagejpeg($thumbImage, null, 85);
    imagedestroy($thumbImage);
    imagedestroy($mapImage);
} else {
    $im = imagecreatetruecolor(1, 1);
    header("Content-Type: image/gif");
    imagegif($im);
    imagedestroy($im);
}
?> 